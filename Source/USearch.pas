{
  HM NIS Edit (c) 2003 Héctor Mauricio Rodríguez Segura <ranametal@users.sourceforge.net>
  For conditions of distribution and use, see license.txt

  Search text form

}
unit USearch;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, SynEdit, SynEditTypes, UMain, NewGroupBox;

type
  TSearchFrm = class(TForm)
    BuscarBtn: TButton;
    CancelarBtn: TButton;
    SearchOptionsBox: TNewGroupBox;
    CaseSensitiveChk: TCheckBox;
    WholeWordChk: TCheckBox;
    SearchFromCursorChk: TCheckBox;
    SearchSelectedOnlyChk: TCheckBox;
    GroupBox1: TNewGroupBox;
    BuscarEdt: TComboBox;
    DirectionRG: TNewGroupBox;
    DirectionRG1: TRadioButton;
    DirectionRG2: TRadioButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure SearchFromCursorChkClick(Sender: TObject);
  private
    {procedure WMLangSet(var Msg: TMessage); message WM_LANG_SET;
    procedure LoadLangStrs;}
  public
    function GetOptions: TSynSearchOptions;
    procedure SetOptions(const Value: TSynSearchOptions);
    procedure Init(SynEdit: TSynEdit);
  end;

var
  LastFoundText: String = '';
  LastSearchOptions: TSynSearchOptions = [];

const
  mrReplaceAll = mrYesToAll;

implementation

uses Utils, UCustomMDIChild;

{$R *.DFM}

var
  SearchHistory: TStrings;

procedure LoadSearchOptions;
begin
  if SearchHistory <> nil then Exit;
  SearchHistory := TStringList.Create;
  SearchHistory.CommaText := OptionsIni.ReadString('State', 'SearchHistory', '');
  if OptionsIni.ReadBool('State', 'SearchOptions1', False) then
    Include(LastSearchOptions, ssoWholeWord);
  if OptionsIni.ReadBool('State', 'SearchOptions2', False) then
    Include(LastSearchOptions, ssoMatchCase);
  if not OptionsIni.ReadBool('State', 'SearchOptions3', False) then
    Include(LastSearchOptions, ssoEntireScope);
  if OptionsIni.ReadBool('State', 'SearchOptions4', False) then
    Include(LastSearchOptions, ssoSelectedOnly);
  if OptionsIni.ReadBool('State', 'SearchOptions5', False) then
    Include(LastSearchOptions, ssoBackwards);
end;

procedure SaveSearchOptions;
begin
  if SearchHistory = nil then Exit;
  OptionsIni.WriteBool('State', 'SearchOptions1', ssoWholeWord in LastSearchOptions);
  OptionsIni.WriteBool('State', 'SearchOptions2', ssoMatchCase in LastSearchOptions);
  OptionsIni.WriteBool('State', 'SearchOptions3', not (ssoEntireScope in LastSearchOptions));
  OptionsIni.WriteBool('State', 'SearchOptions4', ssoSelectedOnly in LastSearchOptions);
  OptionsIni.WriteBool('State', 'SearchOptions5', ssoBackwards in LastSearchOptions);
  Optionsini.WriteString('State', 'SearchHistory', SearchHistory.CommaText);
  SearchHistory.Free;
end;

procedure TSearchFrm.FormCreate(Sender: TObject);
begin
  InitFont(Font);

  Caption := LangStr('FindTextCaption');
  GroupBox1.Caption := LangStr('FindText');
  SearchOptionsBox.Caption := LangStr('SearchOptions');
  BuscarBtn.Caption := LangStr('OK');
  CancelarBtn.Caption := LangStr('Cancel');
  DirectionRG.Caption := LangStr('Direction');
  DirectionRG1.Caption := LangStr('Forward');
  DirectionRG2.Caption := LangStr('Backward');
  WholeWordChk.Caption := LangStr('WholeWordOnly');
  CaseSensitiveChk.Caption := LangStr('CaseSensitive');
  SearchFromCursorChk.Caption := LangStr('SearchFromCursor');
  SearchSelectedOnlyChk.Caption := LangStr('SearchSelectedOnly');

  LoadSearchOptions;
  BuscarEdt.Items.Assign(SearchHistory);
  SetOptions(LastSearchOptions);
end;

function TSearchFrm.GetOptions: TSynSearchOptions;
begin
  Result := [];
  if WholeWordChk.Checked then
    Include(Result, ssoWholeWord);
  if CaseSensitiveChk.Checked then
    Include(Result, ssoMatchCase);
  if not SearchFromCursorChk.Checked then
    Include(Result, ssoEntireScope);
  if SearchSelectedOnlyChk.Checked then
    Include(Result, ssoSelectedOnly);
  if DirectionRG2.Checked then
    Include(Result, ssoBackwards);
end;

procedure TSearchFrm.FormDestroy(Sender: TObject);
var
  I: Integer;
begin
  if ModalResult in [mrOK, mrReplaceAll] then
  begin
    LastFoundText := BuscarEdt.Text;
    LastSearchOptions := GetOptions;
    if LastFoundText <> '' then
    begin
      I := SearchHistory.IndexOf(LastFoundText);
      if  I < 0 then
        SearchHistory.Insert(0, LastFoundText)
      else
        SearchHistory.Move(I, 0);
      while SearchHistory.Count > 20 do
        SearchHistory.Delete(SearchHistory.Count - 1);
    end;
  end;
end;

procedure TSearchFrm.SetOptions(const Value: TSynSearchOptions);
begin
  WholeWordChk.Checked := ssoWholeWord in Value;
  CaseSensitiveChk.Checked := ssoMatchCase in Value;
  SearchFromCursorChk.Checked := not (ssoEntireScope in  Value);
  SearchSelectedOnlyChk.Checked := ssoSelectedOnly in Value;
  SearchFromCursorChkClick(SearchFromCursorChk);
  if ssoBackwards in Value then
    DirectionRG2.Checked := True;
end;

procedure TSearchFrm.Init(SynEdit: TSynEdit);
begin
  SearchSelectedOnlyChk.Enabled := SynEdit.SelAvail;
  if SynEdit.SelAvail then
    BuscarEdt.Text := SynEdit.SelText
  else
    BuscarEdt.Text := SynEdit.WordAtCursor;
end;

procedure TSearchFrm.SearchFromCursorChkClick(Sender: TObject);
begin
  DirectionRG.Controls[0].Enabled := SearchFromCursorChk.Checked;
  DirectionRG.Controls[1].Enabled := SearchFromCursorChk.Checked;  
end;

initialization
finalization
  try SaveSearchOptions except end;
end.
