{
  HM NIS Edit (c) 2003 Héctor Mauricio Rodríguez Segura <ranametal@users.sourceforge.net>
  For conditions of distribution and use, see license.txt

  Editor frame

}
unit UEdit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, SynEditExport, SynEdit, ComCtrls, Menus, UCustomMDIChild,
  SynEditKeyCmds;

type
  TEditFrm = class(TCustomMDIChild)
    Edit: TSynEdit;
    Splitter1: TSplitter;
    LogBox: TRichEdit;
    procedure EditChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormActivate(Sender: TObject);
    procedure EditStatusChange(Sender: TObject;
      Changes: TSynStatusChanges);
    procedure EditSpecialLineColors(Sender: TObject; Line: Integer;
      var Special: Boolean; var FG, BG: TColor);
    procedure EditMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure EditKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EditContextHelp(Sender: TObject; word: String);
    procedure EditKeyPress(Sender: TObject; var Key: Char);
    procedure EditMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure EditKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure LogBoxKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EditDblClick(Sender: TObject);
  private
    FHintWord: String;
    FHintLine: Integer;
    FErrorLine: Integer;
    FControlKeyCount: Integer;
    SaveLogBoxHeight: Integer;
    FIsCompiling: Boolean;
    SaveReadOnly: Boolean;
    procedure SetIsCompiling(Value: Boolean);
    procedure SetErrorLine(ALine: Integer);
    procedure SetLogBoxVisible(const Value: Boolean);
    function GetLogBoxVisible: Boolean;
    procedure LogBoxDblClick(Sender: TObject);
    procedure WMMouseLeave(var Msg: TMessage); message CM_MOUSELEAVE;
    procedure WMCopyData(var Msg: TWMCopyData); message WM_COPYDATA;
    procedure ShowScriptErrorLine(const ErrorFileName: String;
      ErrorLineNumber: Integer);
    function HintWindowReleaseHandle: Boolean;
  protected
    function GetSynEdit: TSynEdit; override;
  public
    SuccessCompile: Boolean;
    IsHeader, IsText: Boolean;

    property LogBoxVisible: Boolean read GetLogBoxVisible write SetLogBoxVisible;
    property ErrorLine: Integer read FErrorLine write SetErrorLine;
    property IsCompiling: Boolean read FIsCompiling write SetIsCompiling;

    procedure UpdateEditor; override;
    procedure GetErrorLine;
    function ExeName: String;
    procedure Compilar(Run: Boolean = False);
    procedure RunSetup;
    function AllowCompile: Boolean;

    procedure SaveFile(AFileName: String); override;
    procedure LoadFile(AFileName: String); override;

    procedure ShowEditCaret;
  end;


var
  EditFrm: TEditFrm;
  CompilingCount: Integer = 0;
  UsageList: TStringList = nil;
  HintWindow: THintWindow = nil;

const
  StrDelim = [#39, '"', '`'];
  ComentChars = [';', '#'];

  {NSIEditOptions = [eoAutoIndent,eoDragDropEditing,eoGroupUndo,
    eoKeepCaretX, eoScrollPastEol,eoShowScrollHint,eoSmartTabDelete,
      eoTabsToSpaces,eoTrimTrailingSpaces];
  INIEditOptions = [eoAutoIndent,eoDragDropEditing,eoGroupUndo,eoKeepCaretX,
    eoShowScrollHint,eoSmartTabDelete, eoTabsToSpaces];

  EditOptions: array[Boolean] of TSynEditorOptions = (NSIEditOptions,INIEditOptions);}

implementation

uses ShellAPI, UMain, Utils, PluginsManger, PluginsInt;

{$R *.DFM}

function GetWordUsage(const AWord: String): String;

  procedure GetFromCompiler;
  var
    ProcHandle, ReadHandle: THandle;
    Buf: array[0..1024] of Char;
    NumRead: Cardinal;
    I, C: Integer;
    S: String;
  begin
    if CreatePipeAndProcess('"' + MainFrm.Compiler +
          '" /V1 /CMDHELP ' + AWord, ProcHandle, ReadHandle) then
    try
      with TStringList.Create do
      try
        while ReadFile(ReadHandle, Buf, SizeOf(Buf) - 1, NumRead, nil) do
        begin
          Buf[NumRead] := #0;
          Append(Trim(Buf));
        end;
        for C := 0 to Count - 1 do
        if AnsiPos(LowerCase(AWord), LowerCase(Strings[C])) > 0 then
           Break;
        for I := C to Count - 1 do
        begin
          S := Strings[I];
          if I < Count - 1 then S := S + #13#10;
          Result := Result + S;
        end;
        Result := Trim(Result);
      finally
        Free;
      end;
    finally
      CloseHandle(ProcHandle);
      CloseHandle(ReadHandle);
    end;
  end;

  procedure AddWordUsage(const AWord, Usage: String);
  begin
    UsageList.Add(AWord+'='+Usage);
    UsageList.Sorted := True;
  end;

begin
  Result := '';
  if (AWord <> '') and MainFrm.WordHaveHintUsage(AWord) then
  begin
    if UsageList = nil then
      UsageList := TStringList.Create;

    Result := UsageList.Values[AWord];
    if Result = '' then
    begin
      Screen.Cursor := crHourGlass;
      try
        GetFromCompiler;
      finally
        Screen.Cursor := crDefault;
      end;
      if Result = '' then
      begin
        AddWordUsage(AWord, '*');
        Result :=  Format('Invalid command "%s"', [AWord]);
      end
      else
        AddWordUsage(AWord, Result);
    end else
      if Result = '*' then
        Result :=  Format('Invalid command "%s"', [AWord]);
  end;
end;


{ TCompilerThread }

type
  TCompilerThread = class(TThread)
  private
    FLogBoxHandle: THandle;
    FEditor: TEditFrm;
    FRun: Boolean;
    procedure ThreadTerminate(Sender: TObject);
  protected
    procedure Execute; override;
  public
    ProcessHandle, ReadHandle: THandle;
    constructor Create(Editor: TEditFrm; Run: Boolean);
    destructor Destroy; override;
  end;


constructor TCompilerThread.Create(Editor: TEditFrm; Run: Boolean);
begin
  Inc(CompilingCount);

  FEditor := Editor;
  FLogBoxHandle := FEditor.LogBox.Handle;
  FRun := Run;

  FEditor.IsCompiling := True;
  FEditor.SuccessCompile := False;
  FEditor.LogBoxVisible := True;

  FEditor.ErrorLine := 0;
  FEditor.LogBox.Clear;

  inherited Create(True);
  FreeOnTerminate := True;
  OnTerminate := ThreadTerminate;

  Plugins.Notify(E_BEFORECOMPILE, Integer(PChar(FEditor.FileName)));
end;

destructor TCompilerThread.Destroy;
begin
  Dec(CompilingCount);
  inherited Destroy;
  FEditor.IsCompiling := False;
end;

procedure TCompilerThread.Execute;
var
  LogLen: Integer;
  Buf: array[0..1024] of Char;
  NumRead: Cardinal;
begin
  try
    LogLen := 0;
    while ReadFile(ReadHandle, Buf, SizeOf(Buf) - 1, NumRead, nil) do
    begin
      Buf[NumRead] := #0;
      SendMessage(FLogBoxHandle, EM_SETSEL, LogLen, LogLen);
      Inc(LogLen, StrLen(Buf));
      SendMessage(FLogBoxHandle, EM_REPLACESEL, 0, wParam(@Buf[0]));
      SendMessage(FLogBoxHandle, EM_SCROLLCARET, 0, 0);
    end;
  except
    { NADA }
  end;
end;

procedure TCompilerThread.ThreadTerminate(Sender: TObject);
var
  AExitCode: Cardinal;
begin
  try
    WaitForSingleObject(ProcessHandle, INFINITE);
    GetExitCodeProcess(ProcessHandle, AExitCode);

    CloseHandle(ProcessHandle);
    CloseHandle(ReadHandle);

    FEditor.SuccessCompile := AExitCode = 0;

    if FEditor.SuccessCompile then
    begin
      Plugins.Notify(E_COMPILESUCCES, Integer(PChar(FEditor.FileName)));
      MessageBeep(MB_ICONINFORMATION);
      if FRun then FEditor.RunSetup;
    end else
    begin
      Plugins.Notify(E_COMPILEFAIL, Integer(PChar(FEditor.FileName)), AExitCode);
      MessageBeep(MB_ICONERROR);
      FEditor.GetErrorLine;
    end;
    if (not FEditor.SuccessCompile) or (not FRun) then
      FEditor.Show;
  except
    Application.HandleException(Self);
  end;
end;

{ TEditFrm }

procedure TEditFrm.SetLogBoxVisible(const Value: Boolean);
begin
  if Value <> GetLogBoxVisible then
  Begin
    if Value then
    begin
      LogBox.Height := SaveLogBoxHeight;
      if LogBox.Height <= 5 then
        LogBox.Height := 130
    end else
    begin
      SaveLogBoxHeight := LogBox.Height;
      LogBox.Height := 1;
    end;
  end;
end;

procedure TEditFrm.EditChange(Sender: TObject);
begin
  Modified := True;
  SuccessCompile := False;
end;

type
  TRichEditAccess = class(TRichEdit);
procedure TEditFrm.FormCreate(Sender: TObject);
begin
  LogBox.PopupMenu := MainFrm.LogBoxPopup;
  SetLogBoxVisible(False);
  TRichEditAccess(LogBox).OnDblClick := LogBoxDblClick;
  FDefExt := '.nsi';  
end;

procedure TEditFrm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  MainFrm.FirstEdit := nil;
end;

procedure TEditFrm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := not IsCompiling;
  if not CanClose then
  begin
     WarningDlg(LangStr('NoCloseCompiling'));
     Exit;
  end;
end;

procedure TEditFrm.FormActivate(Sender: TObject);
begin
  MainFrm.IOPanel.Visible := False;
  MainFrm.EnableIOControls(False);
end;

procedure TEditFrm.EditStatusChange(Sender: TObject;
  Changes: TSynStatusChanges);
begin
  if scModified in Changes then
    Self.Modified := Edit.Modified;
  MainFrm.UpdateStatus;
  if (not (scCaretX in Changes)) and (HintWindow <> nil) then
    HintWindowReleaseHandle;
  ShowEditCaret;  
end;

procedure TEditFrm.EditSpecialLineColors(Sender: TObject; Line: Integer;
  var Special: Boolean; var FG, BG: TColor);
begin
  if (FErrorLine > 0) and (FErrorLine = Line) then
  begin
    Special := True;
    FG := clWhite;
    BG := clMaroon;
  end;
end;

procedure TEditFrm.ShowScriptErrorLine(const ErrorFileName: String;
  ErrorLineNumber: Integer);
begin
  if AnsiCompareFileName(FileName, ErrorFileName) = 0 then
    SetErrorLine(ErrorLineNumber) else
  TEditFrm(MainFrm.OpenFile(ErrorFileName)).ErrorLine := ErrorLineNumber;
end;

procedure TEditFrm.GetErrorLine;
var
  C: Integer;
  S: String;
begin
  for C := LogBox.Lines.Count - 1 downto 0 do
  begin
    S := LogBox.Lines[C];
    if AnsiPos(SError, Trim(S)) = 1 then
    begin
      ShowScriptErrorLine(GetErrorFileName(S), GetErrorLineNumber(S));
      Exit;
    end;
  end;
end;

procedure TEditFrm.SetErrorLine(ALine: Integer);
begin
    if FErrorLine > 0 then
      Edit.InvalidateLine (FErrorLine);
    FErrorLine := ALine;
    if FErrorLine > 0 then
    Begin
      Edit.CaretY := FErrorLine;
      Edit.CaretX := 0;
      Edit.EnsureCursorPosVisibleEx(True);
      Edit.InvalidateLine (FErrorLine);
    end;
end;

function TEditFrm.ExeName: String;
var
  C: Integer;
begin
  for C := LogBox.Lines.Count - 1 downto 0 do
  begin
    Result := Trim(LogBox.Lines[C]);
    if SameText(Copy(Result, 1, Length(SOutput)), SOutput) then
    begin
      Delete(Result, 1, Length(SOutput));
      SetLength(Result, Length(Result) - 1);
      Exit;
    end;
  end;
  Result := '';
end;

procedure TEditFrm.EditMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  SetErrorLine(0);
end;

procedure TEditFrm.EditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  P: TPoint;
begin
  SetErrorLine(0);

  if (Key = VK_RETURN) and (Shift = [ssCtrl]) then
    EditDblClick(Edit) else
  if Key = VK_CONTROL then
  begin
    Inc(FControlKeyCount);
    if FControlKeyCount = 1 then
    begin
      P := Edit.ScreenToClient(Mouse.CursorPos);
      EditMouseMove(Edit, [ssCtrl], P.X, P.Y);
    end;
  end;
  { Para evitar asignar el MainFrm.SynAutoComplete.Editor cada vez que una
    nueva ventana de edición se activa, porque aperentemente en siertas
    sircunstancia causa un AV. }
  MainFrm.SynAutoComplete.EditorKeyDown(Sender, Key, Shift);
end;

procedure TEditFrm.EditContextHelp(Sender: TObject; word: String);
begin
  MainFrm.ShowHelp(Word);
end;

procedure TEditFrm.SetIsCompiling(Value: Boolean);
begin
  if Value <> FIsCompiling then
  begin
    FIsCompiling := Value;
    if FIsCompiling then
    begin
      SaveReadOnly := Edit.ReadOnly;
      Edit.ReadOnly := True;
    end
      else Edit.ReadOnly := SaveReadOnly;
  end;
end;

procedure TEditFrm.Compilar(Run: Boolean = False);

  procedure RaiseLastError;
  begin
    raise Exception.Create('Error executing compiler.'#13#10 +
      SysErrorMessage(GetLastError));
  end;

var
  CompThread: TCompilerThread;
begin
  CompThread := TCompilerThread.Create(Self, Run);
  try
    if not CreatePipeAndProcess(MainFrm.GetCompilerCmdLine(FileName, Handle),
      CompThread.ProcessHandle, CompThread.ReadHandle) then RaiseLastError;
    CompThread.Resume;
  except
    CompThread.Free;
    raise;
  end;
end;

procedure TEditFrm.RunSetup;
var
  StartupInfo: TStartupInfo;
  ProcessInfo: TProcessInformation;
  SExeName: String;
begin
  SExeName := ExeName;
  Plugins.Notify(E_RUNEXECUTABLE, Integer(PChar(SExeName)));
  InitStartupInfo(StartupInfo);
  Win32Check(CreateProcess(nil, PChar('"' + SExeName + '"'), nil, nil,
    False, 0, nil, nil, StartupInfo, ProcessInfo));
  CloseHandle(ProcessInfo.hThread);
  CloseHandle(ProcessInfo.hProcess);
end;

procedure TEditFrm.EditKeyPress(Sender: TObject; var Key: Char);
begin
  MainFrm.SynAutoComplete.EditorKeyPress(Sender, Key);
end;

procedure TEditFrm.WMMouseLeave(var Msg: TMessage);
begin
  HintWindowReleaseHandle;
  FHintWord := '';
  FHintLine := -1;
  inherited;
end;

procedure TEditFrm.EditMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
  S: String;
  Rc: TRect;
  Pt, RowCol: TPoint;
begin
  if IsText or (CompilingCount > 0) or ((not MainFrm.Options.ShowCmdHint)
   and (not (ssCtrl in Shift))) then Exit;

  RowCol := Edit.PixelsToRowColumn(Point(X, Y));
  S := Edit.GetWordAtRowCol(RowCol);
  if (S <> FHintWord) or (FHintLine <> RowCol.Y) then
  begin
    HintWindowReleaseHandle;

    if HintWindow = nil then
      HintWindow := TShadowedHintWindow.Create(MainFrm);

    Pt := Mouse.CursorPos;
    FHintWord := S;
    FHintLine := RowCol.Y;

    S := GetWordUsage(FHintWord);

    if S <> '' then
    begin
      Rc := HintWindow.CalcHintRect(Screen.Width, S, nil);
      OffsetRect(Rc, Pt.X, Pt.Y);
      HintWindow.Color := Application.HintColor;
      HintWindow.Canvas.Font.Assign(Screen.HintFont);
      HintWindow.ActivateHint(Rc, S);
    end;
  end;
end;

procedure TEditFrm.UpdateEditor;
var
  Ext: String;
begin
  Ext := ExtractFileExt(FileName);
  IsText := SameText(Ext, '.txt');
  IsHeader := SameText(Ext, '.nsh');

  if IsText or IsHeader then
  begin
    Splitter1.Visible := False;
    LogBox.Visible := False;
  end;

  if UseHighLighter then
  begin
    if not IsText then
      Edit.Highlighter := MainFrm.SynNSIS
    else
      Edit.Highlighter := nil;
  end else
    Edit.Highlighter := nil;
  Edit.Assign(MainFrm.EditorOptions);
  if IsText then Edit.Gutter.Visible := False;
  inherited UpdateEditor;
end;

type
  TSynEditAccess = class(TSynEdit);
procedure TEditFrm.ShowEditCaret;
begin
  if not ShowCaret(Edit.Handle) then
    TSynEditAccess(Edit).InitializeCaret;
end;

procedure TEditFrm.EditKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_CONTROL) and HintWindowReleaseHandle then
  begin
    FHintWord := '';
    FControlKeyCount := 0;
  end;
end;

function TEditFrm.GetLogBoxVisible: Boolean;
begin
   Result := LogBox.Height > 5;
end;

procedure TEditFrm.WMCopyData(var Msg: TWMCopyData);
const
  MAKENSIS_NOTIFY_SCRIPT = 0;
  MAKENSIS_NOTIFY_WARNING = 1;
  MAKENSIS_NOTIFY_ERROR = 2;
  MAKENSIS_NOTIFY_OUTPUT = 3;
begin
  case Msg.CopyDataStruct.dwData of
    MAKENSIS_NOTIFY_SCRIPT:;
    MAKENSIS_NOTIFY_WARNING:;
    MAKENSIS_NOTIFY_ERROR:;
    MAKENSIS_NOTIFY_OUTPUT:;
  end;
end;

procedure TEditFrm.LogBoxDblClick(Sender: TObject);

  function GetConfigFileName: String;
  begin
    Result := ExtractFilePath(MainFrm.Compiler) + 'nsisconf.nsh';
    if not FileExists(Result) then
    begin
      Result := ChangeFileExt(Result, '.nsi');
      if not FileExists(Result) then Abort;
    end;
  end;

var
  Wfn, S: String;
  Wln: Integer;
begin
  S := LogBox.Lines[LogBox.CaretPos.Y];
  if AnsiPos(SIncError, S) > 0 then
    ShowScriptErrorLine(GetIncErrorFileName(S), GetIncErrorLineNumber(S)) else
  if AnsiPos(SError, S) > 0 then
    ShowScriptErrorLine(GetErrorFileName(S), GetErrorLineNumber(S)) else
  if AnsiPos(SConfigError, S) > 0 then
    ShowScriptErrorLine(GetConfigFileName, GetConfigErrorLine(S)) else
  begin
    Wfn := GetWarningFileName(S);
    if (Wfn <> '') and FileExists(Wfn) then
    begin
      Wln := GetWarningErrorLineNumber(S);
      if Wln > 0 then
        ShowScriptErrorLine(Wfn, Wln);
    end;
  end;
end;

procedure TEditFrm.LogBoxKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
     LogBoxDblClick(LogBox);
end;

function TEditFrm.HintWindowReleaseHandle: Boolean;
begin
  Result := HintWindow <> nil;
  if Result then
     HintWindow.ReleaseHandle;
end;

procedure TEditFrm.EditDblClick(Sender: TObject);
const
  SInclude = '!include';
var
  S, IncFile: String;
  CC: Char;
  I: Integer;
begin
  S := Trim(Edit.LineText);
  I :=  AnsiPos(SInclude, S);
  if I > 0 then
  begin
    Delete(S, 1, I + Length(LowerCase(SInclude)));
    S := Trim(S);
    if S <> '' then
    begin
      if S[1] in Quotes then
        CC := S[1]
      else
        CC := ' ';
      if CC in Quotes then  Delete(S, 1, 1);
      I := AnsiPos(CC, S)-1;
      if I < 0 then I := MaxInt;
      IncFile := ExpandFileName(Copy(S, 1, I));
      if not FileExists(IncFile) then
        IncFile := ExtractFilePath(MainFrm.Compiler) + 'include\' + Copy(S, 1, I);
      if not FileExists(IncFile) then
        IncFile := StringReplace(Copy(S, 1, I), '${NSISDIR}', ExtractFileDir(MainFrm.Compiler),
          [rfReplaceAll]);
      if FileExists(IncFile) then
        MainFrm.OpenFile(IncFile);
    end;
  end;
end;

procedure TEditFrm.SaveFile(AFileName: String);
begin
  if AFileName <> '' then
  begin
    FileName := AFileName;
    MainFrm.AddToRecent(FileName);
  end;
  Edit.Lines.SaveToFile(FileName);
  Modified := False;
  InitValues;
end;

function TEditFrm.GetSynEdit: TSynEdit;
begin
  Result := Edit;
end;

procedure TEditFrm.LoadFile(AFileName: String);
begin
  Edit.Lines.LoadFromFile(FileName);
  SuccessCompile := False;
  SetLogBoxVisible(False);
  Edit.Modified := False;
end;

function TEditFrm.AllowCompile: Boolean;
begin
  Result := (not IsText) and (not IsHeader) and (not IsCompiling);
end;

initialization
  { NADA }
finalization
  UsageList.Free;
end.
