{
  HM NIS Edit (c) 2003 Héctor Mauricio Rodríguez Segura <ranametal@users.sourceforge.net>
  For conditions of distribution and use, see license.txt

  Script Generation code
}
unit ScriptGen;

interface
uses
  Windows, Messages, SysUtils, Classes, Controls, Graphics;

type
  TCompressionType = (ctZlib, ctBZip2, ctLZMA, ctNone);
  TOverwriteType = (otNull, otOn, otOff, otTry, otIfNewer);
  TLicenseForceSelection = (lfsNoForce, lsfCheckBox, lsfRadioButtons);

  TSection = class(TObject)
  public
    Comment: String;
    Files: TStringList;
    constructor Create;
    destructor Destroy; override;
  end;

  TScriptGen = class(TObject)
  private
    Sections, UninstLinks, Links: TStringList;
    CreatedLinkFolders, UninstFiles, UninstDirs: TStringList;
  public
    AppName, Version, Publisher, InstDir,
    WebSite, Lang, LicenceFile, StartMenuDir,
    FinishRun, FinishParams, FinishReadme,
    MainExe, MainExeDir, InstIcon, UnInstIcon,
    ExeInst, UninstPrompt, UninstSuccessMsg: String;
    RelativeBase: String;
    BGTopColor, BGBottomColor, BGTextColor: TColor;
    UseBG: Boolean;
    CompressType: TCompressionType;
    Silent, ModernUI: Boolean;
    AllowDirChange, AllowComponetSelect,
    AllowCodeComments, AllowSelectStartMenu, CreateWebIcon,
    UseUninstaller, CreateUninstallIcon: Boolean;
    LicenseForceSelection: TLicenseForceSelection;
    constructor Create;
    destructor Destroy; override;
    procedure Generate(Lines: TStrings);
    function GetGroup(I: Integer): TSection;
    procedure AssignGroups(Strs: TStrings);
    procedure AddLink(const S: String);
  end;

const
  Overwrites: array[TOverwriteType] of String = ('', 'on', 'off', 'try', 'ifnewer');

  SDirs = '$INSTDIR'#13#10 +
          '$PROGRAMFILES'#13#10 +
          '$TEMP'#13#10 +
          '$DESKTOP'#13#10 +
          '$SYSDIR'#13#10 +
          '$EXEDIR'#13#10 +
          '$WINDIR'#13#10 +
          '$STARTMENU'#13#10 +             
          '$SMPROGRAMS'#13#10 +
          '$QUICKLAUNCH';

  SShortCutDirs = '$ICONS_GROUP'#13#10 +
                  '$DESKTOP'#13#10 +
                  '$STARTMENU'#13#10 +
                  '$SMPROGRAMS'#13#10 +
                  '$QUICKLAUNCH';



function GetFile(const S: string): String;
function GetDestDir(const S: string): String;
function GetOverwrite(const S: string): TOverwriteType;
implementation

uses Utils;

function GetFile(const S: string): String;
begin
  Result := GetShortHint(S);
end;

function GetDestDir(const S: string): String;
var I: Integer;
begin
  Result := GetLongHint(S);
  I := AnsiPos('|', Result);
  if I > 0 then Delete(Result, I, MaxInt);
end;

function GetOverwrite(const S: string): TOverwriteType;
begin
  Result := TOverwriteType(StrToIntDef(GetLongHint(GetLongHint(S)), Ord(otIfNewer)));
end;

{ TSection }

constructor TSection.Create;
begin
  Files := TStringList.Create;
end;

destructor TSection.Destroy;
begin
  Files.Free;
  inherited Destroy;
end;


procedure TScriptGen.AddLink(const S: String);
begin
  Links.Add(S);
end;

procedure TScriptGen.AssignGroups(Strs: TStrings);
begin
  Sections.Assign(Strs);
end;

constructor TScriptGen.Create;
begin
  UninstFiles := TStringList.Create;
  UninstDirs := TStringList.Create;
  Sections := TStringList.Create;
  UninstLinks := TStringList.Create;
  Links := TStringList.Create;
  CreatedLinkFolders := TStringList.Create;
  CreatedLinkFolders.Text := SShortCutDirs;
end;

destructor TScriptGen.Destroy;
begin
  UnInstFiles.Free;
  UninstDirs.Free;
  Sections.Free;
  UninstLinks.Free;
  Links.Free;
  CreatedLinkFolders.Free;
  inherited;
end;


const
  SDelete = '  Delete %s';
  SRMDir = '  RMDir %s';
  SDefine = '!define ';
  SFile = '  File %s';
  SSection = 'Section %s SEC%.2d';
  SSectionEnd = 'SectionEnd';
  SInclude = '!include %s';
  SInsertMacro = '!insertmacro ';
  SUninstaller = '$INSTDIR\uninst.exe';
  SCreateDir = '  CreateDirectory %s';
  SShortCut = '  CreateShortCut ';
  SWriteIniStr = '  WriteIniStr %s %s %s %s';
  SStartMenuRegVal = 'NSIS:StartMenuDir';
  SWriteUninst = '  WriteUninstaller "$INSTDIR\uninst.exe"';
  SUninstKey1 = 'Software\Microsoft\Windows\CurrentVersion\Uninstall\';
  SProdUninstKey = SUninstKey1 + '${PRODUCT_NAME}';
  SCommentStart = '; ';


procedure TScriptGen.Generate(Lines: TStrings);
var
  S, S2, LastDir, StartMenu, Name: String;
  LastOverwrite: TOverwriteType;
  C, I: Integer;

  function GetRelative(const S: String): String;
  begin
    if (RelativeBase <> '') and (AnsiPos('${NSISDIR}', S) = 0) then
      Result := ExtractRelativePath(RelativeBase, S)
    else
      Result := S
  end;

  procedure AddFormat(const S: String; Args: array of const);
  begin
    Lines.Append(Format(S, Args));
  end;

  procedure AddUnInstFile(const UnFile: String);
  begin
    if UseUninstaller then
    begin
      if SameText(ExtractFileExt(UnFile), '.hlp') then
      begin
        UninstFiles.Insert(0, Format(SDelete, [QuoteStr(ChangeFileExt(UnFile, '.fts'))]));
        UninstFiles.Insert(0, Format(SDelete, [QuoteStr(ChangeFileExt(UnFile, '.gid'))]));
      end;
      UninstFiles.Insert(0, Format(SDelete, [QuoteStr(UnFile)]));
    end;
  end;

  procedure AddUninstDir(const Dir: String);
  var
    D: string;
  begin
    D := Format(SRMDir, [QuoteStr(Dir)]);
    if UninstDirs.IndexOf(D) < 0 then
      UnInstDirs.Append(D);
  end;

  procedure Define(const Simbol: String; const Value: String = '');
  var
    S: String;
  begin
    S := SDefine + Simbol;
    if Value <> '' then
      S := S + ' ' + QuoteStr(Value);
    Lines.Append(S);
  end;

  procedure AddUnInstLink(const Lnk: String);
  begin
    UninstLinks.Insert(0, Format('  Delete %s', [QuoteStr(Lnk)]));
  end;

  procedure AddDirectory(const Dir: String);
  begin
    AddFormat(SCreateDir, [QuoteStr(Dir)]);
    AddUninstDir(Dir);
  end;

  procedure AddShortCut(const LinkFile, DestFile: String);
  var
    S: String;

    function DirCreated: Boolean;
    var
      I: Integer;
    begin
      Result := True;
      for I := 0 to CreatedLinkFolders.Count - 1 do
       if AnsiPos(S, CreatedLinkFolders[I]) = 1 then Exit;
      Result := False
    end;

  begin
    S := ExtractFileDir(LinkFile);
    if CreatedLinkFolders.IndexOf(S) < 0 then
    begin
      if not DirCreated then AddDirectory(S);
      AddUninstDir(S);
      CreatedLinkFolders.Add(S);
    end;

    S := ChangeFileExt(LinkFile, '.lnk');
    Lines.Append(SShortCut + QuoteStr(S) + ' ' + QuoteStr(DestFile));
    AddUnInstLink(S);
  end;

  procedure AddFile(F: String);
  var
    TargetFile: String;

    procedure AddLinks;
    var
      C, I: Integer;
      Lnk, Dest: String;
    begin
      C := 0;
      while C < Links.Count do
      begin
        Lnk := GetFile(Links[C]);
        Dest := GetDestDir(Links[C]);
        if SameText(TargetFile, Dest) then
        begin
          I := AnsiPos('\', Lnk) - 1;
          if SameText(Copy(Lnk, 1, I), '$ICONS_GROUP') then
          begin
            Delete(Lnk, 1, I);
            Lnk := StartMenu + Lnk;
          end;
          AddShortCut(Lnk, Dest);
          Links.Delete(C);
        end else Inc(C);
      end;
    end;

  begin
    F := GetRelative(F);
    AddFormat(SFile, [QuoteStr(F)]);
    TargetFile := IncludeTrailingBackSlash(LastDir) + ExtractFileName(F);
    AddLinks;
    AddUninstFile(TargetFile);
  end;

  procedure Include(IncFile: String);
  begin
    AddFormat(SInclude, [QuoteStr(IncFile)]);
  end;

  procedure AddLines(C: Integer);
  begin
    while C > 0 do begin
      Lines.Append('');
      Dec(C);
    end;
  end;

  procedure WriteIniStr(const IniFile, Section, Name, Value: string);
  begin
    AddFormat(SWriteIniStr, [QuoteStr(IniFile), QuoteStr(Section),
       QuoteStr(Name), QuoteStr(Value)]);
  end;

  procedure WriteRegStr(const Root, Key, Name, Value: String);
  begin
    AddFormat('  WriteRegStr %s %s %s %s', [Root, QuoteStr(Key), QuoteStr(Name),
      QuoteStr(Value)]);
  end;

  procedure WriteUninstValue(const Name, Value: String);
  begin
    if UseUninstaller then
      WriteRegStr('${PRODUCT_UNINST_ROOT_KEY}', '${PRODUCT_UNINST_KEY}', Name, Value);
  end;

  procedure AddComment(const CommentText: String; const XtraLines: Integer = 0);
  begin
    if AllowCodeComments then
    begin
      Lines.Append(SCommentStart + CommentText);
      if XtraLines > 0 then
        AddLines(XtraLines);
    end;
  end;

begin
  LastDir := '';
  LastOverwrite := otNull;

  Lines.BeginUpdate;
  try
    Lines.Clear;

    AddComment(LangStr('WizardHeaderComment',
     'Script generated by the HM NIS Edit Script Wizard.'), 1);

    { Defaulds }
    Name := '$(^Name)';
    StartMenu := '$SMPROGRAMS\' + StartMenuDir;
    if Lang = '' then Lang := LangStr('DefaultLangInst', '*');
    if Lang = '*' then Lang := 'English';

    { Helper defines }
    AddComment('HM NIS Edit Wizard helper defines');
    Define('PRODUCT_NAME', AppName);
    Define('PRODUCT_VERSION', Version);
    if Publisher <> '' then
      Define('PRODUCT_PUBLISHER', Publisher);
    if WebSite <> '' then
      Define('PRODUCT_WEB_SITE', WebSite);
    if MainExe <> '' then
      Define('PRODUCT_DIR_REGKEY', 'Software\Microsoft\Windows\CurrentVersion\App Paths\' + ExtractFileName(MainExe));
    if UseUninstaller then
    begin
      Define('PRODUCT_UNINST_KEY', SProdUninstKey);
      Define('PRODUCT_UNINST_ROOT_KEY', 'HKLM');
    end;
    if AllowSelectStartMenu then
      Define('PRODUCT_STARTMENU_REGVAL', SStartMenuRegVal);
    AddLines(1);

    if CompressType in [ctBZip2, ctLZMA] then
    begin
      case CompressType of
        ctBZip2: Lines.Append('SetCompressor bzip2');
        ctLZMA:  Lines.Append('SetCompressor lzma');
      end;
      AddLines(1);
    end;

    if ModernUI then
    begin
      { Include the header file }
      AddComment('MUI 1.67 compatible ------');
      Include('MUI.nsh');
      AddLines(1);

      { MUI Settings }
      AddComment('MUI Settings');
      Define('MUI_ABORTWARNING');
      if InstIcon <> '' then
        Define('MUI_ICON', GetRelative(InstIcon));
      if (UnInstIcon <> '') and UseUninstaller then
        Define('MUI_UNICON', GetRelative(UninstIcon));
      AddLines(1);

      // Welcome page
      AddComment('Welcome page');
      Lines.Append(SInsertmacro + 'MUI_PAGE_WELCOME');

      // License page
      if LicenceFile <> '' then
      begin
        AddComment('License page');
        case LicenseForceSelection of
          lsfCheckBox: Define('MUI_LICENSEPAGE_CHECKBOX');
          lsfRadioButtons: Define('MUI_LICENSEPAGE_RADIOBUTTONS');
        end;
        AddFormat(SInsertmacro + 'MUI_PAGE_LICENSE %s', [QuoteStr(GetRelative(LicenceFile))]);
      end;

      // Components page
      if AllowComponetSelect then
      begin
        AddComment('Components page');
        Lines.Append(SInsertmacro + 'MUI_PAGE_COMPONENTS');
      end;
      if AllowDirChange then
      begin
        AddComment('Directory page');
        Lines.Append(SInsertmacro + 'MUI_PAGE_DIRECTORY');
      end;

      // Startmenu page
      if AllowSelectStartMenu then
      begin
        AddComment('Start menu page');
        Lines.Append('var ICONS_GROUP');
        Define('MUI_STARTMENUPAGE_NODISABLE');
        Define('MUI_STARTMENUPAGE_DEFAULTFOLDER', StartMenuDir);
        Define('MUI_STARTMENUPAGE_REGISTRY_ROOT', '${PRODUCT_UNINST_ROOT_KEY}');
        Define('MUI_STARTMENUPAGE_REGISTRY_KEY', '${PRODUCT_UNINST_KEY}');
        Define('MUI_STARTMENUPAGE_REGISTRY_VALUENAME', '${PRODUCT_STARTMENU_REGVAL}');
        Lines.Append(SInsertmacro + 'MUI_PAGE_STARTMENU Application $ICONS_GROUP');
        StartMenu := '$SMPROGRAMS\$ICONS_GROUP';
      end;

      // Instfiles page
      AddComment('Instfiles page');
      Lines.Append(SInsertmacro + 'MUI_PAGE_INSTFILES');

      // Finish page
      AddComment('Finish page');
      if FinishRun <> '' then
        Define('MUI_FINISHPAGE_RUN', FinishRun);
      if FinishParams <> '' then
        Define('MUI_FINISHPAGE_RUN_PARAMETERS', FinishParams);
      if FinishReadme <> '' then
        Define('MUI_FINISHPAGE_SHOWREADME', FinishReadme);
      Lines.Append(SInsertmacro + 'MUI_PAGE_FINISH');

      // Uninstaller Pages
      if UseUninstaller then
      begin
        AddLines(1);
        AddComment('Uninstaller pages');
        Lines.Append(SInsertmacro + 'MUI_UNPAGE_INSTFILES');
      end;
      AddLines(1);

      { Insert language files }
      AddComment('Language files');
      Lines.Append(SInsertMacro + 'MUI_LANGUAGE ' + QuoteStr(Lang));

      { Reserve Files }
      if CompressType in [ctBZip2, ctLZMA] then
      begin
        AddLines(1);
        AddComment('Reserve files');
        Lines.Append(SInsertMacro + 'MUI_RESERVEFILE_INSTALLOPTIONS');
      end;
      AddLines(1);
      AddComment('MUI end ------', 1);
    end;

    Lines.Append('Name "${PRODUCT_NAME} ${PRODUCT_VERSION}"');
    AddFormat('OutFile %s', [QuoteStr(GetRelative(ExeInst))]);

    if (not ModernUI) and (not Silent) then
      AddFormat('LoadLanguageFile "${NSISDIR}\Contrib\Language files\%s.nlf"', [Lang]);

    AddFormat('InstallDir %s', [QuoteStr(InstDir)]);

    if not ModernUI then
    begin
      if InstIcon <> '' then AddFormat('Icon %s', [QuoteStr(GetRelative(InstIcon))]);
      if (UninstIcon <> '') and UseUninstaller then
         AddFormat('UninstallIcon %s', [QuoteStr(GetRelative(UninstIcon))]);
    end;

    if Silent then
    begin
      Lines.Append('SilentInstall silent');
      if UseUninstaller then Lines.Append('SilentUninstall silent');
    end;

    if MainExe <> '' then
      Lines.Append('InstallDirRegKey HKLM "${PRODUCT_DIR_REGKEY}" ""');

    if (not Silent) and AllowComponetSelect and (not ModernUI) then
       Lines.Append('ComponentText ' + QuoteStr(LangStr('ComponentText')));
    if (not Silent) and AllowDirChange and (not ModernUI) then
    begin
       S := ChangeVar(LangStr('DirText'), '[NAME]', Name);
       Lines.Append('DirText ' + QuoteStr(S));
    end;

    if (LicenceFile <> '') and (not Silent) then
    begin
      S := AddPeriod(ChangeVar(LangStr('LicenseText'), '[NAME]', Name));
      if not ModernUI then
      begin
        Lines.Append('LicenseText ' + QuoteStr(S));
        AddFormat('LicenseData %s', [QuoteStr(GetRelative(LicenceFile))]);
        case LicenseForceSelection of
          lsfCheckBox: Lines.Append('LicenseForceSelection checkbox');
          lsfRadioButtons: Lines.Append('LicenseForceSelection radiobuttons');
        end;
      end;
    end;

    if not Silent then
    begin
      Lines.Add('ShowInstDetails show');
      if UseUninstaller then Lines.Add('ShowUnInstDetails show');
    end;

    if UseBG then
    begin
      AddFormat('BGGradient %s %s %s', [ColorToHTML(BGTopColor),
        ColorToHTML(BGBottomColor), ColorToHTML(BGTextColor)]);
    end;

    if CompressType = ctNone then Lines.Append('SetCompress off');
    AddLines(1);

    {if Silent then
    begin
      Lines.Append('Function .onInstSuccess');
      Lines.Append('  MessageBox MB_ICONINFORMATION|MB_OK "La instalación de ' +
      Name + ' finalizó satisfactoriamente."');
      Lines.Append('FunctionEnd');
      Lines.Append('');
      Lines.Append('Function .onInit');
      Lines.Append('  MessageBox MB_ICONQUESTION|MB_YESNO "¿Esto instalará ' +
       Name + ' en su computadora. ¿Desea continuar?" IDYES +2');
      Lines.Append('  Abort');
      Lines.Append('FunctionEnd');
      Lines.Append('');
    end;}

    for C := 0 to Sections.Count - 1 do
    begin
      AddFormat(SSection, [QuoteStr(Sections[C]), C + 1]);
      for I := 0 to GetGroup(C).Files.Count - 1 do
      begin
        S := GetGroup(C).Files[I];
        if not AnsiSameText(LastDir, GetDestDir(S)) then
        begin
          LastDir := GetDestDir(S);
          AddFormat('  SetOutPath %s', [QuoteStr(LastDir)]);
          AddUninstDir(LastDir);
        end;
        if GetOverwrite(S) <> LastOverwrite then
        begin
          LastOverWrite := GetOverwrite(S);
          Lines.Append('  SetOverwrite ' + Overwrites[LastOverwrite]);
        end;
        S := GetFile(S);
        AddFile(S);
      end;
      Lines.Append(SSectionEnd);
      AddLines(1);
    end;
    AddUninstFile(SUninstaller);

    if CreatewebIcon or (CreateUninstallIcon and UseUninstaller) then
    begin
      Lines.Append('Section -AdditionalIcons');
      S2 := IncludeTrailingBackSlash(StartMenu);
      if CreateWebIcon then
      begin
        S := '$INSTDIR\${PRODUCT_NAME}.url';
        WriteIniStr(S, 'InternetShortcut', 'URL', '${PRODUCT_WEB_SITE}');
        AddUninstFile(S);
        AddShortCut(S2 + 'Website', S);
      end;
      if CreateUninstallIcon and UseUninstaller then
        AddShortCut(S2 + 'Uninstall', SUninstaller);
      Lines.Append(SSectionEnd);
      AddLines(1);
    end;

    Lines.Append('Section -Post');
    if UseUninstaller then Lines.Append(SWriteUninst);
    if MainExe <> '' then
      Lines.Append('  WriteRegStr HKLM "${PRODUCT_DIR_REGKEY}" "" ' + QuoteStr(MainExe));
    WriteUninstValue('DisplayName', Name);
    WriteUninstValue('UninstallString', SUninstaller);
    if MainExe <> '' then
      WriteUninstValue('DisplayIcon', MainExe);
    WriteUninstValue('DisplayVersion', '${PRODUCT_VERSION}');
    if AllowSelectStartMenu then
      WriteRegStr('${PRODUCT_UNINST_ROOT_KEY}', '${PRODUCT_UNINST_KEY}', '${PRODUCT_STARTMENU_REGVAL}', '$ICONS_GROUP');
    if WebSite <> '' then WriteUninstValue('URLInfoAbout', '${PRODUCT_WEB_SITE}');
    if Publisher <> '' then WriteUninstValue('Publisher', '${PRODUCT_PUBLISHER}');
    Lines.Append(SSectionEnd);

    { Set the descriptions for the sections }
    if ModernUI and AllowComponetSelect then
    begin
      AddLines(1);
      AddComment('Section descriptions');
      Lines.Append(SInsertMacro + 'MUI_FUNCTION_DESCRIPTION_BEGIN');
      for C := 0 to Sections.Count - 1 do
        Lines.Append('  ' + SInsertMacro + Format('MUI_DESCRIPTION_TEXT ${SEC%.2d} %s', [C+1, QuoteStr(GetGroup(C).Comment)]));
      Lines.Append(SInsertMacro + 'MUI_FUNCTION_DESCRIPTION_END');
    end;

    if UseUninstaller then
    begin
      AddLines(2);
      UninstSuccessMsg := ChangeVar(UninstSuccessMsg, '[NAME]', Name);
      if UninstSuccessMsg <> '' then
      begin
        Lines.Append('Function un.onUninstSuccess');
        if not Silent then Lines.Append('  HideWindow');
        AddFormat('  MessageBox MB_ICONINFORMATION|MB_OK %s', [QuoteStr(UninstSuccessMsg)]);
        Lines.Append('FunctionEnd');
        Lines.Append('');
      end;

      UninstPrompt := ChangeVar(UninstPrompt, '[NAME]', Name);
      if UninstPrompt <> '' then
      begin
        Lines.Append('Function un.onInit');
        AddFormat('  MessageBox MB_ICONQUESTION|MB_YESNO|MB_DEFBUTTON2 %s IDYES +2', [QuoteStr(UninstPrompt)]);
        Lines.Append('  Abort');
        Lines.Append('FunctionEnd');
        Lines.Append('');
      end;

      Lines.Append('Section Uninstall');
      if AllowSelectStartMenu and ModernUI then
        Lines.Append('  ReadRegStr $ICONS_GROUP ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "${PRODUCT_STARTMENU_REGVAL}"');
      Lines.AddStrings(UninstFiles);
      AddLines(1);
      Lines.AddStrings(UninstLinks);
      if UninstLinks.Count > 0 then AddLines(1);
      UninstDirs.Sort;
      for C := UninstDirs.Count - 1 downto 0 do
        Lines.Append(UninstDirs[C]);
      AddLines(1);
      Lines.Append('  DeleteRegKey ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}"');
      if MainExe <> '' then
        Lines.Append('  DeleteRegKey HKLM "${PRODUCT_DIR_REGKEY}"');
      Lines.Append('  SetAutoClose true');
      Lines.Append(SSectionEnd);
    end;
  finally
    Lines.EndUpdate;
  end;
end;

function TScriptGen.GetGroup(I: Integer): TSection;
begin
  Result := TSection(Sections.Objects[I]);
end;

end.
