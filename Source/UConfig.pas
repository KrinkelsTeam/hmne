{
  HM NIS Edit (c) 2003 Héctor Mauricio Rodríguez Segura <ranametal@users.sourceforge.net>
  For conditions of distribution and use, see license.txt

  Configuration window

}
unit UConfig;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ComCtrls, SynEdit, SynEditHighlighter,
  SynHighlighterNSIS, MySynEditorOptionsContainer, TBX, TBXThemes,
  NewGroupBox;

type
  TConfigFrm = class(TForm)
    CancelarBtn: TButton;
    AceptarBtn: TButton;
    ColorDlg: TColorDialog;
    FontDlg: TFontDialog;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    PageControl2: TPageControl;
    TabSheet4: TTabSheet;
    gbGutter: TNewGroupBox;
    Label1: TStaticText;
    ckGutterShowLineNumbers: TCheckBox;
    ckGutterShowLeaderZeros: TCheckBox;
    ckGutterStartAtZero: TCheckBox;
    ckGutterVisible: TCheckBox;
    cbGutterFont: TCheckBox;
    btnGutterFont: TButton;
    pGutterBack: TPanel;
    pGutterColor: TPanel;
    pnlGutterFontDisplay: TPanel;
    lblGutterFont: TStaticText;
    gbRightEdge: TNewGroupBox;
    Label3: TStaticText;
    Label10: TStaticText;
    pRightEdgeBack: TPanel;
    pRightEdgeColor: TPanel;
    eRightEdge: TEdit;
    gbBookmarks: TNewGroupBox;
    ckBookmarkKeys: TCheckBox;
    ckBookmarkVisible: TCheckBox;
    gbEditorFont: TNewGroupBox;
    btnFont: TButton;
    Panel3: TPanel;
    labFont: TStaticText;
    gbLineSpacing: TNewGroupBox;
    Label8: TStaticText;
    Label9: TStaticText;
    eLineSpacing: TEdit;
    eTabWidth: TEdit;
    TabSheet5: TTabSheet;
    gbOptions: TNewGroupBox;
    ckAutoIndent: TCheckBox;
    ckDragAndDropEditing: TCheckBox;
    ckHalfPageScroll: TCheckBox;
    ckScrollByOneLess: TCheckBox;
    ckScrollPastEOF: TCheckBox;
    ckScrollPastEOL: TCheckBox;
    ckShowScrollHint: TCheckBox;
    ckSmartTabs: TCheckBox;
    ckTabsToSpaces: TCheckBox;
    ckTrimTrailingSpaces: TCheckBox;
    ckAltSetsColumnMode: TCheckBox;
    ckKeepCaretX: TCheckBox;
    ckScrollHintFollows: TCheckBox;
    ckGroupUndo: TCheckBox;
    ckSmartTabDelete: TCheckBox;
    ckRightMouseMoves: TCheckBox;
    ckEnhanceHomeKey: TCheckBox;
    ckHideShowScrollbars: TCheckBox;
    ckDisableScrollArrows: TCheckBox;
    ckShowSpecialChars: TCheckBox;
    gbCaret: TNewGroupBox;
    Label2: TStaticText;
    Label4: TStaticText;
    cInsertCaret: TComboBox;
    cOverwriteCaret: TComboBox;
    TabSheet6: TTabSheet;
    GroupBox11: TNewGroupBox;
    Label7: TStaticText;
    HighLightChk: TCheckBox;
    SynEdit: TSynEdit;
    GroupBox13: TNewGroupBox;
    Bevel1: TBevel;
    Label5: TStaticText;
    Label6: TStaticText;
    Bevel2: TBevel;
    Panel2: TPanel;
    Panel4: TPanel;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    HLVarsInStrsChk: TCheckBox;
    ListBox: TListBox;
    GroupBox2: TNewGroupBox;
    ThemeList: TComboBox;
    GroupBox3: TNewGroupBox;
    WelcomeDialogChk: TCheckBox;
    MultInstChk: TCheckBox;
    Label11: TStaticText;
    ckViewUsageHints: TCheckBox;
    ckUndoAfterSave: TCheckBox;
    Label13: TStaticText;
    GroupBox1: TNewGroupBox;
    RegisterBtn: TButton;
    SDragToolBarsChk: TCheckBox;
    SDragPanelsChk: TCheckBox;
    GroupBox8: TNewGroupBox;
    Label14: TStaticText;
    Label15: TStaticText;
    CopilEdt: TEdit;
    ExaminarExeBtn: TButton;
    HTMLEdt: TEdit;
    ExaminarHtmlBtn: TButton;
    GroupBox7: TNewGroupBox;
    NoConfigChk: TCheckBox;
    NoCDChk: TCheckBox;
    GroupBox9: TNewGroupBox;
    SimbLst: TListView;
    AgregarBtn: TButton;
    EditarBtn: TButton;
    EliminarBtn: TButton;
    AbrirDlg: TOpenDialog;
    LangList: TComboBox;
    IniDesignerChk: TCheckBox;
    Label12: TStaticText;
    BrowserHomeEdt: TEdit;
    TabSheet7: TTabSheet;
    NewGroupBox1: TNewGroupBox;
    PluginsList: TListBox;
    ConfigPluginBtn: TButton;
    AboutPluginBtn: TButton;
    PluginFileNameLbl: TStaticText;
    NewGroupBox2: TNewGroupBox;
    DisplayGridChk: TCheckBox;
    StaticText1: TStaticText;
    GridSizeXEdt: TEdit;
    StaticText2: TStaticText;
    GridSizeYEdt: TEdit;
    SnapToGridChk: TCheckBox;
    RightBottomChk: TRadioButton;
    WidthHeightChk: TRadioButton;
    BothChk: TRadioButton;
    StaticText3: TStaticText;
    ApplyBtn: TButton;
    NewGroupBox3: TNewGroupBox;
    StaticText4: TStaticText;
    RegistryChk: TRadioButton;
    IniFileChk: TRadioButton;
    SaveFileListChk: TCheckBox;
    SplashChk: TCheckBox;
    UseDefBrowserChk: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure HighLightChkClick(Sender: TObject);
    procedure ListBoxClick(Sender: TObject);
    procedure SelectColor(Sender: TObject);
    procedure AttriChange(Sender: TObject);
    procedure HLVarsInStrsChkClick(Sender: TObject);
    procedure btnGutterFontClick(Sender: TObject);
    procedure btnFontClick(Sender: TObject);
    procedure RegisterBtnClick(Sender: TObject);
    procedure LangListClick(Sender: TObject);
    procedure AgregarBtnClick(Sender: TObject);
    procedure EditarBtnClick(Sender: TObject);
    procedure EliminarBtnClick(Sender: TObject);
    procedure SimbLstDblClick(Sender: TObject);
    procedure SimbLstKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ExaminarExeBtnClick(Sender: TObject);
    procedure ExaminarHtmlBtnClick(Sender: TObject);
    procedure ckGutterShowLineNumbersClick(Sender: TObject);
    procedure ckGutterVisibleClick(Sender: TObject);
    procedure PluginsListClick(Sender: TObject);
    procedure ConfigPluginBtnClick(Sender: TObject);
    procedure AboutPluginBtnClick(Sender: TObject);
    procedure PluginsListDblClick(Sender: TObject);
    procedure ApplyBtnClick(Sender: TObject);
    procedure BrowserHomeEdtChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    Liter: TSynNSISSyn;
    FAvailableTBXThemes: TStringList;
    LangChanged: Boolean;
    SaveForeground, SaveBackground: TColor;
    UpdateUsageList, NoUpdateAtrri: Boolean;
    FSynEdit: TMySynEditorOptionsContainer;
    procedure AbrirDlgCanClose(Sender: TObject; var CanClose: Boolean);

    procedure LoadLangStrings;
    procedure InitControlValues;
    procedure SaveOptions;
  public
    AddingSymbol: Boolean;
  end;

var
  ConfigFrm: TConfigFrm;

function ShowConfig(const NumPage: Integer = 0;
   const ShowOnlyThisPage: Boolean = False): Boolean;
implementation

uses IniFiles, Registry, Utils, UMain, UCustomMDIChild, UEditSimbol, UEdit,
  PluginsManger, PluginsInt, UIODesigner;

{$R *.DFM}

function ShowConfig(const NumPage: Integer = 0;
   const ShowOnlyThisPage: Boolean = False): Boolean;
var
  C: Integer;
begin
  ConfigFrm := TConfigFrm.Create(Application);
  try
    ConfigFrm.PageControl1.ActivePageIndex := NumPage;
    if ShowOnlyThisPage then
      for C := 0 to ConfigFrm.PageControl1.PageCount - 1 do
      if C <> NumPage then
       ConfigFrm.PageControl1.Pages[C].TabVisible := False;
    Result := ConfigFrm.ShowModal = mrOK;
    if Result then
      ConfigFrm.SaveOptions;
  finally
    FreeAndNil(ConfigFrm);
  end;
end;

procedure TConfigFrm.FormCreate(Sender: TObject);
var
  Found: Integer;
  SR: TSearchRec;
begin
  Found := FindFirst(ExtractFilePath(ParamStr(0)) + 'Lang\*.lng',
    faArchive, SR);
  while Found = 0 do
  begin
    LangList.Items.Add(ChangeFileExt(SR.Name, ''));
    Found := FindNext(SR);
  end;
  FindClose(SR);

  Liter := TSynNSISSyn.Create(Self);
  FAvailableTBXThemes := TStringList.Create;
  GetAvailableTBXThemes(FAvailableTBXThemes);
  FAvailableTBXThemes.Sort;

  LoadLangStrings;
  InitControlValues;
end;

procedure TConfigFrm.HighLightChkClick(Sender: TObject);
begin
  CheckBox1.Enabled := HighLightChk.Checked;
  CheckBox2.Enabled := HighLightChk.Checked;
  CheckBox3.Enabled := HighLightChk.Checked;
  Label7.Enabled := HighLightChk.Checked;
  Label5.Enabled := HighLightChk.Checked;
  Label6.Enabled := HighLightChk.Checked;
  HLVarsInStrsChk.Enabled := HighLightChk.Checked;

  ListBox.Enabled := HighLightChk.Checked;
  ListBox.Color := EnabledColors[ListBox.Enabled];

  Panel2.Enabled := HighLightChk.Checked;
  Panel4.Enabled := HighLightChk.Checked;

  if HighLightChk.Checked then
  begin
    SynEdit.Highlighter := Liter;
    Panel2.Color := SaveForeground;
    Panel4.Color := SaveBackground;
  end else
  begin
    SynEdit.Highlighter := nil;
    SaveForeground := Panel2.Color;
    SaveBackground := Panel4.Color;
    Panel2.ParentColor := True;
    Panel4.ParentColor := True;
  end;
end;

procedure TConfigFrm.ListBoxClick(Sender: TObject);
var
  Attri: TSynHighlighterAttributes;
begin
  NoUpdateAtrri := True;
  try
    Attri := TSynHighlighterAttributes(ListBox.Items.Objects[ListBox.ItemIndex]);
    Panel2.Color := Attri.Foreground;
    Panel4.Color := Attri.Background;
    CheckBox1.Checked := fsBold in Attri.Style;
    CheckBox2.Checked := fsItalic in Attri.Style;
    CheckBox3.Checked := fsUnderline in Attri.Style;
  finally
    NoUpdateAtrri := False;
  end;
end;

procedure TConfigFrm.SelectColor(Sender: TObject);
begin
  ColorDlg.Color := TPanel(Sender).Color;
  if ColorDlg.Execute then
  begin
    TPanel(Sender).Color := ColorDlg.Color;
    AttriChange(Sender);
  end;
end;

procedure TConfigFrm.AttriChange(Sender: TObject);
var
  Attri: TSynHighlighterAttributes;
  FontStyle: TFontStyles;
begin
  if NoUpdateAtrri then Exit;
  Attri := TSynHighlighterAttributes(ListBox.Items.Objects[ListBox.ItemIndex]);
  Attri.Foreground := Panel2.Color;
  Attri.Background := Panel4.Color;
  FontStyle := [];
  if CheckBox1.Checked then Include(FontStyle, fsBold);
  if CheckBox2.Checked then Include(FontStyle, fsItalic);
  if CheckBox3.Checked then Include(FontStyle, fsUnderline);
  Attri.Style := FontStyle;
end;

procedure TConfigFrm.HLVarsInStrsChkClick(Sender: TObject);
begin
  Liter.HighlightVarsInsideStrings := HLVarsInStrsChk.Checked;
end;

procedure TConfigFrm.btnGutterFontClick(Sender: TObject);
begin
  FontDlg.Font := lblGutterFont.Font;
  if FontDlg.Execute then
  begin
    lblGutterFont.Font := FontDlg.Font;
    lblGutterFont.Caption:= lblGutterFont.Font.Name + ' ' + IntToStr(lblGutterFont.Font.Size) + 'pt';
  end;
end;

procedure TConfigFrm.btnFontClick(Sender: TObject);
begin
  FontDlg.Font := labFont.Font;
  if FontDlg.Execute then
  begin
    labFont.Font := FontDlg.Font;
    SynEdit.Font := FontDlg.Font;
    labFont.Caption:= labFont.Font.Name + ' ' + IntToStr(labFont.Font.Size) + 'pt';
  end;
end;

procedure TConfigFrm.RegisterBtnClick(Sender: TObject);
begin
  RegisterAsDefaultEditor;
  InfoDlg(LangStr('SuccessfullyRegister'));
end;

procedure TConfigFrm.LangListClick(Sender: TObject);
begin
  LangChanged := True;
  MainFrm.RememberLang := True;
end;

procedure TConfigFrm.AgregarBtnClick(Sender: TObject);
var
  S, V: String;
begin
  S := '';
  V := '';
  AddingSymbol := True;
  if EditSimbol(S, V) and (S <> '') then
  with SimbLst.Items.Add do
  begin
    Caption := S;
    SubItems.Add(V);
  end;
end;

procedure TConfigFrm.EditarBtnClick(Sender: TObject);
var
  S, V: String;
begin
  AddingSymbol := False;
  if SimbLst.Selected <> nil then
  with SimbLst.Selected do
  begin
    S := Caption;
    V := SubItems[0];
    if EditSimbol(S, V) then
    begin
      Caption := S;
      SubItems[0] := V;
    end;
  end;
end;

procedure TConfigFrm.EliminarBtnClick(Sender: TObject);
begin
  if SimbLst.Selected <> nil then
    SimbLst.Selected.Delete;
end;

procedure TConfigFrm.SimbLstDblClick(Sender: TObject);
begin
  EditarBtn.Click;
end;

procedure TConfigFrm.SimbLstKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_INSERT: AgregarBtn.Click;
    VK_RETURN: EditarBtn.Click;
    VK_DELETE: EliminarBtn.Click;
  end;
end;

procedure TConfigFrm.ExaminarExeBtnClick(Sender: TObject);
begin
  AbrirDlg.Filter := GetLangFileFilter(['ExeFileFilter']);
  AbrirDlg.FileName := ExtractFileName(CopilEdt.Text);
  AbrirDlg.InitialDir := ExtractFileDir(CopilEdt.Text);
  AbrirDlg.OnCanClose := AbrirDlgCanClose;
  if AbrirDlg.Execute then
  begin
    UpdateUsageList := True;
    MainFrm.NSISVersion := '';
    CopilEdt.Text := AbrirDlg.FileName;
  end;
end;

procedure TConfigFrm.ExaminarHtmlBtnClick(Sender: TObject);
begin
  AbrirDlg.Filter := GetLangFileFilter(['HelpFileFilter', 'CHMFileFilter', 'HTMLFileFilter']);
  AbrirDlg.FileName := ExtractFileName(HTMLEdt.Text);
  AbrirDlg.InitialDir := ExtractFileDir(HTMLEdt.Text);
  AbrirDlg.OnCanClose := nil;
  if AbrirDlg.Execute then
    HTMLEdt.Text := AbrirDlg.FileName;
end;

procedure TConfigFrm.AbrirDlgCanClose(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose := True;
  if not IsConsole(AbrirDlg.FileName) then
  begin
    ErrorDlg(LangStrFormat('NoConsole', [Abrirdlg.FileName]));
    CanClose := False;
  end;
end;

procedure TConfigFrm.ckGutterShowLineNumbersClick(Sender: TObject);
begin
  ckGutterStartAtZero.Enabled := ckGutterVisible.Checked and ckGutterShowLineNumbers.Checked;
  ckGutterShowLeaderZeros.Enabled := ckGutterStartAtZero.Enabled;
end;

procedure TConfigFrm.ckGutterVisibleClick(Sender: TObject);
begin
  ckGutterShowLineNumbersClick(Sender);
  ckGutterShowLineNumbers.Enabled := ckGutterVisible.Checked;
  cbGutterFont.Enabled := ckGutterVisible.Checked;
  btnGutterFont.Enabled := ckGutterVisible.Checked;
  lblGutterFont.Enabled := ckGutterVisible.Checked;
  Label1.Enabled := ckGutterVisible.Checked;
  pGutterColor.Enabled :=  ckGutterVisible.Checked;
end;

procedure TConfigFrm.PluginsListClick(Sender: TObject);
var
  Data: PPluginData;
  S: String;
begin
  if PluginsList.ItemIndex >= 0 then
  begin
     Data :=  PPluginData(PluginsList.Items.Objects[PluginsList.ItemIndex]);
     ConfigPluginBtn.Enabled := Assigned(Data.Config);
     AboutPluginBtn.Enabled := Assigned(Data.About);
     SetLength(S, MAX_PATH);
     SetLength(S, GetModuleFileName(Data.DllHandle, PChar(S), MAX_PATH));
     PluginFileNameLbl.Caption := LowerCase(S);
     S := '';
  end else
  begin
    ConfigPluginBtn.Enabled := False;
    AboutPluginBtn.Enabled := False;
    PluginFileNameLbl.Caption := '';
  end;
end;

procedure TConfigFrm.ConfigPluginBtnClick(Sender: TObject);
begin
  PPluginData(PluginsList.Items.Objects[PluginsList.ItemIndex]).Config(Handle);
end;

procedure TConfigFrm.AboutPluginBtnClick(Sender: TObject);
begin
  PPluginData(PluginsList.Items.Objects[PluginsList.ItemIndex]).About(Handle);
end;

procedure TConfigFrm.PluginsListDblClick(Sender: TObject);
begin
  if ConfigPluginBtn.Enabled then
    ConfigPluginBtn.Click;
end;

procedure TConfigFrm.ApplyBtnClick(Sender: TObject);
begin
  SaveOptions;
  if LangChanged then LoadLangStrings;
  InitControlValues;
end;

procedure TConfigFrm.LoadLangStrings;
var
  C: Integer;
  S: String;
begin
  InitFont(Font);
  Caption := LangStr('ConfigCaption');
  TabSheet3.Caption := LangStr('CompilerConfigPage');
  TabSheet2.Caption := LangStr('EditorConfigPage');
  TabSheet1.Caption := LangStr('EnvironmentConfigPage');
  AceptarBtn.Caption := LangStr('OK');
  CancelarBtn.Caption := LangStr('Cancel');
  ApplyBtn.Caption := LangStr('Apply');
  TabSheet4.Caption := LangStr('DisplayPage');
  TabSheet5.Caption := LangStr('OptionsPage');
  TabSheet6.Caption := LangStr('HighlighterPage');
  HLVarsInStrsChk.Caption := LangStr('HighlightVarsInsideStrings');
  Label13.Caption := LangStr('Lang');
  WelcomeDialogChk.Caption := LangStr('ShowWelcomeDialog');
  MultInstChk.Caption := LangStr('MultipleInstances');
  IniDesignerChk.Caption := LangStr('OpenIniFilesIn');
  GroupBox3.Caption := LangStr('GeneralOptions');
  GroupBox2.Caption := LangStr('ToolBarOptions');
  SDragToolBarsChk.Caption := LangStr('TBSmoothDrag');
  SDragPanelsChk.Caption := LangStr('PanelSmoothDrag');
  Label11.Caption := LangStr('TBTheme');
  GroupBox1.Caption := LangStr('FileAssoc');
  RegisterBtn.Caption := LangStr('DefaultEditor');
  Label7.Caption := LangStr('Element');
  Label5.Caption := LangStr('Color');
  GroupBox13.Caption := LangStr('TextAttri');
  Label6.Caption := LangStr('FontStyle');
  CheckBox1.Caption := LangStr('Bold');
  CheckBox2.Caption := LangStr('Italic');
  CheckBox3.Caption := LangStr('Underline');
  Panel2.Caption := LangStr('Foreground');
  Panel4.Caption := LangStr('Background');
  HighLightChk.Caption := LangStr('UseHighLighter');
  AgregarBtn.Caption := LangStr('AddSimbol');
  EditarBtn.Caption := LangStr('EditSimbol');
  EliminarBtn.Caption := LangStr('DeleteSimbol');
  Label14.Caption := LangStr('Compiler');
  Label15.Caption := LangStr('Help');
  NoConfigChk.Caption := LangStr('NoConfigFile');
  NOCDChk.Caption := LangStr('NOCD');
  GroupBox8.Caption := LangStr('Paths');
  GroupBox7.Caption := LangStr('Options');
  GroupBox9.Caption := LangStr('Simbols');
  SimbLst.Columns[0].Caption := LangStr('SimbolColumn');
  SimbLst.Columns[1].Caption := LangStr('ValueColumn');
  gbGutter.Caption := LangStr('Gutter');
  ckGutterVisible.Caption := LangStr('GutterVisible');
  ckGutterShowLineNumbers.Caption := LangStr('GutterShowLineNumbers');
  ckGutterStartAtZero.Caption := LangStr('GutterStartAtZero');
  ckGutterShowLeaderZeros.Caption := LangStr('GutterShowLeaderZeros');
  cbGutterFont.Caption := LangStr('GutterFont');
  btnGutterFont.Caption := LangStr('Font');
  btnFont.Caption := LangStr('Font');
  Label1.Caption := LangStr('GutterColor');
  Label12.Caption := LangStr('BrowserHome');
  gbRightEdge.Caption := LangStr('RightEdge');
  Label10.Caption := LangStr('EdgeColumn');
  Label3.Caption := LangStr('EdgeColor');
  gbLineSpacing.Caption := LangStr('LineTabSpacing');
  Label8.Caption := LangStr('ExtraLines');
  Label9.Caption := LangStr('TabWidth');
  gbBookmarks.Caption := LangStr('Bookmarks');
  ckBookmarkKeys.Caption := LangStr('BookmarkKeys');
  ckBookmarkVisible.Caption := LangStr('BookmarksVisible');
  gbEditorFont.Caption := LangStr('EditorFont');

  gbOptions.Caption := LangStr('Options');
  for C := 0 to gbOptions.ControlCount - 1 do
  with TCheckBox(gbOptions.Controls[C]) do
  begin
    S := LangStr(Copy(Name, 3, MaxInt)); { <-- ignore 'ck' }
    Caption := GetShortHint(S);
    Hint := GetLongHint(S);
  end;

  gbCaret.Caption := LangStr('Caret');
  Label2.Caption := LangStr('InsertCaret');
  Label4.Caption := LangStr('OverwriteCaret');

  cInsertCaret.Items.Clear;
  cInsertCaret.Items.Add(LangStr('VerticalLine'));
  cInsertCaret.Items.Add(LangStr('HorizontalLine'));
  cInsertCaret.Items.Add(LangStr('HalfBlock'));
  cInsertCaret.Items.Add(LangStr('Block'));
  cOverwriteCaret.Items.Assign(cInsertCaret.Items);

  TabSheet7.Caption := LangStr('PluginsConfigPage');
  ConfigPluginBtn.Caption := LangStr('PluginConfig');
  AboutPluginBtn.Caption := LangStr('PluginAbout');

  NewGroupBox2.Caption := LangStr('IOGridOptions');
  DisplayGridChk.Caption := LangStr('DisplayGrid');
  SnapToGridChk.Caption := LangStr('SnapToGrid');
  StaticText1.Caption := LangStr('GridX');
  StaticText2.Caption := LangStr('GridY');
  StaticText3.Caption := LangStr('CtrlDims');
  RightBottomChk.Caption := LangStr('RightBottom');
  WidthHeightChk.Caption := LangStr('WidthHeight');
  BothChk.Caption := LangStr('Both');

  NewGroupBox3.Caption := LangStr('Other');
  StaticText4.Caption := LangStr('SaveOptionsIn');
  RegistryChk.Caption := LangStr('Registry');
  IniFileChk.Caption := ExtractFileName(OptionsIniFileName);
  SaveFileListChk.Caption := LangStr('OpenFilesOnStartup');
  SplashChk.Caption := LangStr('ShowSplashScreen');
  UseDefBrowserChk.Caption := LangStr('UseDefBrowser');

  ThemeList.Items.Clear;
  for C := 0 to FAvailableTBXThemes.Count - 1 do
    ThemeList.Items.Add(LangStr(FAvailableTBXThemes[C]));

  HighLightChk.Width := CheckWidth + Canvas.TextWidth(HighLightChk.Caption) + 7;
end;

procedure TConfigFrm.InitControlValues;
var
  C: Integer;
begin
  Liter.Assign(MainFrm.SynNSIS);
  ListBox.Items.Clear;
  for C := 0 to Liter.AttrCount - 1 do
    ListBox.Items.AddObject(Liter.Attribute[C].Name, Liter.Attribute[C]);
  HLVarsInStrsChk.Checked := Liter.HighlightVarsInsideStrings;

  ListBox.ItemIndex := 0;
  ListBoxClick(ListBox);
  HighLightChkClick(HighLightChk);
  HighLightChk.Checked := MainFrm.UseHighLighter;
  HighLightChkClick(HighLightChk);

  LangList.ItemIndex := LangList.Items.IndexOf(ChangeFileExt(ExtractFileName(LangFile), ''));
  LangChanged := False;
  ThemeList.ItemIndex := FAvailableTBXThemes.IndexOf(TBXCurrentTheme);

  MultInstChk.Checked := OptionsIni.ReadBool('Options', 'AllowMultiInst', False);
  SplashChk.Checked := not OptionsIni.ReadBool('Options', 'NoSplash', False);

  WelcomeDialogChk.Checked := MainFrm.Options.ShowMelcomeDlg;
  IniDesignerChk.Checked := MainFrm.Options.IniFilesDesignMode;
  SDragPanelsChk.Checked := MainFrm.Options.SmoothPanel;
  SDragToolBarsChk.Checked := MainFrm.Options.SmoothToolBar;
  ckViewUsageHints.Checked := MainFrm.Options.ShowCmdHint;
  ckUndoAfterSave.Checked := MainFrm.Options.UndoAfterSave;
  BrowserHomeEdt.Text := MainFrm.Options.BrowserHome;
  UseDefBrowserChk.Checked := MainFrm.Options.UseDefBrowser;

  NoConfigChk.Checked := MainFrm.Options.CompNoConfig;
  NoCDChk.Checked := MainFrm.Options.CompNOCD;
  CopilEdt.Text := MainFrm.Compiler;
  HTMLEdt.Text := MainFrm.HelpFileName;
  SimbLst.Items.Clear;
  for C := 0 to MainFrm.DefineList.Count - 1 do
  with SimbLst.Items.Add do
  begin
    Caption := MainFrm.DefineList.Names[C];
    SubItems.Add(MainFrm.DefineList.Values[Caption]);
  end;

  FSynEdit := MainFrm.EditorOptions;
  //Gutter
  ckGutterVisible.Checked:= FSynEdit.Gutter.Visible;
  ckGutterShowLineNumbers.Checked:= FSynEdit.Gutter.ShowLineNumbers;
  ckGutterShowLeaderZeros.Checked:= FSynEdit.Gutter.LeadingZeros;
  ckGutterStartAtZero.Checked:= FSynEdit.Gutter.ZeroStart;
  cbGutterFont.Checked := FSynEdit.Gutter.UseFontStyle;
  pGutterColor.Color:= FSynEdit.Gutter.Color;
  lblGutterFont.Font.Assign(FSynEdit.Gutter.Font);
  lblGutterFont.Caption:= lblGutterFont.Font.Name + ' ' + IntToStr(lblGutterFont.Font.Size) + 'pt';
  //Right Edge
  eRightEdge.Text:= IntToStr(FSynEdit.RightEdge);
  pRightEdgeColor.Color:= FSynEdit.RightEdgeColor;
  //Line Spacing
  eLineSpacing.Text:= IntToStr(FSynEdit.ExtraLineSpacing);
  eTabWidth.Text:= IntToStr(FSynEdit.TabWidth);
  //Break Chars
//!!  eBreakchars.Text:= FSynEdit.WordBreakChars;
  //Bookmarks
  ckBookmarkKeys.Checked:= FSynEdit.BookMarkOptions.EnableKeys;
  ckBookmarkVisible.Checked:= FSynEdit.BookMarkOptions.GlyphsVisible;
  //Font
  labFont.Font.Assign(FSynEdit.Font);
  labFont.Caption:= labFont.Font.Name + ' ' + IntToStr(labFont.Font.Size) + 'pt';
  //Options
  ckScrollHintFollows.Checked := eoScrollHintFollows in FSynEdit.Options;
  ckAutoIndent.Checked:= eoAutoIndent in FSynEdit.Options;
  ckDragAndDropEditing.Checked:= eoDragDropEditing in FSynEdit.Options;
  //ckDragAndDropFiles.Checked:= eoDropFiles in FSynEdit.Options;
  //ckNoSelection.Checked:= eoNoSelection in FSynEdit.Options;
  //ckNoCaret.Checked:= eoNoCaret in FSynEdit.Options;
  //ckWantTabs.Checked:= FSynEdit.WantTabs;
  ckShowSpecialChars.Checked := eoShowSpecialChars in FSynEdit.Options;
  ckSmartTabs.Checked:= eoSmartTabs in FSynEdit.Options;
  ckAltSetsColumnMode.Checked:= eoAltSetsColumnMode in FSynEdit.Options;
  ckHalfPageScroll.Checked:= eoHalfPageScroll in FSynEdit.Options;
  ckScrollByOneLess.Checked:= eoScrollByOneLess in FSynEdit.Options;
  ckScrollPastEOF.Checked:= eoScrollPastEof in FSynEdit.Options;
  ckScrollPastEOL.Checked:= eoScrollPastEol in FSynEdit.Options;
  ckShowScrollHint.Checked:= eoShowScrollHint in FSynEdit.Options;
  ckTabsToSpaces.Checked:= eoTabsToSpaces in FSynEdit.Options;
  ckTrimTrailingSpaces.Checked:= eoTrimTrailingSpaces in FSynEdit.Options;
  ckKeepCaretX.Checked:= eoKeepCaretX in FSynEdit.Options;
  ckSmartTabDelete.Checked := eoSmartTabDelete in FSynEdit.Options;
  ckRightMouseMoves.Checked := eoRightMouseMovesCursor in FSynEdit.Options;
  ckEnhanceHomeKey.Checked := eoEnhanceHomeKey in FSynEdit.Options;
  ckGroupUndo.Checked := eoGroupUndo in FSynEdit.Options;
  ckDisableScrollArrows.Checked := eoDisableScrollArrows in FSynEdit.Options;
  ckHideShowScrollbars.Checked := eoHideShowScrollbars in FSynEdit.Options;

  //Caret
  cInsertCaret.ItemIndex:= ord(FSynEdit.InsertCaret);
  cOverwriteCaret.ItemIndex:= ord(FSynEdit.OverwriteCaret);

  // Plugins ----
  Plugins.GetPluginsList(PluginsList.Items);
  if PluginsList.Items.Count > 0 then
    PluginsList.ItemIndex := 0;
  PluginsListClick(PluginsList);

  // IO designer options
  DisplayGridChk.Checked := MainFrm.Options.IOShowGrid;
  SnapToGridChk.Checked := MainFrm.Options.IOSnapToGrid;
  GridSizeXEdt.Text := IntToStr(MainFrm.Options.IOGridDims.X);
  GridSizeYEdt.Text := IntToStr(MainFrm.Options.IOGridDims.Y);
  case MainFrm.Options.ShowIODimsKind of
    sdRightBottom: RightBottomChk.Checked := True;
    sdWidthHeight: WidthHeightChk.Checked := True;
    sdBoth: BothChk.Checked := True;
  end;

  RegistryChk.Checked := OptionsIni is TRegistryIniFile;
  IniFileChk.Checked := OptionsIni is TIniFile;
  SaveFileListChk.Checked := MainFrm.Options.SaveFileList;
end;

procedure TConfigFrm.SaveOptions;
var
  SynEditOptions : TSynEditorOptions;
  X2, Y2, C: Integer;
begin
    if RegistryChk.Checked and (OptionsIni is TIniFile) then
    begin
      if DeleteFile(OptionsIniFileName) then
      begin
        OptionsIni.Free;
        OptionsIni := TSafeRegistryIniFile.Create('Software\HM Software\NIS Edit');
      end;
    end else
    if IniFileChk.Checked and (OptionsIni is TRegistryIniFile) then
    begin
      OptionsIni.Free;
      OptionsIni := TIniFile.Create(OptionsIniFileName);
    end;

    MainFrm.UseHighLighter := HighLightChk.Checked;
    MainFrm.SynNSIS.Assign(Liter);
    MainFrm.AssignIniAttri;

    MainFrm.Compiler := CopilEdt.Text;
    MainFrm.HelpFileName := HTMLEdt.Text;

    MainFrm.Options.CompNoConfig := NoConfigChk.Checked;
    MainFrm.Options.CompNOCD := NOCDChk.Checked;
    
    MainFrm.Options.SaveFileList := SaveFileListChk.Checked;

    if UpdateUsageList then
      FreeAndNil(UsageList);

    MainFrm.DefineList.Clear;
    for C := 0 to SimbLst.Items.Count - 1 do
      with SimbLst.Items[C] do
        MainFrm.DefineList.Add(Caption + '=' + SubItems[0]);

    OptionsIni.WriteBool('Options', 'AllowMultiInst', MultInstChk.Checked);
    OptionsIni.WriteBool('Options', 'NoSplash', not SplashChk.Checked);

    MainFrm.Options.ShowMelcomeDlg := WelcomeDialogChk.Checked;
    MainFrm.Options.IniFilesDesignMode := IniDesignerChk.Checked;
    MainFrm.Options.SmoothPanel := SDragPanelsChk.Checked;
    MainFrm.Options.SmoothToolBar := SDragToolBarsChk.Checked;
    MainFrm.Options.ShowCmdHint := ckViewUsageHints.Checked;
    MainFrm.Options.UndoAfterSave := ckUndoAfterSave.Checked;
    MainFrm.Options.UseDefBrowser := UseDefBrowserChk.Checked;
    MainFrm.Options.BrowserHome := BrowserHomeEdt.Text;
    MainFrm.ApplyOptions;
    if LangChanged then
      MainFrm.LoadLangFile(LangList.Items[LangList.ItemIndex]);

    if TBXCurrentTheme <> FAvailableTBXThemes[ThemeList.ItemIndex] then
      TBXSetTheme(FAvailableTBXThemes[ThemeList.ItemIndex]);

    MainFrm.Options.IOShowGrid := DisplayGridChk.Checked;
    MainFrm.Options.IOSnapToGrid := SnapToGridChk.Checked;

    X2 := MainFrm.Options.IOGridDims.X;
    Y2 := MainFrm.Options.IOGridDims.Y;
    MainFrm.Options.IOGridDims.X := StrToIntDef(GridSizeXEdt.Text, X2);
    MainFrm.Options.IOGridDims.Y := StrToIntDef(GridSizeYEdt.Text, Y2);
    if MainFrm.Options.IOGridDims.X < 1 then
      MainFrm.Options.IOGridDims.X := X2;
    if MainFrm.Options.IOGridDims.Y < 1 then
      MainFrm.Options.IOGridDims.Y := X2;

    if RightBottomChk.Checked then
      MainFrm.Options.ShowIODimsKind := sdRightBottom
    else if WidthHeightChk.Checked then
      MainFrm.Options.ShowIODimsKind := sdWidthHeight
    else
      MainFrm.Options.ShowIODimsKind := sdBoth;

    // Read property list again
    MainFrm.IOCrtlPropList.ReloadProperties;

    // Apply grid changes
    for C := 0 to MainFrm.MDIChildCount - 1 do
      if MainFrm.MDIChildren[C] is TIODesignerFrm then
        TIODesignerFrm(MainFrm.MDIChildren[C]).UpdateOptions;

    FSynEdit := MainFrm.EditorOptions;
    //Gutter
    FSynEdit.Gutter.Visible := ckGutterVisible.Checked;
    FSynEdit.Gutter.ShowLineNumbers := ckGutterShowLineNumbers.Checked;
    FSynEdit.Gutter.LeadingZeros := ckGutterShowLeaderZeros.Checked;
    FSynEdit.Gutter.ZeroStart := ckGutterStartAtZero.Checked;
    FSynEdit.Gutter.Color:= pGutterColor.Color;
    FSynEdit.Gutter.UseFontStyle := cbGutterFont.Checked;
    FSynEdit.Gutter.Font.Assign(lblGutterFont.Font);
    //Right Edge
    FSynEdit.RightEdge:= StrToIntDef(eRightEdge.Text, 80);
    FSynEdit.RightEdgeColor:= pRightEdgeColor.Color;
    //Line Spacing
    FSynEdit.ExtraLineSpacing:= StrToIntDef(eLineSpacing.Text, 0);
    FSynEdit.TabWidth:= StrToIntDef(eTabWidth.Text, 8);
    //Bookmarks
    FSynEdit.BookMarkOptions.EnableKeys:= ckBookmarkKeys.Checked;
    FSynEdit.BookMarkOptions.GlyphsVisible:= ckBookmarkVisible.Checked;
    //Font
    FSynEdit.Font.Assign(labFont.Font);
    //Options
    SynEditOptions:= [];
   if  ckScrollHintFollows.Checked then  Include(SynEditOptions, eoScrollHintFollows);
    if ckAutoIndent.Checked then Include(SynEditOptions, eoAutoIndent);
    if ckDragAndDropEditing.Checked then Include(SynEditOptions, eoDragDropEditing);
    {if ckDragAndDropFiles.Checked then Include(SynEditOptions, eoDropFiles);
    if ckNoSelection.Checked then Include(SynEditOptions, eoNoSelection);
    if ckNoCaret.Checked then Include(SynEditOptions, eoNoCaret);
    FSynEdit.WantTabs:= ckWantTabs.Checked;}
    if ckShowSpecialChars.Checked then Include(SynEditOptions, eoShowSpecialChars);
    if ckSmartTabs.Checked then Include(SynEditOptions, eoSmartTabs);
    if ckAltSetsColumnMode.Checked then Include(SynEditOptions, eoAltSetsColumnMode);
    if ckHalfPageScroll.Checked then Include(SynEditOptions, eoHalfPageScroll);
    if ckScrollByOneLess.Checked then Include(SynEditOptions, eoScrollByOneLess);
    if ckScrollPastEOF.Checked then Include(SynEditOptions, eoScrollPastEof);
    if ckScrollPastEOL.Checked then Include(SynEditOptions, eoScrollPastEol);
    if ckShowScrollHint.Checked then Include(SynEditOptions, eoShowScrollHint);
    if ckTabsToSpaces.Checked then Include(SynEditOptions, eoTabsToSpaces);
    if ckTrimTrailingSpaces.Checked then Include(SynEditOptions, eoTrimTrailingSpaces);
    if ckKeepCaretX.Checked then Include(SynEditOptions, eoKeepCaretX);
    if ckSmartTabDelete.Checked then Include(SynEditOptions,eoSmartTabDelete);
    if ckRightMouseMoves.Checked then Include(SynEditOptions,eoRightMouseMovesCursor);
    if ckEnhanceHomeKey.Checked then Include(SynEditOptions,eoEnhanceHomeKey);
    if ckGroupUndo.Checked then Include(SynEditOptions,eoGroupUndo);
    if ckDisableScrollArrows.Checked then Include(SynEditOptions,eoDisableScrollArrows);
    if ckHideShowScrollbars.Checked then Include(SynEditOptions,eoHideShowScrollbars);
    FSynEdit.Options:= SynEditOptions;
    //Caret
    FSynEdit.InsertCaret:= TSynEditCaretType(cInsertCaret.ItemIndex);
    FSynEdit.OverwriteCaret:= TSynEditCaretType(cOverwriteCaret.ItemIndex);

    with MainFrm do
    for C := MDIChildCount - 1 downto 0 do
    if MDIChildren[C] is TCustomMDIChild then
      TCustomMDIChild(MDIChildren[C]).UpdateEditor;
end;

procedure TConfigFrm.BrowserHomeEdtChange(Sender: TObject);
begin
  BrowserHomeEdt.Hint := BrowserHomeEdt.Text;
end;

procedure TConfigFrm.FormDestroy(Sender: TObject);
begin
  FAvailableTBXThemes.Free;
end;

end.
