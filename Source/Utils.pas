{
  HM NIS Edit (c) 2003 Héctor Mauricio Rodríguez Segura <ranametal@users.sourceforge.net>
  For conditions of distribution and use, see license.txt

  Misc utils

}
unit Utils;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, Graphics, Forms, ActnList,
  Menus, Registry, IniFiles, SynEditExport, SynEdit, StdCtrls;

type
  THTMLHelpFunc = function(hwndCaller: HWND; pszFile: PChar; uCommand: UINT; dwData: DWORD): DWORD; stdcall;

  TSynExporterClass = class of TSynCustomExporter;

  // Hints with shadow on WinXP
  TShadowedHintWindow = class(THintWindow)
  protected
    procedure CreateParams(var Params: TCreateParams); override;
  end;

  // Don't raise exception when reading invalid data
  TSafeRegistryIniFile = class(TRegistryIniFile)
  public
    function ReadInteger(const Section, Ident: string; Default: Longint): Longint; override;
    function ReadString(const Section, Ident, Default: string): string; override;
    procedure WriteInteger(const Section, Ident: string; Value: Longint); override;
  end;


const
   AppName = 'HM NIS Edit';
   AppVersion = '2.0b6';
   AppVersionText = 'Version ' + AppVersion;
   AppCopyrigh = '(c) 2003 Hector Mauricio Rodriguez Segura';

   HMWebSite = 'http://hmne.sourceforge.net/';
   NSISWebSite = 'http://nsis.sourceforge.net/';

const
  mbQuestion = MB_ICONQUESTION or MB_YESNO;
  mbQuestionCancel = MB_ICONQUESTION or MB_YESNOCANCEL;
  mbQuestionDefBtn2 = mbQuestion or MB_DEFBUTTON2;
  mbError = MB_ICONERROR or MB_OK;
  mbWarning = MB_ICONEXCLAMATION or MB_OK;
  mbWarningQuestion = MB_ICONEXCLAMATION or MB_YESNO;
  mbInfo = MB_ICONINFORMATION or MB_OK;
  mbInfoQuestion = MB_ICONINFORMATION or MB_YESNO;

  CS_DROPSHADOW = $00020000;

  SecondInstCmds = 10383;

  EnabledColors: array[Boolean] of TColor = (clBtnFace, clWindow);
  ReadOnlyColors: array[Boolean] of TColor = (clWindow, clBtnFace);

  SMainClassName = 'THMNISEdit2_MainWindowClass';
  Quotes = ['"', #39, '`'];


const
  SDefError = 'Error in script "';
  SDefOnLine = '" on line ';
  SDefConfigError = 'Error in config on line ';
  SDefIncError = '!include: error in script: "';
  SDefAbort = ' -- aborting creation process';
  SDefWarning = '!warning: ';
  SDefOutput = 'Output: "';

const
   HHCTRL = 'HHCTRL.OCX';

var
  HtmlHelp: THTMLHelpFunc = nil;
  HHCTRLHandle: HINST;

var
  CheckWidth, CheckHeight: Integer;
  IsWinXP: Boolean;
  LangFile: String;
  OptionsIniFileName: String;
  OptionsIni: TCustomIniFile;

  { var for the compiler output parsing }
  SError: String;
  SOnLine: String;
  SConfigError: String;
  SIncError: String;
  SAbort: String;
  SWarning: String;
  SOutput: String;

  LangIni: TMemIniFile = nil;

function QuestionDlg(const Msg: String; Flags: Integer = mbquestion): Integer;
function ErrorDlg(const Msg: String; Flags: Integer = mbError): Integer;
function WarningDlg(const Msg: String; Flags: Integer = mbWarning): Integer;
Function InfoDlg(const Msg: String; Flags: Integer = mbInfo): Integer;
function LangStr(const S: String; const DefaultText: String = ''): String;
function LangStrFormat(const S: String; const Args: array of const): String;
procedure ResetLang(const NewLangFile: String);
function InputQuery(const ACaption, Prompt: String; var S: String): Boolean;
function AddPeriod(const S: String): String;
function QuoteIfNeeded(const S: String): String;
function UnQuote(const S: String): String;
function DirExists(const Name: string): Boolean;
function ColorToHTML(const Color: TColor): String;
function GetLangFileFilter(const Strs: Array of String): String;
procedure InitStartupInfo(var StartupInfo: TStartupInfo);
procedure FillStartupInfo(var StartupInfo: TStartupInfo; const OutHandle: THandle);
procedure AssignActionText(Action: TAction; const TextId: String);
procedure CommaListToStrList(CommaList, Delim: String; StrList: TStrings);
function StrListToCommaList(StrList: TStrings; Delim: String): String;
function ExtractStr (var S: String; Delim: String): String;
function ChangeVar(const S, VarName, NewValue: String): String;
function ShortToLongPath(const ShortName: String): String;
procedure HaltIfRunning;
function CreatePipeAndProcess(const CmdLine: String; var ProcessHandle,
   ReadPipe: THandle): Boolean;
procedure SetCtrlEnabled(Control: TControl; Enabled: Boolean);
function IsConsole(const FileName: String): Boolean;
procedure InitFont(Font: TFont);
procedure InitCompilerOutputParsingVars;
procedure RegisterAsDefaultEditor;
procedure AddWinLong(Handle: HWND; Index, Long: Longint);
procedure RemoveWinLong(Handle: HWND; Index, Long: Longint);
procedure SynEditExportLines(Edit: TSynEdit; SynExporterClass: TSynExporterClass;
  AFileName: String);
function ConvertNewLines(const S: String; const Normal: Boolean = True): String;

function IsValidIOFile(const FileName: String): Boolean;

function DialogUnitsToPixelsX(DlgUnits, DUX: Integer): Integer;
function DialogUnitsToPixelsY(DlgUnits, DUY: Integer): Integer;
function PixelsToDialogUnitsX(PixUnits, DUX: Integer): Integer;
function PixelsToDialogUnitsY(PixUnits, DUY: Integer): Integer;
function GetAveCharSize(Canvas: TCanvas): TPoint;

function SwitchPassed(const Switch: string): Boolean;
function ShellIconIndex(const FileName: String): Integer;
function QuoteStr(const S: String): String;

function LoadHHCTRL: Boolean;
function ForceForegroundWindow(WindowHandle: HWND): Boolean;
procedure UpdateHorizontalExtent(const ListBox: TListBox);
function FileHaveAttri(const FileName: String; const Attri: Integer): Boolean;

function BinToText(var Buffer; const Size: Integer): String;
function TextToBin(Text: String; var Buffer; const Size: Integer): Boolean;

function GetXValue(const S: String; const Default: Integer = -1): Integer;
function GetYValue(const S: String; const Default: Integer = -1): Integer;

function GetErrorFileName(const S: String): String;
function GetErrorLineNumber(const S: String): Integer;
function GetIncErrorFileName(const S: String): String;
function GetIncErrorLineNumber(const S: String): Integer;
function GetWarningFileName(const S: String): String;
function GetWarningErrorLineNumber(S: String): Integer;
function GetConfigErrorLine(S: String): Integer;

implementation
uses
  ShlObj, ShellAPI, UInputQuery, USplash, HTMLHelp;

{ TShadowedHintWindow }

procedure TShadowedHintWindow.CreateParams(var Params: TCreateParams);
begin
  inherited;
  if IsWinXP then Params.WindowClass.Style := Params.WindowClass.Style or CS_DROPSHADOW;
end;

{ TSafeRegistryIniFile }

function TSafeRegistryIniFile.ReadInteger(const Section, Ident: string;
  Default: Integer): Longint;
begin
  Result := StrToIntDef(ReadString(Section, Ident, IntToStr(Default)), Default);
end;

function TSafeRegistryIniFile.ReadString(const Section, Ident,
  Default: string): string;
begin
  try
    Result := inherited ReadString(Section, Ident, Default);
  except
    Result := Default
  end;
end;

procedure TSafeRegistryIniFile.WriteInteger(const Section, Ident: string;
  Value: Integer);
begin
  WriteString(Section, Ident, IntToStr(Value));
end;

{ Compiler output parsing }

function GetErrorFileName(const S: String): String;
var
  P1, P2, Count: Integer;
begin
  P1 := AnsiPos(SError, S) + Length(SError);
  P2 := AnsiPos(SOnLine, S);
  Count := P2 - P1;
  Result := Copy(S, P1, Count);
end;

function GetErrorLineNumber(const S: String): Integer;
var
  P1, P2, Count: Integer;
begin
  P1 := AnsiPos(SOnLine, S) + Length(SOnLine);
  P2 := AnsiPos(SAbort, S);
  Count := P2 - P1;
  Result := StrToIntDef(Trim(Copy(S, P1, Count)), 0);
end;

function GetIncErrorFileName(const S: String): String;
var
  P1, P2, Count: Integer;
begin
  P1 := AnsiPos(SIncError, S) + Length(SIncError);
  P2 := AnsiPos(SOnLine, S);
  Count := P2 - P1;
  Result := Copy(S, P1, Count);
end;

function GetIncErrorLineNumber(const S: String): Integer;
begin
  Result := StrToIntDef(Trim(Copy(S, AnsiPos(SOnLine, S) + Length(SOnLine),
    MaxInt)), 0)
end;

function GetWarningFileName(const S: String): String;
begin
  Result := Trim(AnsiStrRScan(PChar(S), '('));
  if Result <> '' then
    Result := Copy(Result, 2, AnsiPos(AnsiStrRScan(PChar(Result), ':'), Result)-2);
end;

function GetWarningErrorLineNumber(S: String): Integer;
begin
  Result := 0;
  S := Trim(AnsiStrRScan(PChar(S), ':'));
  if S <> '' then
  begin
    Delete(S, 1, 1);
    if S <> '' then SetLength(S, Length(S)-1);
    Result := StrToIntDef(S, -1);
  end;
end;

function GetConfigErrorLine(S: String): Integer;
begin
  Delete(S, AnsiPos(SAbort, S), MaxInt);
  Delete(S, 1, Length(SConfigError));
  Result := StrToIntDef(Trim(S), 0);
end;

{ General Utils }

function ForceForegroundWindow(WindowHandle: HWND): Boolean;
var
  CurWnd: HWND;
begin
  CurWnd := GetForegroundWindow;
  Result := False;
  if GetWindowThreadProcessId(CurWnd, nil) <> GetCurrentThreadId then
  begin
    AttachThreadInput(GetWindowThreadProcessId(CurWnd, nil),
      GetCurrentThreadId, True);
    Result := SetForegroundWindow(WindowHandle);
    AttachThreadInput(GetWindowThreadProcessId(CurWnd, nil),
      GetCurrentThreadId, False);
  end;
end;

function LoadHHCTRL: Boolean;
begin
  if HHCTRLHandle = 0 then
    HHCTRLHandle := LoadLibrary(HHCTRL);
  if (HHCTRLHandle <> 0) and not Assigned(Utils.HtmlHelp) then
    Utils.HtmlHelp := GetProcAddress(HHCTRLHandle, 'HtmlHelpA');
  Result := Assigned(Utils.HtmlHelp);
end;

procedure UpdateHorizontalExtent(const ListBox: TListBox);
{  I take this function from the I?no Setup IDE  }
var
  I: Integer;
  Extent, MaxExtent: Longint;
  DC: HDC;
  Size: TSize;
  TextMetrics: TTextMetric;
begin
  DC := GetDC(0);
  try
    SelectObject(DC, ListBox.Font.Handle);

    //Q66370 says tmAveCharWidth should be added to extent
    GetTextMetrics(DC, TextMetrics);

    MaxExtent := 0;
    for I := 0 to ListBox.Items.Count-1 do begin
      GetTextExtentPoint32(DC, PChar(ListBox.Items[I]), Length(ListBox.Items[I]), Size);
      Extent := Size.cx + TextMetrics.tmAveCharWidth;
      if Extent > MaxExtent then
        MaxExtent := Extent;
    end;

  finally
    ReleaseDC(0, DC);
  end;

  if MaxExtent > SendMessage(ListBox.Handle, LB_GETHORIZONTALEXTENT, 0, 0) then
    SendMessage(ListBox.Handle, LB_SETHORIZONTALEXTENT, MaxExtent, 0);
end;

function FileHaveAttri(const FileName: String; const Attri: Integer): Boolean;
begin
  Result := (FileGetAttr(FileName) and Attri) = Attri;
end;

function BinToText(var Buffer; const Size: Integer): String;
var
  P: PByte;
  C: Integer;
begin
  Result := '';
  P := @Buffer;
  for C := 1 to Size do
  begin
    Result := Result + IntToHex(P^, 2);
    Inc(P);
  end;
end;

function TextToBin(Text: String; var Buffer; const Size: Integer): Boolean;

  function ExtractByte(var B: Byte): Boolean;
  var
    Code: Integer;
  begin
    Val('$' + Copy(Text, 1, 2), B, Code);
    Result := Code = 0;
    if Result then Delete(Text, 1, 2);
  end;

var
  P: PByte;
begin
  Result := Length(Text) = Size * 2;
  if not Result then Exit;
  P := @Buffer;
  while Text <> '' do
  begin
    if not ExtractByte(P^) then
    begin
      Result := False;
      Exit;
    end;
    Inc(P);
  end;
end;

function GetXValue(const S: String; const Default: Integer = -1): Integer;
begin
  Result := StrToIntDef(Copy(S, 1, AnsiPos('/', S)-1), Default);
end;

function GetYValue(const S: String; const Default: Integer = -1): Integer;
begin
  Result := StrToIntDef(Copy(S, AnsiPos('/', S)+1, MaxInt), Default);
end;


function QuoteStr(const S: String): String;
var
  C: Integer;
  StrTmp: String;
  LastChar: PChar;
  Quote: Char;
  HaveSQ, HaveDQ: Boolean;
begin
  Quote := '"';
  HaveDQ := AnsiPos('"', S) > 0;
  HaveSQ := AnsiPos(#39, S) > 0;
  if HaveDQ then
  begin
    if not HaveSQ then
      Quote := #39
    else
      Quote := '`';
  end else
  if HaveSQ then
  begin
    if not HaveDQ then
      Quote := '"'
    else
      Quote := '`';
  end;
  // if multiline then append lines
  with TStringList.Create do
  try
    Text := Quote + S + Quote;
    for C := 0 to Count - 2 do
    begin
     StrTmp := Strings[C];
     LastChar := AnsiLastChar(StrTmp);
     if (LastChar = nil) or (LastChar^ <> '\') then
       Strings[C] := StrTmp + '$\r$\n \';
    end;
    Result := Trim(Text);
  finally
    Free;
  end;
end;

function ShellIconIndex(const FileName: String): Integer;
var
  SHInfo: TSHFileInfo;
begin
  if FileExists(FileName) then
    SHGetFileInfo(PChar(FileName), 0, SHInfo, SizeOf(TSHFileInfo), SHGFI_SYSICONINDEX)
  else
    SHGetFileInfo(PChar(FileName), FILE_ATTRIBUTE_NORMAL, SHInfo, SizeOf(TSHFileInfo),
       SHGFI_SYSICONINDEX or SHGFI_USEFILEATTRIBUTES);
  Result := SHInfo.iIcon;
end;

function SwitchPassed(const Switch: string): Boolean;
begin
  Result := FindCmdLineSwitch(Switch, ['/', '-'], True);
end;

procedure CreateLangIfNil;
begin
  if LangIni = nil then
    LangIni := TMemIniFile.Create(LangFile);
end;

function ConvertNewLines(const S: String; const Normal: Boolean = True): String;
begin
  if Normal then
  begin
    Result := ChangeVar(S, '\\', '\');
    Result := ChangeVar(Result, '\r', #13);
    Result := ChangeVar(Result, '\n', #10);
  end else
  begin
    Result := ChangeVar(S, '\', '\\');
    Result := ChangeVar(Result, #13, '\r');
    Result := ChangeVar(Result, #10, '\n');
  end;
end;

function IsValidIOFile(const FileName: String): Boolean;
var
  I, C: Integer;
begin
  with TIniFile.Create(FileName) do
  try
    C := ReadInteger('Settings', 'NumFields', -1);
    Result := C > -1;
    if Result then for I := 1 to C do
    if not SectionExists('Field ' + IntToStr(I)) then
    begin
      Result := False;
      Break;
    end;
  finally
    Free;
  end;
end;

procedure SynEditExportLines(Edit: TSynEdit; SynExporterClass: TSynExporterClass;
  AFileName: String);
begin
  with SynExporterClass.Create(Application) do
  try
    Highlighter := Edit.Highlighter;
    ExportAll(Edit.Lines);
    SaveToFile(AFileName);
  finally
    Free;
  end;
end;

function DialogUnitsToPixelsX(DlgUnits, DUX: Integer): Integer;
begin
  Result := MulDiv(DlgUnits, DUX, 4);
end;

function DialogUnitsToPixelsY(DlgUnits, DUY: Integer): Integer;
begin
  Result := MulDiv(DlgUnits, DUY, 8);
end;

function PixelsToDialogUnitsX(PixUnits, DUX: Integer): Integer;
begin
  Result := PixUnits * 4 div DUX;
end;

function PixelsToDialogUnitsY(PixUnits, DUY: Integer): Integer;
begin
  Result := PixUnits * 8 div DUY;
end;

function GetAveCharSize(Canvas: TCanvas): TPoint;
var
  I: Integer;
  Buffer: array[0..51] of Char;
begin
  for I := 0 to 25 do Buffer[I] := Chr(I + Ord('A'));
  for I := 0 to 25 do Buffer[I + 26] := Chr(I + Ord('a'));
  GetTextExtentPoint32(Canvas.Handle, Buffer, 52, TSize(Result));
  Result.X := Result.X div 52;
end;


procedure AddWinLong(Handle: HWND; Index, Long: Longint);
begin
  SetWindowLong(Handle, Index, GetWindowLong(Handle, Index) or Long);
end;

procedure RemoveWinLong(Handle: HWND; Index, Long: Longint);
begin
  SetWindowLong(Handle, Index, GetWindowLong(Handle, Index) and not Long);
end;


procedure InitFont(Font: TFont);
begin
  CreateLangIfNil;
  { Thanks to Romain Petges (www.petges.com) for this routine }
  Font.Name := LangIni.ReadString('Fonts', 'DialogFontName', 'MS Shell Dlg');
  Font.Size := LangIni.ReadInteger('Fonts', 'DialogFontSize', 8);
end;

function IsConsole(const FileName: String): Boolean;
var
  FI: TSHFileInfo;
begin
  Result := SHGetFileInfo(PChar(FileName), 0, FI, SizeOf(TSHFileInfo),
    SHGFI_EXETYPE) = IMAGE_NT_SIGNATURE;
end;

type
  TControlAccess = class(TControl);
procedure SetCtrlEnabled(Control: TControl; Enabled: Boolean);
begin
  Control.Enabled := Enabled;
  TControlAccess(Control).Color := EnabledColors[Enabled];
end;

function CreatePipeAndProcess(const CmdLine: String; var ProcessHandle,
   ReadPipe: THandle): Boolean;
var
  StartupInfo: TStartupInfo;
  ProcessInfo: TProcessInformation;
  SecurityDescript: TSecurityDescriptor;
  SecurityAttri: TSecurityAttributes;
  WritePipe: THandle;
  LastError: Cardinal;
begin
    SecurityAttri.nLength := SizeOf(TSecurityAttributes);
    SecurityAttri.bInheritHandle := True;
    SecurityAttri.lpSecurityDescriptor := nil;
    if Win32Platform = VER_PLATFORM_WIN32_NT then
    begin
      InitializeSecurityDescriptor(@SecurityDescript, SECURITY_DESCRIPTOR_REVISION);
      SetSecurityDescriptorDacl(@SecurityDescript, True, nil, False);
      SecurityAttri.lpSecurityDescriptor := @SecurityDescript;
    end;

    Result := CreatePipe(ReadPipe, WritePipe, @SecurityAttri, 0);
    if Result then
    begin
      FillStartupInfo(StartupInfo, WritePipe);
      Result := CreateProcess(nil, PChar(CmdLine), nil, nil, True, 0, nil, nil,
         StartupInfo, ProcessInfo);
      LastError := GetLastError;
      CloseHandle(WritePipe);
      if Result then
      begin
        ProcessHandle := ProcessInfo.hProcess;
        CloseHandle(ProcessInfo.hThread);
      end else
      begin
        CloseHandle(ReadPipe);
        SetLastError(LastError);
      end;
    end;
end;

procedure RegisterAsDefaultEditor;
var
  Reg: TRegistry;

  procedure Error;
  begin
    { This need to be in the language file }
    raise Exception.Create('Can''t register extension.');
  end;

  function GetKeyValue(const Key, Default: String): String;
  begin
    Reg.CloseKey;
    if Reg.OpenKey(Key, True) then
     Result := Reg.ReadString('')
    else
      Error;
    if Result = '' then
    begin
      Result := Default;
      Reg.WriteString('', Result);
    end;
  end;

  procedure SetKeyValue(const Key, Value: String);
  begin
    Reg.CloseKey;
    if Reg.OpenKey(Key, True) then
      Reg.WriteString('', Value)
    else
      Error;
  end;

var
  S: String;

  procedure SetAsosiation(const Desc: String);
  begin
    GetKeyValue(S, Desc);
    GetKeyValue(S + '\DefaultIcon', ParamStr(0)+',1');
    SetKeyValue(S + '\Shell\open\Command', ParamStr(0) + ' "%1"');
  end;

begin
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CLASSES_ROOT;
    S := GetKeyValue('.nsi', 'NSIS.Script');
    SetAsosiation('NSIS Script File');
    S := GetKeyValue('.nsh', 'NSIS.Header');
    SetAsosiation('NSIS Header File');
    SHChangeNotify(SHCNE_ASSOCCHANGED, SHCNF_IDLIST, nil, nil);
  finally
    Reg.Free;
  end;
end;

procedure HaltIfRunning;
var
  CopyDataStruct: TCopyDataStruct;

  function AlreadyRunning: Boolean;
  var
    Wnd: HWnd;
    Cmds: TStrings;
    C: Integer;
  begin
    Wnd := FindWindow(SMainClassName, nil);
    Result := IsWindow(Wnd) and (not OptionsIni.ReadBool('Options', 'AllowMultiInst', False));
    if Result then
    begin
      Cmds := TStringList.Create;
      try
        for C := 1 to ParamCount do
          Cmds.Add(ParamStr(C));

        CopyDataStruct.dwData := SecondInstCmds;
        CopyDataStruct.cbData := Length(Cmds.Text);
        CopyDataStruct.lpData := PChar(Cmds.Text);

        SendMessage(Wnd, WM_COPYDATA, wParam(Application.Handle),
          lParam(@CopyDataStruct));
      finally
        Cmds.Free;
      end;
    end;
  end;

begin
  try
    if AlreadyRunning then Halt(1);
  except
    Application.HandleException(Application);
  end;
end;

function ShortToLongPath(const ShortName: string): string;
var
  LastSlash: PChar;
  TempPathPtr: PChar;

  function ShortToLongFileName: String;
  var
    FindData: TWin32FindData;
    Handle: THandle;
  begin
    Handle := FindFirstFile(TempPathPtr, FindData);
    if Handle <> INVALID_HANDLE_VALUE then
    begin
      Result := String(FindData.cFileName);
      if Result = '' then
        Result := String(FindData.cAlternateFileName);
    end else
      Result := '';
    Windows.FindClose(Handle);
  end;

  function IsShortFileName: Boolean;
  var
    I: Integer;
  begin
    I := AnsiPos('~', ShortName);
    Result := (I > 0) and (I < Length(ShortName)) and
       (ShortName[I + 1] in ['0'..'9']);
  end;

begin
  if FileExists(ShortName) and IsShortFileName then
  begin
    TempPathPtr := PChar(ShortName);
    LastSlash := AnsiStrRScan(TempPathPtr, '\');
    Result := '';
    while LastSlash <> nil do
    begin
      Result := '\' + ShortToLongFileName + Result;
      if LastSlash <> nil then
      begin
        LastSlash^ := #0;
        LastSlash := AnsiStrRScan(TempPathPtr, '\');
      end;
    end;
    Result := TempPathPtr + Result;
  end else
  Result := ShortName;
end;


function ChangeVar(const S, VarName, NewValue: String): String;
begin
  Result := StringReplace(S, VarName, NewValue, [rfReplaceAll]);
end;

function ExtractStr(var S: String; Delim: String): String;
var
  I: Integer;
begin
  I := AnsiPos(Delim, S);
  if I = 0 then I := Length(S)+1;
  Result := Copy(S, 1, I-1);
  S := Copy(S, I+1, Maxint);
end;

function StrListToCommaList(StrList: TStrings; Delim: String): String;
var
  C: Integer;
begin
  Result := '';
  for C := 0 to StrList.Count - 1 do
  begin
    Result := Result + StrList[C];
      if C < StrList.Count - 1 then
        Result := Result + Delim;    
  end;
end;

procedure CommaListToStrList(CommaList, Delim: String; StrList: TStrings);
var
  S: String;
  I: Integer;
begin
   StrList.BeginUpdate;
   try
     StrList.Clear;
     while CommaList <> '' do
     begin
       I := AnsiPos(Delim, CommaList);
       if I = 0 then I := Length(CommaList) + Length(Delim);
       S := Copy(CommaList, 1, I-1);
       Delete(CommaList, 1, I + Length(Delim) - 1);
       StrList.Add(S);
     end;
   finally
     StrList.EndUpdate;
   end;
end;


procedure AssignActionText(Action: TAction; const TextId: String);
var
  I: Integer;
  Temp, aCaption, aShortCut: String;
begin
  Temp := LangStr(TextId);
  aCaption := ExtractStr(Temp, '|');
  Action.Caption := aCaption;
  I := AnsiPos('&', aCaption);
  aShortCut := Trim(ExtractStr(Temp, '|'));
  if aShortCut <> '' then
    Action.ShortCut := TextToShortCut(aShortCut);
  if I > 0 then Delete(aCaption, I, 1);
  Action.Hint := aCaption + '|' + ExtractStr(Temp, '|');
end;

procedure InitStartupInfo(var StartupInfo: TStartupInfo);
begin
  FillChar(StartupInfo, SizeOf(StartupInfo), 0);
  StartupInfo.cb := SizeOf(StartupInfo);
end;

procedure FillStartupInfo(var StartupInfo: TStartupInfo; const OutHandle: THandle);
begin
  InitStartupInfo(StartupInfo);
  StartupInfo.dwFlags := STARTF_USESHOWWINDOW or STARTF_USESTDHANDLES;
  StartupInfo.wShowWindow := SW_HIDE;
  StartupInfo.hStdOutput := OutHandle;
  StartupInfo.hStdError := OutHandle;
end;

function GetLangFileFilter(const Strs: Array of String): String;
var
  C: Integer;
begin
  Result := '';
  for C := Low(Strs) to High(Strs) do
  begin
    if Strs[C] = '' then Break;
    Result := Result + LangStr(Strs[C]);
    if AnsiLastChar(Result)^ <> '|' then
      Result := Result + '|';
  end;
  Result :=  Result + LangStr('AllFileFilter');
end;

function ColorToHTML(const Color: TColor): String;
var
  ColorRef: TColorRef;
begin
  ColorRef := ColorToRGB(Color);
  Result := Format('%.2x%.2x%.2x', [GetRValue(ColorRef),
     GetGValue(ColorRef), GetBValue(ColorRef)]);
end;


function DirExists(const Name: string): Boolean;
var
  Code: Integer;
begin
  Code := GetFileAttributes(PChar(Name));
  Result := (Code <> -1) and (FILE_ATTRIBUTE_DIRECTORY and Code <> 0);
end;

function QuoteIfNeeded(const S: String): String;
begin
  Result := S;
  if AnsiPos(' ', Result) > 0 then
    Result := QuoteStr(Result);
end;

function UnQuote(const S: String): String;
begin
  Result := S;
  if (Result <> '') and (Result[1] in Quotes) then Delete(Result, 1, 1);
  if (Result <> '') and (Result[Length(Result)] in Quotes) then
    SetLength(Result, Length(Result)-1);
end;

function AddPeriod(const S: String): String;
begin
  Result := S;
  if not (AnsiLastChar(Result)^ in ['.', '!', '?', ';']) then
    Result := Result + '.';
end;

function InputQuery(const ACaption, Prompt: String; var S: String): Boolean;
begin
  with TInputQueryFrm.Create(Application) do
  try
    Edit1.Text := S;
    Caption := ACaption;
    Label1.Caption := Prompt;
    Result := ShowModal = mrOK;
    if Result then S := Edit1.Text;
  finally
    Free;
  end;
end;

function LangStr(const S: String; const DefaultText: String = ''): String;
var
  S1: String;
begin
  Result := DefaultText;
  if S <> '' then
  begin
    CreateLangIfNil;
    S1 := LangIni.ReadString('Strings', S, '');
    if S1 = '' then
      S1 := LangIni.ReadString('Strings', 'n_' + S, S);
    Result := ChangeVar(S1, '$nl', #13#10);
    if (DefaultText <> '') and (Result = S) then
      Result := DefaultText;
  end;
end;

procedure ResetLang(const NewLangFile: String);
begin
  FreeAndNil(LangIni);
  LangFile := NewLangFile;
end;

function LangStrFormat(const S: String; const Args: array of const): String;
begin
  Result := Format(LangStr(S), Args);
end;

function QuestionDlg(const Msg: String; Flags: Integer = mbQuestion): Integer;
begin
  Result := Application.MessageBox(PChar(AddPeriod(Msg)),
    PChar(LangStr('QuestionDlgCaption')), Flags);
end;

function ErrorDlg(const Msg: String; Flags: Integer = mbError): Integer;
begin
  Result := Application.MessageBox(PChar(AddPeriod(Msg)),
    PChar(LangStr('ErrorDlgCaption')), Flags);
end;

function WarningDlg(const Msg: String; Flags: Integer = mbWarning): Integer;
begin
  Result := Application.MessageBox(PChar(AddPeriod(Msg)),
    PChar(LangStr('WarningDlgCaption')), Flags);
end;

function InfoDlg(const Msg: String; Flags: Integer = mbInfo): Integer;
begin
  Result := Application.MessageBox(PChar(AddPeriod(Msg)),
    PChar(LangStr('InformationDlgCaption')), Flags);
end;

procedure InitCompilerOutputParsingVars;
begin
  with TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'Config\CmpParsing.ini') do
  try
    SError := ReadString('Strings', 'ErrorInScript', SDefError);
    SOnLine := ReadString('Strings', 'OnLine', SDefOnLine);
    SConfigError := ReadString('Strings', 'ErrorInConfigOnLine', SDefConfigError);
    SIncError := ReadString('Strings', 'IncludeErrorInScript', SDefIncError);
    SAbort := ReadString('Strings', 'AbortingProcess', SDefAbort);
    SWarning := ReadString('Strings', 'Warning', SDefWarning);
    SOutput := ReadString('Strings', 'Output', SDefOutput);
  finally
    Free;
  end;
end;



procedure GetCheckWidth;
begin
  with TBitmap.Create do
  try
    Handle := LoadBitmap(0, PChar(32759));
    CheckWidth := Width div 4;
    CheckHeight := Height div 3;
  finally
    Free;
  end;
end;

procedure CheckParams;
begin
  if SwitchPassed('rade') then
  begin
    try RegisterAsDefaultEditor; except Application.HandleException(Application); end;
    Halt;
  end;
end;

initialization
  Application.Title := AppName + ' ' + AppVersion;
  
  OptionsIniFileName := ChangeFileExt(ParamStr(0), '.ini');
  if FileExists(OptionsIniFileName) and not FileHaveAttri(OptionsIniFileName, faReadOnly) then
    OptionsIni := TIniFile.Create(OptionsIniFileName)
  else
    OptionsIni := TSafeRegistryIniFile.Create('Software\HM Software\NIS Edit');

  HaltIfRunning;
  ShowSplash;

  CheckParams;
  IsWinXP := (Win32Platform = VER_PLATFORM_WIN32_NT) and
  ((Win32MajorVersion > 5) or ((Win32MajorVersion = 5) and (Win32MinorVersion >= 1)));
  HintWindowClass := TShadowedHintWindow;
  GetCheckWidth;
finalization
  if HHCTRLHandle <> 0 then FreeLibrary(HHCTRLHandle);
  LangIni.Free;
  OptionsIni.Free;
end.
