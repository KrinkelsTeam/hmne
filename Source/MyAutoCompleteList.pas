unit MyAutoCompleteList;

interface
uses  Windows, Messages, SysUtils, Classes, Graphics, Menus,
  SynEditTypes, SynEditKeyCmds, SynEdit;

{ This is my modified version of the TSynAutoComplete component in the
  SynCompletionProposal.pas unit of the SynEdit components }
type
  TSynAutoComplete = class(TObject)
  private
    FShortCut: TShortCut;
    fAutoCompleteList: TStrings;
    fNoNextKey : Boolean;
    FEndOfTokenChr: string;
    procedure SetAutoCompleteList(List: TStrings);
  protected
    function GetPreviousToken(Editor: TCustomSynEdit): string;
  public
    constructor Create;
    destructor destroy; override;
    procedure EditorKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditorKeyPress(Sender: TObject; var Key: char);
    function Execute(token: string; Editor: TCustomSynEdit;
      DeleteToken: Boolean): Boolean;
    procedure GetTokenList(List: TStrings);
    function GetTokenValue(Token: string): string;
    property AutoCompleteList: TStrings read fAutoCompleteList
      write SetAutoCompleteList;
    property EndOfTokenChr: string read FEndOfTokenChr write FEndOfTokenChr;
    property ShortCut: TShortCut read FShortCut write FShortCut;
  end;
implementation

uses
  SynEditTextBuffer;

{ TSynAutoComplete }

constructor TSynAutoComplete.Create;
begin
  FEndOfTokenChr := '';
  fAutoCompleteList := TStringList.Create;
  fNoNextKey := false;
  fShortCut := Menus.ShortCut(Ord(' '), [ssShift]);
end;

destructor TSynAutoComplete.destroy;
begin
  fAutoCompleteList.free;
  inherited;
end;

procedure TSynAutoComplete.EditorKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  ShortCutKey   : Word;
  ShortCutShift : TShiftState;
begin
  ShortCutToKey (fShortCut,ShortCutKey,ShortCutShift);
  if not (Sender as TCustomSynEdit).ReadOnly and
    (Shift = ShortCutShift) and (Key = ShortCutKey) and
    Execute(GetPreviousToken (Sender as TCustomSynEdit),
     Sender as TCustomSynEdit, True) then
  begin
    fNoNextKey := true;
    Key := 0;
  end;
end;

procedure TSynAutoComplete.EditorKeyPress(Sender: TObject; var Key: char);
begin
  if fNoNextKey then begin
    fNoNextKey := false;
    Key := #0;
  end;
end;

Type TProtectedAccessEditor=class(TCustomSynEdit);
function TSynAutoComplete.Execute(token: string; Editor: TCustomSynEdit;
  DeleteToken: Boolean {<-HMRS 05/24/2003}): Boolean;
var
  Temp: string;
  i, j: integer;
  StartOfBlock: tpoint;
  ChangedIndent   : Boolean;
  ChangedTrailing : Boolean;
  TmpOptions : TSynEditorOptions;
  OrigOptions: TSynEditorOptions;
  BeginningSpaceCount : Integer;
  Spacing: String;
  PEditor: TProtectedAccessEditor;
begin
    i := AutoCompleteList.IndexOf(token);
    Result := i >= 0;
    if Result then
    begin
      PEditor:=TProtectedAccessEditor(Editor);
      TmpOptions := Editor.Options;
      OrigOptions:= Editor.Options;
      ChangedIndent   := eoAutoIndent in TmpOptions;
      ChangedTrailing := eoTrimTrailingSpaces in TmpOptions;

      if ChangedIndent then Exclude(TmpOptions, eoAutoIndent);
      if ChangedTrailing then Exclude(TmpOptions, eoTrimTrailingSpaces);

      if ChangedIndent or ChangedTrailing then
        Editor.Options := TmpOptions;

      Editor.UndoList.AddChange(crAutoCompleteBegin, StartOfBlock, StartOfBlock, '',
        smNormal);

      fNoNextKey := true;

      if DeleteToken then  // HMRS 05/24/2003
      for j := 1 to length(token) do
        Editor.CommandProcessor(ecDeleteLastChar, ' ', nil);

      BeginningSpaceCount := Editor.DisplayX - 1;  //GBN 2002/04/24
      if (not (eoTabsToSpaces in Editor.Options)) and (BeginningSpaceCount>=PEditor.TabWidth) then
          Spacing:=StringOfChar(#9,BeginningSpaceCount div PEditor.TabWidth)+StringOfChar(' ',BeginningSpaceCount mod PEditor.TabWidth)
      else Spacing:=StringOfChar(' ',BeginningSpaceCount);

      inc(i);
      StartOfBlock := Point(-1, -1);
      while (i < AutoCompleteList.Count) and
            (length(AutoCompleteList[i]) > 0) and
            (AutoCompleteList[i][1] = '=') do
      begin
  {      for j := 0 to PrevSpace - 1 do
          Editor.CommandProcessor(ecDeleteLastChar, ' ', nil);}
        Temp := AutoCompleteList[i];
        for j := 2 to length(Temp) do begin
          if (Temp[j]=#9) then Editor.CommandProcessor(ecTab, Temp[j], nil)
          else Editor.CommandProcessor(ecChar, Temp[j], nil);
          if (Temp[j] = '|') then
            StartOfBlock := Editor.CaretXY
        end;
        inc(i);
        if (i < AutoCompleteList.Count) and
           (length(AutoCompleteList[i]) > 0) and
           (AutoCompleteList[i][1] = '=') then
        begin
           Editor.CommandProcessor (ecLineBreak,' ',nil);
           for j := 1 to length(Spacing) do
             if (Spacing[j]=#9) then Editor.CommandProcessor(ecTab,#9,nil)
             else Editor.CommandProcessor (ecChar, ' ', nil);
        end;
      end;
      if (StartOfBlock.x <> -1) and (StartOfBlock.y <> -1) then begin
        Editor.CaretXY := StartOfBlock;
        Editor.CommandProcessor(ecDeleteLastChar, ' ', nil);
      end;

      if ChangedIndent or ChangedTrailing then Editor.Options := OrigOptions;

      Editor.UndoList.AddChange(crAutoCompleteEnd, StartOfBlock, StartOfBlock, '',
        smNormal);
      fNoNextKey:=false;   //GBN 2002-03-07
    end;
end;

function TSynAutoComplete.GetPreviousToken(Editor: TCustomSynEdit): string;
var
  s: string;
  i: integer;
begin
  Result := '';
  if Editor <> nil then begin
    s := Editor.LineText;
    i := Editor.CaretX - 1;
    if i <= Length (s) then begin
      while (i > 0) and (s[i] > ' ') and (AnsiPos(s[i], FEndOfTokenChr) = 0) do
        Dec(i);
      Result := copy(s, i + 1, Editor.CaretX - i - 1);
    end;
  end
end;

procedure TSynAutoComplete.SetAutoCompleteList(List: TStrings);
begin
  fAutoCompleteList.Assign(List);
end;

procedure TSynAutoComplete.GetTokenList(List: TStrings);
var
  i: integer;
begin
  if AutoCompleteList.Count < 1 then Exit;
  List.BeginUpdate;
  try
    List.Clear;
    i := 0;
    while (i < AutoCompleteList.Count) do begin
      if (length(AutoCompleteList[i]) > 0) and (AutoCompleteList[i][1] <> '=') then
        List.Add(Trim(AutoCompleteList[i]));
      inc(i);
    end;
  finally
    List.EndUpdate;
  end;
end;

function TSynAutoComplete.GetTokenValue(Token: string): string;
var
  i: integer;
  List: TStringList;
begin
  Result := '';
  i := AutoCompleteList.IndexOf(Token);
  if i <> -1 then begin
    List := TStringList.Create;
    Inc(i);
    while (i < AutoCompleteList.Count) and
      (length(AutoCompleteList[i]) > 0) and
      (AutoCompleteList[i][1] = '=') do begin
      if Length(AutoCompleteList[i]) = 1 then
        List.Add('')
      else
        List.Add(Copy(AutoCompleteList[i], 2, Length(AutoCompleteList[i])));
      inc(i);
    end;
    Result := List.Text;
    List.Free;
  end;
end;

end.
