{
  HM NIS Edit (c) 2003 Héctor Mauricio Rodríguez Segura <ranametal@users.sourceforge.net>
  For conditions of distribution and use, see license.txt

  Plugins management 

}
unit PluginsManger;

interface
uses
  Windows, Messages, SysUtils, Classes, PluginsInt;


type
  TPlugins = class(TObject)
  private
    FPlugins: TList;
    FMsgHookProcs: TList;
    function GetPluginCount: Integer;
    function GetPlugins(Index: Integer): PPluginData;
  public
    constructor Create;
    destructor Destroy; override;
    procedure GetPluginsList(List: TStrings);
    function IsPluginLoaded(const PluginDescription: String): Boolean;
    function Notify(Event: TEvent; Param1: Integer = 0; Param2: Integer = 0;
      Param3: Integer = 0): Integer;
    function MessageHook(const Msg: PMsg): Boolean;
    property PluginCount: Integer read GetPluginCount;
    property Plugins[Index: Integer]: PPluginData read GetPlugins; default;
  end;

var
  Plugins: TPlugins;

implementation
uses Forms, ActnList, SynEditKeyCmds, SynEdit, TB2Item, TB2Toolbar, TBX, UMain,
  Utils, PluginControls;

function CommandProcessor(Command: TEditorCommand; Param1: Integer; Param2: Integer;
  Param3: Integer): Integer; cdecl;

var
  Item: TTBCustomItem;
  SynEdit: TSynEdit;
  TB: TTBCustomToolbar;
  Frm: TForm;
  S: String;

  procedure SynEditCmd(Cmd: Word; aChar: Char = #0; Data: Pointer = nil);
  begin
    MainFrm.CurSynEdit.CommandProcessor(Cmd, aChar, Data);
  end;

begin
  Result := 0;
  try
    case Command of

      // Edit commands
      EC_EDIT_AVAIL: begin
                       SynEdit := MainFrm.CurSynEdit;
                       if SynEdit <> nil then
                         Result := SynEdit.Handle;
                     end;
      EC_EDIT_LEFT: SynEditCmd(ecLeft);
      EC_EDIT_RIGHT: SynEditCmd(ecRight);
      EC_EDIT_UP: SynEditCmd(ecUp);
      EC_EDIT_DOWN: SynEditCmd(ecDown);
      EC_EDIT_WORDLEFT: SynEditCmd(ecWordLeft);
      EC_EDIT_WORDRIGHT: SynEditCmd(ecWordRight);
      EC_EDIT_LINESTART: SynEditCmd(ecLineStart);
      EC_EDIT_LINEEND: SynEditCmd(ecLineEnd);
      EC_EDIT_PAGEUP: SynEditCmd(ecPageUp);
      EC_EDIT_PAGEDOWN: SynEditCmd(ecPageDown);
      EC_EDIT_PAGELEFT: SynEditCmd(ecPageLeft);
      EC_EDIT_PAGERIGHT: SynEditCmd(ecPageRight);
      EC_EDIT_PAGETOP: SynEditCmd(ecPageTop);
      EC_EDIT_PAGEBOTTOM: SynEditCmd(ecPageBottom);
      EC_EDIT_EDITORTOP: SynEditCmd(ecEditorTop);
      EC_EDIT_EDITORBOTTOM: SynEditCmd(ecEditorBottom);

      EC_EDIT_SELLEFT: SynEditCmd(ecSelLeft);
      EC_EDIT_SELRIGHT: SynEditCmd(ecSelRight);
      EC_EDIT_SELUP: SynEditCmd(ecSelUp);
      EC_EDIT_SELDOWN: SynEditCmd(ecSelDown);
      EC_EDIT_SELWORDLEFT: SynEditCmd(ecSelWordLeft);
      EC_EDIT_SELWORDRIGHT: SynEditCmd(ecSelWordRight);
      EC_EDIT_SELLINESTART: SynEditCmd(ecSelLineStart);
      EC_EDIT_SELLINEEND: SynEditCmd(ecSelLineEnd);
      EC_EDIT_SELPAGEUP: SynEditCmd(ecSelPageUp);
      EC_EDIT_SELPAGEDOWN: SynEditCmd(ecSelPageDown);
      EC_EDIT_SELPAGELEFT: SynEditCmd(ecSelPageLeft);
      EC_EDIT_SELPAGERIGHT: SynEditCmd(ecSelPageRight);
      EC_EDIT_SELPAGETOP: SynEditCmd(ecSelPageTop);
      EC_EDIT_SELPAGEBOTTOM: SynEditCmd(ecSelPageBottom);
      EC_EDIT_SELEDITORTOP: SynEditCmd(ecSelEditorTop);
      EC_EDIT_SELEDITORBOTTOM: SynEditCmd(ecSelEditorBottom);

      EC_EDIT_SELECTALL: SynEditCmd(ecSelectAll);

      EC_EDIT_UNDOAVAIL: if MainFrm.CurSynEdit.CanUndo then Result := 1;
      EC_EDIT_REDOAVAIL: if MainFrm.CurSynEdit.CanRedo then Result := 1;
      EC_EDIT_CANPASTE: if MainFrm.CurSynEdit.CanPaste then Result := 1;

      EC_EDIT_UNDO: SynEditCmd(ecUndo);
      EC_EDIT_REDO: SynEditCmd(ecRedo);
      EC_EDIT_CUT:  SynEditCmd(ecCut);
      EC_EDIT_COPY: SynEditCmd(ecCopy);
      EC_EDIT_PASTE:SynEditCmd(ecPaste);

      EC_EDIT_SCROLLUP:  SynEditCmd(ecScrollUp);
      EC_EDIT_SCROLLDOWN: SynEditCmd(ecScrollDown);
      EC_EDIT_SCROLLLEFT: SynEditCmd(ecScrollLeft);
      EC_EDIT_SCROLLRIGHT: SynEditCmd(ecScrollRight);

      EC_EDIT_INSERTMODE: SynEditCmd(ecInsertMode);
      EC_EDIT_OVERWRITEMODE: SynEditCmd(ecOverwriteMode);
      EC_EDIT_TOGGLEMODE: SynEditCmd(ecToggleMode);

      EC_EDIT_NORMALSELECT: SynEditCmd(ecNormalSelect);
      EC_EDIT_COLUMNSELECT: SynEditCmd(ecColumnSelect);
      EC_EDIT_LINESELECT: SynEditCmd(ecLineSelect);

      EC_EDIT_MATCHBRACKET: SynEditCmd(ecMatchBracket);

      EC_EDIT_GOTOBOOKMARK: MainFrm.CurSynEdit.GotoBookMark(Param1);
      EC_EDIT_SETBOOKMARK: with PPoint(Param2)^ do MainFrm.CurSynEdit.SetBookMark(Param1, X, Y);

      EC_EDIT_CONTEXTHELP: SynEditCmd(ecContextHelp, #0, PChar(Param1));

      EC_EDIT_DELETELASTCHAR: SynEditCmd(ecDeleteLastChar);
      EC_EDIT_DELETECHAR: SynEditCmd(ecDeleteChar);
      EC_EDIT_DELETEWORD: SynEditCmd(ecDeleteWord);
      EC_EDIT_DELETELASTWORD: SynEditCmd(ecDeleteLastWord);
      EC_EDIT_DELETEBOL: SynEditCmd(ecDeleteBOL);
      EC_EDIT_DELETEEOL: SynEditCmd(ecDeleteEOL);
      EC_EDIT_CLEARALL: SynEditCmd(ecClearAll);
      EC_EDIT_LINEBREAK: SynEditCmd(ecLineBreak);
      EC_EDIT_CHAR: SynEditCmd(ecChar, PChar(Param1)^);


      EC_EDIT_BLOCKINDENT: SynEditCmd(ecBlockIndent);
      EC_EDIT_BLOCKUNINDENT: SynEditCmd(ecBlockUnindent);

      EC_EDIT_UPPERCASE: SynEditCmd(ecUpperCase);
      EC_EDIT_LOWERCASE: SynEditCmd(ecLowerCase);
      EC_EDIT_TOGGLECASE: SynEditCmd(ecToggleCase);
      EC_EDIT_TITLECASE: SynEditCmd(ecTitleCase);

      EC_EDIT_GETCARETPOS: PPoint(Param1)^ := MainFrm.CurSynEdit.CaretXY;
      EC_EDIT_SETCARETPOS: MainFrm.CurSynEdit.CaretXY := PPoint(Param1)^;
      EC_EDIT_SELAVAIL: if MainFrm.CurSynEdit.SelAvail then Result := 1;
      EC_EDIT_GETTEXTLEN: Result := Length(MainFrm.CurSynEdit.Text);
      EC_EDIT_GETTEXT: begin
                         S := MainFrm.CurSynEdit.Text;
                         if Length(S) + 1 <= Param2 then
                         begin
                           Result := Length(S);
                           CopyMemory(PChar(Param1), PChar(S), Result + 1);
                         end;
                       end;
      EC_EDIT_SETTEXT: begin
                         SetString(S, PChar(Param1), StrLen(PChar(Param1)));
                         SynEdit := MainFrm.CurSynEdit;
                         SynEdit.Text := S;
                         SynEdit.Modified := True;
                       end;
      EC_EDIT_GETSELTEXTLEN: Result := Length(MainFrm.CurSynEdit.SelText);
      EC_EDIT_GETSELTEXT: begin
                            S := MainFrm.CurSynEdit.SelText;
                            if Length(S) + 1 <= Param2 then
                            begin
                              Result := Length(S);
                              CopyMemory(PChar(Param1), PChar(S), Result + 1);
                            end;
                          end;
      EC_EDIT_SETSELTEXT: begin
                           SetString(S, PChar(Param1), StrLen(PChar(Param1)));
                           MainFrm.CurSynEdit.SelText := S;
                         end;

      // Lines
      EC_EDIT_LINECOUNT: Result := MainFrm.CurSynEdit.Lines.Count;
      EC_EDIT_GETLINELENGTH: Result := Length(MainFrm.CurSynEdit.Lines[Param1 - 1]);
      EC_EDIT_GETLINETEXT: begin
                             S := MainFrm.CurSynEdit.Lines[Param1 - 1];
                             if Length(S) + 1 <= Param3 then
                             begin
                               Result := Length(S);
                               CopyMemory(PChar(Param2), PChar(S), Result + 1);
                             end;
                           end;
      EC_EDIT_SETLINETEXT: begin
                             SetString(S, PChar(Param2), StrLen(PChar(Param2)));
                             SynEdit := MainFrm.CurSynEdit;
                             SynEdit.Lines[Param1 - 1] := S;
                             SynEdit.Modified := True;
                           end;
      EC_EDIT_GETTOPLINENUMBER: Result := MainFrm.CurSynEdit.TopLine;
      EC_EDIT_SETTOPLINENUMBER: MainFrm.CurSynEdit.TopLine := Param1;
      EC_EDIT_INSERTLINE: begin
                            SetString(S, PChar(Param2), StrLen(PChar(Param2)));
                            SynEdit := MainFrm.CurSynEdit;
                            if Param1 > 0 then
                              SynEdit.Lines.Insert(Param1 - 1, S)
                            else
                              SynEdit.Lines.Add(S);
                            SynEdit.Modified := True;  
                          end;
      EC_EDIT_DELETELINE: begin
                            SynEdit := MainFrm.CurSynEdit;
                            SynEdit.Lines.Delete(Param1 - 1);
                            SynEdit.Modified := True;
                          end;

      // Toolbar commands
      EC_TB_CREATENEW: TTBXPluginToolbar.CreateTB(PChar(Param1), PChar(Param2));
      EC_TB_REMOVE: begin
                      TB := MainFrm.FindToolBarByName(PChar(Param1));
                      if TB is TTBXPluginToolbar then
                        TB.Free
                      else
                        Abort;
                    end;
      EC_TB_GETSUBITEMCOUNT: Result := MainFrm.FindItemByName(PChar(Param1)).Count;
      EC_TB_CLICKITEM: MainFrm.FindItemByName(PChar(Param1)).Click;
      EC_TB_INSERTITEM: MainFrm.InsertToolBarItem(PChar(Param1), Param2, PTBItemData(Param3));
      EC_TB_REMOVEITEM: begin
                           Item := MainFrm.FindItemByName(PChar(Param1));
                           if Item is TTBXPluginItem then
                           begin
                             Item.Parent.Remove(Item);
                             Item.Free;
                           end
                             else Abort;
                         end;
      EC_TB_GETITEMDATA: PTBItemData(Param2)^ := TTBXPluginItem(MainFrm.FindItemByName(PChar(Param1))).Data;
      EC_TB_SETITEMDATA: TTBXPluginItem(MainFrm.FindItemByName(PChar(Param1))).Data := PTBItemData(Param2)^;
      EC_TB_GETITEMINDEX: begin
                            Item := MainFrm.FindItemByName(PChar(Param1));
                            Result := Item.Parent.IndexOf(Item);
                          end;
      EC_TB_SETITEMINDEX: begin
                             Item := MainFrm.FindItemByName(PChar(Param1));
                             Item.Parent.Move(Item.Parent.IndexOf(Item), Param2);
                           end;
      EC_TB_GETITEMSTATE: Result := GetTBItemState(MainFrm.FindItemByName(PChar(Param1)));
      EC_TB_SETITEMSTATE: TTBXPluginItem(MainFrm.FindItemByName(PChar(Param1))).State := Param2;

      // File commands
      EC_FILE_OPEN:  MainFrm.OpenFile(PChar(Param1));
      EC_FILE_OPENTEMPLATE: MainFrm.OpenTemplate(PChar(Param1));
      EC_FILE_ISFILEOPENED: begin
                              Frm := MainFrm.FindMDIChild(PChar(Param1));
                              if Frm <> nil then
                                Result := Frm.Handle;
                            end;

      // Misc commands
      EC_GOTOURL: MainFrm.GotoURL(PChar(Param1));
      EC_GETIMAGELIST: Result := MainFrm.MainImages.Handle;
      EC_ISPLUGINLOADED: if Plugins.IsPluginLoaded(PChar(Param1)) then Result := 1;
    end;
  except
    Result := COMMAND_FAIL;
  end;
end;

(******************************************************************************)

var
  PluginsMangerCount: Integer = 0;

{ TPlugins }

constructor TPlugins.Create;
var
  Found, C: Integer;
  SR: TSearchRec;
  DllHandle: THandle;
  PluginDllNames: TStringList;
  Data: PPluginData;
  GetHMNEPluginData: function: PPluginData; stdcall;

  function GetPluginData: Boolean;
  begin
    Result := Assigned(GetHMNEPluginData);
    if not Result then Exit;

    Data := GetHMNEPluginData;
    Result := Assigned(Data) and Assigned(Data.Description) and (Data.Version <> 0);
  end;

begin
  if PluginsMangerCount > 0 then
    raise Exception.Create('Plugins already created.');

  Inc(PluginsMangerCount);
  FMsgHookProcs := TList.Create;

  PluginDllNames := TStringList.Create;
  try
    Found := FindFirst(ExtractFilePath(ParamStr(0)) + 'Plugins\hmne_*.dll', faAnyFile, SR);
    while Found = 0 do
    begin
      PluginDllNames.Add(ExtractFilePath(ParamStr(0)) + 'Plugins\' + SR.Name);
      Found := FindNext(SR);
    end;
    FindClose(SR);
    PluginDllNames.Sort;

    for C := 0 to PluginDllNames.Count - 1 do
    begin
      DllHandle := LoadLibrary(PChar(PluginDllNames[C]));
      if DllHandle > 0 then
      begin
        GetHMNEPluginData := GetProcAddress(DllHandle, 'GetHMNEPluginData');
        if GetPluginData then
        begin
          Data.ApplicationHandle := Application.Handle;
          Data.MainWindowHandle := MainFrm.Handle;
          Data.MainWindowClientHandle := MainFrm.ClientHandle;
          Data.DllHandle := DllHandle;
          Data.Command := CommandProcessor;

          if Assigned(Data.MessageHook) then
            FMsgHookProcs.Add(@Data.MessageHook);
          if Assigned(Data.Init) then
            Data.Init;

          if FPlugins = nil then
            FPlugins := TList.Create;
          FPlugins.Add(Data);
        end else
          FreeLibrary(DllHandle);
      end;
    end;
  finally
    PluginDllNames.Free;
  end;
end;

destructor TPlugins.Destroy;
var
  C: Integer;
  Data: PPluginData;
begin
  if FPlugins <> nil then
  begin
    for C := FPlugins.Count - 1 downto 0 do
    begin
      Data := FPlugins[C];

      if Assigned(Data.Quit) then
        Data.Quit;

      FreeLibrary(Data.DllHandle);
    end;
    FPlugins.Free;
  end;
  FMsgHookProcs.Free;
  inherited Destroy;
end;

function TPlugins.GetPluginCount: Integer;
begin
  if FPlugins <> nil then
    Result := FPlugins.Count
  else
    Result := 0;
end;

function TPlugins.GetPlugins(Index: Integer): PPluginData;
begin
  Result := FPlugins[Index]
end;

procedure TPlugins.GetPluginsList(List: TStrings);
var
  C: Integer;
  P: PPluginData;
begin
  List.BeginUpdate;
  try
    List.Clear;
    if FPlugins <> nil then
    for C := 0 to FPlugins.Count - 1 do
    begin
       P := FPlugins[C];
       List.AddObject(P.Description, TObject(P));
    end;
  finally
    List.EndUpdate;
  end;
end;

function TPlugins.IsPluginLoaded(const PluginDescription: String): Boolean;
var
  C: Integer;
  P: PPluginData;
begin
  Result := True;
  if FPlugins <> nil then
    for C := 0 to FPlugins.Count - 1 do
    begin
      P := FPlugins[C];
      if StrIComp(P.Description, PChar(PluginDescription)) = 0 then
        Exit;
    end;
  Result := False;
end;

function TPlugins.MessageHook(const Msg: PMsg): Boolean;
type
  TFunc = function(Msg: PMsg): Integer; cdecl;
var
  C: Integer;
begin
  Result := True;
  for C := 0 to FMsgHookProcs.Count - 1 do
    if TFunc(FMsgHookProcs[C])(Msg) = 1 then Exit;
  Result := False;
end;

function TPlugins.Notify(Event: TEvent; Param1: Integer = 0; Param2: Integer = 0;
  Param3: Integer = 0): Integer;
var
  C: Integer;
  Data: PPluginData;
begin
  if FPlugins <> nil then
  for C := 0 to FPlugins.Count - 1 do
  begin
    Data := PPluginData(FPlugins[C]);
    if Assigned(Data.NotifyProc) then
      Data.NotifyProc(Event, Param1, Param2, Param3);
  end;
  Result := 0;
end;

end.
