{
  HM NIS Edit (c) 2003 Héctor Mauricio Rodríguez Segura <ranametal@users.sourceforge.net>
  For conditions of distribution and use, see license.txt

  Main form code

}
unit UMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ActnList, ImgList, UEdit, StdActns, ComCtrls, SynEdit, SynEditPrint,
  IniFiles, StdCtrls, ExtCtrls, TB2Item, TB2Dock, TB2Toolbar, TB2MDI, TB2MRU,
  SynExportRTF,  SynEditExport, SynExportHTML, SynEditHighlighter, SynHighlighterNSIS,
  Registry, SynHighlighterIni, TB2ExtItems, MyAutoCompleteList, TBX,
  TBXExtItems, TBXMDI, TBXDkPanels, TBXOfficeXPTheme, TBXStripesTheme,
  ZPropLst, UIODesigner, DsgnIntf, UCustomMDIChild, MySynEditorOptionsContainer,
  OleCtrls, SHDocVw, TBXStatusBars, PluginsInt, TBXThemes, RTDesign;

const
  WM_SHOWSTARTUPFRM = WM_USER + $1002;
  WM_LANG_SET = WM_USER + $1003;
  WM_HIDE_SPLASH = WM_USER + $1004;

type

  TShowIODimsKind = (sdRightBottom, sdWidthHeight, sdBoth);
  TLoadOptionsOptions = set of (loLoadLang, loLoadTBTheme, loLoadCompSettings, loLoadDefines);
  TSaveOptionsOptions = set of (soSaveCompSettings, soSaveDefines, soSaveFileList);

  TMainFrm = class(TForm)
    Actions: TActionList;
    NewScriptCmd: TAction;
    OpenFileCmd: TAction;
    SaveFileCmd: TAction;
    SaveFileAsCmd: TAction;
    ArrangleCmd: TWindowArrange;
    CascadeCmd: TWindowCascade;
    TileHorCmd: TWindowTileHorizontal;
    TileVerCmd: TWindowTileVertical;
    PrintCmd: TAction;
    ConfigPrintCmd: TAction;
    RedoCmd: TAction;
    FindCmd: TAction;
    FindNextCmd: TAction;
    ReplaceCmd: TAction;
    LogBoxCmd: TAction;
    CompScriptCmd: TAction;
    RunInstallerCmd: TAction;
    ConfigCmd: TAction;
    OpenDlg: TOpenDialog;
    SaveDlg: TSaveDialog;
    InsertColorCmd: TAction;
    InsertFileNameCmd: TAction;
    TBMDIHandler1: TTBXMDIHandler;
    TopDock: TTBXDock;
    tbMenu: TTBXToolbar;
    FileMenu: TTBXSubmenuItem;
    fmOpenItem: TTBXItem;
    fmSaveItem: TTBXItem;
    fmSaveAsItem: TTBXItem;
    fmSeparator3: TTBXSeparatorItem;
    fmPrintItem: TTBXItem;
    fmConfigPrintItem: TTBXItem;
    fmExitItem: TTBXItem;
    EditMenu: TTBXSubmenuItem;
    emUndoItem: TTBXItem;
    emRedoItem: TTBXItem;
    emSeparator1: TTBXSeparatorItem;
    emCutItem: TTBXItem;
    emCopyItem: TTBXItem;
    emPasteItem: TTBXItem;
    emSelectAllItem: TTBXItem;
    emSeparator2: TTBXSeparatorItem;
    smFindItem: TTBXItem;
    smFindNextItem: TTBXItem;
    smReplaceItem: TTBXItem;
    smSeparator1: TTBXSeparatorItem;
    ViewMenu: TTBXSubmenuItem;
    vmSeparator3: TTBXSeparatorItem;
    vmLogBoxItem: TTBXItem;
    ToolsMenu: TTBXSubmenuItem;
    tmInsertColorItem: TTBXItem;
    tmInsertFileNameItem: TTBXItem;
    NSISMenu: TTBXSubmenuItem;
    nmCompItem: TTBXItem;
    nmRunItem: TTBXItem;
    WindowMenu: TTBXSubmenuItem;
    wmCacadeItem: TTBXItem;
    wmTileHorItem: TTBXItem;
    wmTileVerItem: TTBXItem;
    wmArrangeItem: TTBXItem;
    HelpMenu: TTBXSubmenuItem;
    hmNSISHelp: TTBXItem;
    hmSeparator2: TTBXSeparatorItem;
    hmAboutItem: TTBXItem;
    tbStandard: TTBXToolbar;
    wmListItem: TTBXMDIWindowItem;
    wmSeparator3Item: TTBXSeparatorItem;
    stbSaveItem: TTBXItem;
    stbNewScriptItem: TTBXItem;
    stbSeparator2: TTBXSeparatorItem;
    stbPrintItem: TTBXItem;
    tbEdit: TTBXToolbar;
    etbRedoItem: TTBXItem;
    etbUndoItem: TTBXItem;
    etbSeparator1: TTBXSeparatorItem;
    etbPasteItem: TTBXItem;
    etbCopyItem: TTBXItem;
    etbCutItem: TTBXItem;
    tbNSIS: TTBXToolbar;
    ntbRunItem: TTBXItem;
    ntbCompItem: TTBXItem;
    MRU: TTBXMRUList;
    vmToolBarsItem: TTBXSubmenuItem;
    NSISHelpCmd: TAction;
    AboutCmd: TAction;
    ExitCmd: TAction;
    LeftDock: TTBXDock;
    stbOpenItem: TTBXSubmenuItem;
    TBMRUListItem2: TTBXMRUListItem;
    NewTemplateCmd: TAction;
    fmNewScriptItem: TTBXItem;
    fmNewTemplateItem: TTBXItem;
    fmSeparator1: TTBXSeparatorItem;
    fmSeparator2: TTBXSeparatorItem;
    fmReopenItem: TTBXSubmenuItem;
    TBMRUListItem3: TTBXMRUListItem;
    fmSeparator4: TTBXSeparatorItem;
    EditCodeTemplatesCmd: TAction;
    tmEditTemplatesItem: TTBXItem;
    tmSeparator1: TTBXSeparatorItem;
    FormatMenu: TTBXSubmenuItem;
    IdentTextCmd: TAction;
    UnIdentTextCmd: TAction;
    fmUnindentItem: TTBXItem;
    fmIndentItem: TTBXItem;
    stbSeparator1: TTBXSeparatorItem;
    UpperCaseCmd: TAction;
    fmSeparator5: TTBXSeparatorItem;
    fmUpperCaseItem: TTBXItem;
    LowerCaseCmd: TAction;
    fmLowerCaseItem: TTBXItem;
    ToggleCaseCmd: TAction;
    fmToggleCaseItem: TTBXItem;
    fmQuoteItem: TTBXItem;
    CoteCmd: TAction;
    SynNSIS: TSynNSISSyn;
    SynIni: TSynIniSyn;
    LogBoxPopup: TTBXPopupMenu;
    Copiaraportapeles1: TTBXItem;
    MenuItem1: TTBXItem;
    EditPopup: TTBXPopupMenu;
    puInsertColorItem: TTBXItem;
    puInsertFileNameItem: TTBXItem;
    puSeparator2: TTBXSeparatorItem;
    puUndoItem: TTBXItem;
    puRedoItem: TTBXItem;
    puSeparator3: TTBXSeparatorItem;
    puCutItem: TTBXItem;
    puCopyItem: TTBXItem;
    puPasteItem: TTBXItem;
    puSelectAllItem: TTBXItem;
    puSeparator4: TTBXSeparatorItem;
    puFindItem: TTBXItem;
    puFindNextItem: TTBXItem;
    puReplaceItem: TTBXItem;
    NewIOCmd: TAction;
    fmNewIOItem: TTBXItem;
    tbFormat: TTBXToolbar;
    ftbToggleCaseItem: TTBXItem;
    ftbLowerCaseItem: TTBXItem;
    ftbUpperCaseItem: TTBXItem;
    ftbUnIndentItem: TTBXItem;
    ftbIndentItem: TTBXItem;
    ftbSeparator1: TTBXSeparatorItem;
    vmVisibilityToggleNSISItem: TTBXVisibilityToggleItem;
    vmVisibilityToggleFormatItem: TTBXVisibilityToggleItem;
    vmVisibilityToggleEditItem: TTBXVisibilityToggleItem;
    vmVisibilityToggleStandarItem: TTBXVisibilityToggleItem;
    vmVisibilityToggleStatusBarItem: TTBXVisibilityToggleItem;
    stbNewIOItem: TTBXItem;
    ftbQuoteItem: TTBXItem;
    CopyAsHTMLCmd: TAction;
    emCopyHTMLItem: TTBXItem;
    puCopyHTMLItem: TTBXItem;
    tmTemplateItem: TTBXSubmenuItem;
    puTemplateItem: TTBXSubmenuItem;
    puSeparator1: TTBXSeparatorItem;
    RightMultiDock: TTBXMultiDock;
    SendToBackCmd: TAction;
    BringToFrontCmd: TAction;
    DeleteControlCmd: TAction;
    IOCtrlFlagsPopup: TTBXPopupMenu;
    IOPanel: TTBXDockablePanel;
    LeftMultiDock: TTBXMultiDock;
    RightDock: TTBXDock;
    ViewIOPanelCmd: TAction;
    vmIOPanelItem: TTBXItem;
    CopyCmd: TEditCopy;
    CutCmd: TEditCut;
    PasteCmd: TEditPaste;
    SelectAllCmd: TEditSelectAll;
    UndoCmd: TEditUndo;
    ToggleDesingModeCmd: TAction;
    DesignMenu: TTBXPopupMenu;
    TBXItem2: TTBXItem;
    TBXItem3: TTBXItem;
    TBXSeparatorItem2: TTBXSeparatorItem;
    TBXItem5: TTBXItem;
    TBXItem4: TTBXItem;
    TBXItem6: TTBXItem;
    TBXSeparatorItem3: TTBXSeparatorItem;
    TBXItem7: TTBXItem;
    TBXItem8: TTBXItem;
    vmOptionsItem: TTBXItem;
    EditorOptions: TMySynEditorOptionsContainer;
    BrowserPanel: TTBXDockablePanel;
    vmSeparator1: TTBXSeparatorItem;
    tbBrowser: TTBXToolbar;
    btbBackItem: TTBXItem;
    btbForwardItem: TTBXItem;
    btbStopItem: TTBXItem;
    btbRefreshItem: TTBXItem;
    btbSeparator1: TTBXSeparatorItem;
    btbGoItem: TTBXItem;
    BrowserStatusBar: TTBXStatusBar;
    BottomDock: TTBXDock;
    BrowserProgressBar: TProgressBar;
    btbHomeItem: TTBXItem;
    MainImages: TImageList;
    ControlsImages: TImageList;
    GotoLineCmd: TAction;
    SearchMenu: TTBXSubmenuItem;
    smGotoLineItem: TTBXItem;
    tbSearch: TTBXToolbar;
    stbFindItem: TTBXItem;
    stbFindNextItem: TTBXItem;
    stbReplaceItem: TTBXItem;
    stbSeparator3: TTBXSeparatorItem;
    stbGotoLineItem: TTBXItem;
    vmVisibilityToggleSearchItem: TTBXVisibilityToggleItem;
    ViewSpecialCharsCmd: TAction;
    vmSeparator2: TTBXSeparatorItem;
    vmSpecialCharsItem: TTBXItem;
    nmSeparator1: TTBXSeparatorItem;
    nmConfigItem: TTBXItem;
    ShowOptionsCmd: TAction;
    tbView: TTBXToolbar;
    vtbToggleDsgModeItem: TTBXItem;
    vtbSpecialCharsItem: TTBXItem;
    tbWindow: TTBXToolbar;
    wtbTileVerItem: TTBXItem;
    wtbTileHorItem: TTBXItem;
    wtbCascadeItem: TTBXItem;
    TBXMDIWindowItem1: TTBXMDIWindowItem;
    wtbListItem: TTBXSubmenuItem;
    vmToggleDesignModeItem: TTBXItem;
    vmVisibilityToggleWindowItem: TTBXVisibilityToggleItem;
    vmVisibilityToggleViewItem: TTBXVisibilityToggleItem;
    NextWindowCmd: TAction;
    PriorWindowCmd: TAction;
    wtbSeparator1: TTBXSeparatorItem;
    wtbNextItem: TTBXItem;
    wtbPriorItem: TTBXItem;
    wtbSeparator2: TTBXSeparatorItem;
    wmNextItem: TTBXItem;
    wmPriorItem: TTBXItem;
    wmSeparator2: TTBXSeparatorItem;
    EstBar: TTBXStatusBar;
    hmSeparator1: TTBXSeparatorItem;
    WinListPanel: TTBXDockablePanel;
    vmVisibilityToggleWinListItem: TTBXVisibilityToggleItem;
    WinListPopup: TTBXPopupMenu;
    ShowWindowCmd: TAction;
    CloseWindowCmd: TAction;
    wpuTileVerItem: TTBXItem;
    wpuTileHorItem: TTBXItem;
    wpuCloseItem: TTBXItem;
    wpuShowItem: TTBXItem;
    wpuSeparator1: TTBXSeparatorItem;
    wpuSeparator3: TTBXSeparatorItem;
    CompRunCmd: TAction;
    nmCompRunItem: TTBXItem;
    WinList: TTreeView;
    IOCrtlPropList: TZPropList;
    Bevel1: TBevel;
    CompWinCmd: TAction;
    CompRunWinCmd: TAction;
    RunWinCmd: TAction;
    wpuRunItem: TTBXItem;
    wpuCompRunItem: TTBXItem;
    wpuCompItem: TTBXItem;
    wpuSeparator2: TTBXSeparatorItem;
    wpuSaveAsItem: TTBXItem;
    wpuSaveItem: TTBXItem;
    SaveWinCmd: TAction;
    SaveAsWinCmd: TAction;
    URLField: TEdit;
    vtbEditURLItem: TTBControlItem;
    smSeparator2: TTBXSeparatorItem;
    puSeparator5: TTBXSeparatorItem;
    puGotoBookmarkItem: TTBXSubmenuItem;
    puToggleBookmarkItem: TTBXSubmenuItem;
    smGotoBookmarkItem: TTBXSubmenuItem;
    smToggleBookmarkItem: TTBXSubmenuItem;
    ntbCompRunItem: TTBXItem;
    CloseWinCmd: TWindowClose;
    wmSeparator1: TTBXSeparatorItem;
    wmCloseItem: TTBXItem;
    vmVisibilityToggleBrowserItem: TTBXVisibilityToggleItem;
    tbIOCtrls: TTBXToolbar;
    SystemImageList: TImageList;
    PluginItemsImages: TImageList;
    WizardCmd: TAction;
    stbWizardItem: TTBXItem;
    fmWizardItem: TTBXItem;
    SetTabOrderCmd: TAction;
    TBXItem1: TTBXItem;
    TBXSeparatorItem1: TTBXSeparatorItem;
    iopResizeItem: TTBXSubmenuItem;
    TBXItem9: TTBXItem;
    TBXSeparatorItem5: TTBXSeparatorItem;
    CMRWindowCmd: TAction;
    wmSMUItem: TTBXItem;
    hmURLGroupItem: TTBGroupItem;
    procedure NewScriptCmdExecute(Sender: TObject);
    procedure OpenFileCmdExecute(Sender: TObject);
    procedure SaveFileCmdUpdate(Sender: TObject);
    procedure SaveFileCmdExecute(Sender: TObject);
    procedure CheckEditNil(Sender: TObject);
    procedure SaveFileAsCmdExecute(Sender: TObject);
    procedure PrintCmdExecute(Sender: TObject);
    procedure ConfigPrintCmdExecute(Sender: TObject);
    procedure RedoCmdUpdate(Sender: TObject);
    procedure RedoCmdExecute(Sender: TObject);
    procedure CheckSelIAvail(Sender: TObject);
    procedure FindCmdExecute(Sender: TObject);
    procedure FindNextCmdExecute(Sender: TObject);
    procedure RemplasarDlgReplace(Sender: TObject);
    procedure LogBoxCmdUpdate(Sender: TObject);
    procedure LogBoxCmdExecute(Sender: TObject);
    procedure CompScriptCmdUpdate(Sender: TObject);
    procedure CompScriptCmdExecute(Sender: TObject);
    procedure RunInstallerCmdUpdate(Sender: TObject);
    procedure ConfigCmdExecute(Sender: TObject);
    procedure RunInstallerCmdExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure InsertColorCmdExecute(Sender: TObject);
    procedure InsertFileNameCmdExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure MRUClick(Sender: TObject; const Filename: String);
    procedure NSISHelpCmdExecute(Sender: TObject);
    procedure AboutCmdExecute(Sender: TObject);
    procedure ExitCmdExecute(Sender: TObject);
    procedure WizardCmdExecute(Sender: TObject);
    procedure NewTemplateCmdExecute(Sender: TObject);
    procedure EditCodeTemplatesCmdExecute(Sender: TObject);
    procedure FileMenuClick(Sender: TObject);
    procedure stbOpenItemPopup(Sender: TTBCustomItem;
      FromLink: Boolean);
    procedure IdentTextCmdExecute(Sender: TObject);
    procedure UnIdentTextCmdExecute(Sender: TObject);
    procedure UpperCaseCmdExecute(Sender: TObject);
    procedure LowerCaseCmdExecute(Sender: TObject);
    procedure ToggleCaseCmdExecute(Sender: TObject);
    procedure CoteCmdExecute(Sender: TObject);
    procedure NewIOCmdExecute(Sender: TObject);
    procedure SaveDlgTypeChange(Sender: TObject);
    procedure vmVisibilityToggleStatusBarItemClick(Sender: TObject);
    procedure CopyAsHTMLCmdExecute(Sender: TObject);
    procedure CopyAsHTMLCmdUpdate(Sender: TObject);
    procedure EditPopupPopup(Sender: TObject);
    procedure ToolsMenuPopup(Sender: TTBCustomItem; FromLink: Boolean);
    procedure IOCrtlPropListChange(Sender: TZPropList;
      Prop: TPropertyEditor);
    procedure SaveFileAsCmdUpdate(Sender: TObject);
    procedure CheckEditSel(Sender: TObject);
    procedure ExecuteDesingAction(Sender: TObject);
    procedure UpdateDesignAction(Sender: TObject);
    procedure IOPanelDockChanged(Sender: TObject);
    procedure ViewIOPanelCmdExecute(Sender: TObject);
    procedure ToggleDesingModeCmdUpdate(Sender: TObject);
    procedure ToggleDesingModeCmdExecute(Sender: TObject);
    procedure IOPanelClose(Sender: TObject);
    procedure btbBackItemClick(Sender: TObject);
    procedure btbForwardItemClick(Sender: TObject);
    procedure btbStopItemClick(Sender: TObject);
    procedure btbRefreshItemClick(Sender: TObject);
    procedure btbGoItemClick(Sender: TObject);
    procedure btbHomeItemClick(Sender: TObject);
    procedure BrowserPanelVisibleChanged(Sender: TObject);
    procedure GotoLineCmdExecute(Sender: TObject);
    procedure ViewSpecialCharsCmdUpdate(Sender: TObject);
    procedure ViewSpecialCharsCmdExecute(Sender: TObject);
    procedure UpdateWindowCmd(Sender: TObject);
    procedure ExecuteWindowCmd(Sender: TObject);
    procedure WinListChange(Sender: TObject; Node: TTreeNode);
    procedure WinListPopupPopup(Sender: TObject);
    procedure ShowWindowCmdExecute(Sender: TObject);
    procedure CloseWindowCmdExecute(Sender: TObject);
    procedure CompWinCmdUpdate(Sender: TObject);
    procedure CompWinCmdExecute(Sender: TObject);
    procedure RunWinCmdUpdate(Sender: TObject);
    procedure RunWinCmdExecute(Sender: TObject);
    procedure SaveWinCmdUpdate(Sender: TObject);
    procedure SaveWinCmdExecute(Sender: TObject);
    procedure SaveAsWinCmdExecute(Sender: TObject);
    procedure smToggleBookmarkItemPopup(Sender: TTBCustomItem;
      FromLink: Boolean);
    procedure smGotoBookmarkItemPopup(Sender: TTBCustomItem;
      FromLink: Boolean);
    procedure SearchMenuPopup(Sender: TTBCustomItem; FromLink: Boolean);
    procedure URLFieldKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SetTabOrderCmdExecute(Sender: TObject);
    procedure SetTabOrderCmdUpdate(Sender: TObject);
    procedure DesignMenuPopup(Sender: TObject);
    procedure CMRWindowCmdExecute(Sender: TObject);
    procedure CMRWindowCmdUpdate(Sender: TObject);
  private
    FirstTimeShowbrowser, NoLoadFileList, NoStartup, FUseHighLighter: Boolean;
    FExtencions: array[1..4] of String;
    AutoCompleteListModified: Boolean;
    FLastUsedWindow, WinListActionForm: TCustomMDIChild;

    procedure ApplicationException(Sender: TObject; E: Exception);
    procedure ApplicationHint(Sender: TObject);
    procedure ApplicationMessage(var Msg: TMSG; var Handled: Boolean);
    procedure AppActivate(Sender: TObject);

    procedure BrowseSite(Sender: TObject);

    procedure WMDropFiles(var Msg: TMessage); message WM_DROPFILES;
    procedure WMShowStartupFrm(var Msg: TMessage); message WM_SHOWSTARTUPFRM;
    procedure WMCopyData(var Msg: TWMCopyData); message WM_COPYDATA;
    procedure WMHideSplash(var Msg: TMessage); message WM_HIDE_SPLASH;
    procedure TBMThemeChange(var Msg: TMessage); message TBM_THEMECHANGE;

    procedure LoadLangStrs;
    procedure SetUseHighLighter(Value: Boolean);
    procedure ExecuteCommand(const Cmd: String);
    procedure UpdateTemplateMenuItems;
    procedure TemplateItemMenuClick(Sender: TObject);
    procedure AdjustSideDocks;
    procedure CheckForValidCompiler;
    procedure ResizeDesigner(Sender: TObject);

    procedure ToggleBookmarkClick(Sender: TObject);
    procedure GotoBookmarkClick(Sender: TObject);
    procedure IOCrtlPropListAddProperty(Sender: TZPropList; Prop: TPropertyEditor;
      var AllowAdd: Boolean);

    procedure CreateBrowser;
    procedure BrowserCommandStateChange(Sender: TObject; Command: Integer;
      Enable: WordBool);
    procedure BrowserStatusTextChange(Sender: TObject;
      const Text: WideString);
    procedure BrowserTitleChange(Sender: TObject; const Text: WideString);
    procedure BrowserProgressChange(Sender: TObject; Progress,
      ProgressMax: Integer);
    procedure BrowserNavigateComplete2(Sender: TObject;
      const pDisp: IDispatch; var URL: OleVariant);
  protected
    procedure CreateParams(var Params: TCreateParams); override;
  public
    RememberLang: Boolean;
    MaximizeFirst: Boolean;
    Browser: TWebBrowser;
    SynAutoComplete: TSynAutoComplete;
    FirstEdit: TEditFrm;
    Compiler: String;
    HelpFileName: String;
    NSISVersion: String;
    DefineList: TStrings;
    CursorItem: TTBXItem;

    Options: record
      ShowMelcomeDlg: Boolean;
      IniFilesDesignMode: Boolean;
      SmoothToolBar: Boolean;
      SmoothPanel: Boolean;
      UndoAfterSave: Boolean;
      ShowCmdHint: Boolean;
      BrowserHome: String;
      SaveFileList: Boolean;
      UseDefBrowser: Boolean;

      // Compiler
      CompNoConfig: Boolean;
      CompNOCD: Boolean;

      // IO
      IOShowGrid: Boolean;
      IOGridDims: TPoint;
      IOSnapToGrid: Boolean;
      ShowIODimsKind: TShowIODimsKind;
      IOGridKind: TGridKind;
      IOGridColor: TColor;
    end;

    procedure LoadOptions(IniFile: TCustomIniFile; const LoadOptionsOptions: TLoadOptionsOptions);
    procedure SaveOptions(IniFile: TCustomIniFile; const SaveOptionsOptions: TSaveOptionsOptions);
    function LoadFileList(IniFile: TCustomIniFile): Boolean;
    procedure SaveFileList(IniFile: TCustomIniFile);

    function FindItemByName(const ItemName: String): TTBCustomItem;
    function FindToolBarByName(const TBName: String): TTBCustomToolBar;
    function FintTBItemsByToolBarName(const TBName: String): TTBCustomItem;
    //function FindActionByName(const ActionName: String): TAction;
    procedure InsertToolBarItem(const ParentItemName: String; AtIndex: Integer; ItemData: PTBItemData);
    procedure GotoURL(const URL: String);

    procedure ApplyOptions;
    procedure EnableIOControls(const AEnabled: Boolean);
    procedure LoadLangFile(const ALangFile: String);
    function GetNSISVersion: String;
    procedure AddToRecent(const FileName: String);
    function WordHaveHintUsage(const S: String): Boolean;

    procedure SaveMDIChild(MDIChild: TCustomMDIChild);
    procedure SaveAsMDIChild(MDIChild: TCustomMDIChild);

    function CurEditFrm: TEditFrm;
    function CurDesignerFrm: TIODesignerFrm;
    function CurMDIChild: TCustomMDIChild;
    function CurSynEdit: TSynEdit;

    procedure AssignIniAttri;
    procedure UpdateStatus;
    procedure OpenTemplate(const TemplateFile: String);
    procedure ShowIOPanel;

    function FindMDIChild(const FileName: String): TCustomMDIChild;
    function OpenFile(AFileName: String; AReopen: Boolean = False;
        NoAddToRecent: Boolean = False): TCustomMDIChild;
    function OpenScriptFile(AFileName: String): TEditFrm;
    function OpenIniFile(AFileName: String): TIODesignerFrm;

    function GetCompilerCmdLine(const ScriptFileName: String;
      NotifyWnd: HWnd): String;
    procedure ShowHelp(const Command: String);

    // for the IO controls flags property editor
    procedure FlagsPopupItemClick(Sender: TObject);

    property UseHighLighter: Boolean read FUseHighLighter write SetUseHighLighter;
    property LastUsedWindow: TCustomMDIChild read FLastUsedWindow write FLastUsedWindow;
  end;

var
  MainFrm: TMainFrm;

implementation

uses TypInfo, ShellAPI, CommDlg, Clipbrd, SynEditKeyCmds, SynEditTypes, Utils,
  UAcerca, UStartup, UCodeTemplate, IOControls, UReplace, USearch,
  UConfig, UInputQuery, USplash, PluginsManger, PluginControls, UWizard,
  UIOTabOrder, HTMLHelp;

{$R *.DFM}

{ TMainFrm }

{$DEFINE DEV_COMPILE}

const
  DefaultHelpFile = 'NSIS.chm';

procedure TMainFrm.CreateParams(var Params: TCreateParams);
// for avoid multiple instances.
begin
  inherited;
  StrPCopy(Params.WinClassName, SMainClassName);
end;

function TMainFrm.CurEditFrm: TEditFrm;
begin
  if ActiveMDIChild is TEditFrm then
    Result := TEditFrm(ActiveMDIChild)
  else
    Result := nil;
end;

procedure TMainFrm.NewScriptCmdExecute(Sender: TObject);
begin
  OpenScriptFile('');
end;

procedure TMainFrm.OpenFileCmdExecute(Sender: TObject);
var
  C: Integer;
begin
  OpenDlg.FileName := '';
  OpenDlg.Filter := GetLangFileFilter(['NSISFileFilter', 'INIFileFilter']);
  OpenDlg.Title := LangStr('OpenScriptCaption');
  if OpenDlg.Execute then
  begin
    Application.ProcessMessages;
    for C := OpenDlg.Files.Count - 1 downto 0 do
      try
        OpenFile(OpenDlg.Files[C]);
      except
         Application.HandleException(Self);
      end;
  end;
end;

procedure TMainFrm.SaveFileCmdUpdate(Sender: TObject);
begin
  SaveFileCmd.Enabled := (CurMDIChild <> nil) and (CurMDIChild.Modified or
    (CurMDIChild.FileName = ''));
end;

procedure TMainFrm.SaveFileCmdExecute(Sender: TObject);
begin
  SaveMDIChild(CurMDIChild);
end;

procedure TMainFrm.CheckEditNil(Sender: TObject);
begin
  TAction(Sender).Enabled := CurSynEdit <> nil;
end;

procedure TMainFrm.SaveFileAsCmdExecute(Sender: TObject);
begin
  SaveAsMDIChild(CurMDIChild);
end;

procedure TMainFrm.PrintCmdExecute(Sender: TObject);
var
  EditPrint: TSynEditPrint;
  Edt: TSynEdit;
begin
  Edt := CurSynEdit;
  EditPrint := TSynEditPrint.Create(Self);
  try
    EditPrint.Colors := Edt.Highlighter <> nil;
    EditPrint.SynEdit := Edt;
    EditPrint.Title := GetParentForm(Edt).Caption;
    EditPrint.Print;
  finally
    EditPrint.Free;
  end;
end;

procedure TMainFrm.ConfigPrintCmdExecute(Sender: TObject);
begin
  with TPrinterSetupDialog.Create(Self) do
  try
    Execute;
  finally
    Free;
  end;
end;

procedure TMainFrm.RedoCmdUpdate(Sender: TObject);
begin
  RedoCmd.Enabled := (CurSynEdit <> nil) and CurSynEdit.CanRedo;
end;

procedure TMainFrm.RedoCmdExecute(Sender: TObject);
begin
  CurSynEdit.Redo;
end;

procedure TMainFrm.CheckSelIAvail(Sender: TObject);
begin
  CheckEditSel(Sender);
  TAction(Sender).Enabled :=  TAction(Sender).Enabled or
    ((CurDesignerFrm <> nil) and (CurDesignerFrm.RTDesigner.ControlCount > 0));
end;

procedure TMainFrm.FindCmdExecute(Sender: TObject);
var
  SynEdit: TSynEdit;
begin
  SynEdit := CurSynEdit;
  with TSearchFrm.Create(Self) do
  try
    Init(SynEdit);
    if ShowModal = mrOK then
    begin
      if SynEdit.SearchReplace(BuscarEdt.Text, '', GetOptions) = 0 then
        WarningDlg(LangStrFormat('NoFoundText', [BuscarEdt.Text]));
    end;
  finally
    Free;
  end;
end;

procedure TMainFrm.FindNextCmdExecute(Sender: TObject);
begin
  if LastFoundText = '' then
    FindCmd.Execute
  else if CurSynEdit.SearchReplace(LastFoundText,
    '', LastSearchOptions - [ssoEntireScope, ssoSelectedOnly]) = 0 then
       WarningDlg(LangStrFormat('NoFoundText', [LastFoundText]));
end;

procedure TMainFrm.RemplasarDlgReplace(Sender: TObject);
var
  SynEdit: TSynEdit;
  Options: TSynSearchOptions;
begin
  SynEdit := CurSynEdit;
  with TReplaceFrm.Create(Self) do
  try
    Init(SynEdit);
    case ShowModal of
      mrOk: Options := GetOptions + [ssoReplace];
      mrReplaceAll: Options := GetOptions + [ssoReplace, ssoReplaceAll];
    else
      Exit;
    end;
    if SynEdit.SearchReplace(BuscarEdt.Text, ReplaceEdt.Text, Options) = 0 then
      WarningDlg(LangStrFormat('NoFoundText', [BuscarEdt.Text]));
  finally
    Free;
  end;
end;

procedure TMainFrm.LogBoxCmdUpdate(Sender: TObject);
begin
  LogBoxCmd.Enabled := (CurEditFrm <> nil) and (not CurEditFrm.IsText)
    and (not CurEditFrm.IsHeader);
  LogBoxCmd.Checked := LogBoxCmd.Enabled and CurEditFrm.LogBoxVisible;
end;

procedure TMainFrm.LogBoxCmdExecute(Sender: TObject);
begin
  CurEditFrm.LogBoxVisible := not CurEditFrm.LogBoxVisible;
end;

procedure TMainFrm.CompScriptCmdUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := (CurEditFrm <> nil) and CurEditFrm.AllowCompile;
end;


procedure TMainFrm.CompScriptCmdExecute(Sender: TObject);
begin
  CheckForValidCompiler;
  SaveFileCmd.Execute;
  CurEditFrm.Compilar(Sender = CompRunCmd);
end;


procedure TMainFrm.RunInstallerCmdUpdate(Sender: TObject);
begin
  RunInstallerCmd.Enabled := (CurEditFrm <> nil) and (not CurEditFrm.IsCompiling) and
    CurEditFrm.SuccessCompile;
end;

procedure TMainFrm.RunInstallerCmdExecute(Sender: TObject);
begin
  CurEditFrm.RunSetup;
end;

procedure TMainFrm.ConfigCmdExecute(Sender: TObject);
var
  I: Integer;
begin
  I := 0;
  if Sender = ConfigCmd then I := 2;
  ShowConfig(I, I = 2);
end;

procedure TMainFrm.UpdateStatus;
const
  ModText: array[Boolean] of String = ('', 'Modified');
  InsertText: array[Boolean] of String = ('Overwrite', 'Insert');
var
  CurMDI: TCustomMDIChild;
  CurSynEdit: TSynEdit;
begin
  CurMDI := CurMDIChild;
  if CurMDI <> nil then
  begin
    if CurMDI.ReadOnly then
      EstBar.Panels[1].Caption := LangStr('ReadOnly')
    else
      EstBar.Panels[1].Caption := LangStr(ModText[CurMDI.Modified]);
    if Application.Hint <> '' then
      EstBar.Panels[3].Caption := Application.Hint
    else
      EstBar.Panels[3].Caption := CurMDI.FileName;
    EstBar.Panels[3].Hint := EstBar.Panels[3].Caption;
    CurSynEdit := CurMDI.SynEdit;
    if CurSynEdit <> nil then
    begin
      EstBar.Panels[0].Caption := LangStrFormat('CaretPos',
        [CurSynEdit.CaretX, CurSynEdit.CaretY]);
      EstBar.Panels[2].Caption := LangStr(InsertText[CurSynEdit.InsertMode]);
    end else
    begin
      if CurMDI is TIODesignerFrm then
        with TIODesignerFrm(CurMDI).GetDesignPanelXY do
        EstBar.Panels[0].Caption := Format('%d - %d', [X, Y])
      else
        EstBar.Panels[0].Caption := '';
      EstBar.Panels[2].Caption := '';
    end;
  end else
  begin
    EstBar.Panels[0].Caption := '';
    EstBar.Panels[1].Caption := '';
    EstBar.Panels[2].Caption := '';
    EstBar.Panels[3].Caption := Application.Hint;
  end;
end;

procedure TMainFrm.FormCreate(Sender: TObject);
var
  S: String; { <-- auxiliar var }
  Found: Integer;
  Item: TTBXItem;
  CtrlCount: TControlType;
  SHInfo: TSHFileInfo;
begin
  InitFont(Font);
  FirstTimeShowBrowser := True;
  RememberLang := True;
  MaximizeFirst := True;

  {Create the browser at runtime for safe if the Internet
  Explorer isn't installed}
  CreateBrowser;

  SynAutoComplete := TSynAutoComplete.Create;
  DefineList := TStringList.Create;

  with SynNSIS do begin
    for Found := 0 to AttrCount - 1 do
      Attribute[Found].Background := clWindow;
    KeyAttri.Foreground := 13369344;
    FunctionAttri.Foreground := KeyAttri.Foreground;
    KeyAttri.Style := [];
    NumberAttri.Foreground := clTeal;
    StringAttri.Foreground := 9803082;
    DirectiveAttri.Foreground := clGreen;
    VariableAttri.Foreground := clMaroon;
    ParameterAttri.Foreground := 4227327;
  end;

  LoadOptions(OptionsIni, [loLoadDefines]);

  if Browser = nil then BrowserPanel.Hide;
  vmVisibilityToggleBrowserItem.Enabled := Browser <> nil;

  // now create the bookmark menu item before load the language file
  for Found := 0 to 9 do
  begin
    Item := TTBXItem.Create(Self);
    Item.Tag := Found;
    Item.OnClick := ToggleBookmarkClick;
    smToggleBookmarkItem.Add(Item);
  end;

  DragAcceptFiles(Handle, True);

  RTDesign.DesignServer.OnActivate := AppActivate;
  RTDesign.DesignServer.OnMessage := ApplicationMessage;
  Application.OnException := ApplicationException;
  Application.OnHint := ApplicationHint;
  Application.OnRestore := AppActivate;
  Self.OnShow := FormShow;

  IOCrtlPropList.OnAddProperty := IOCrtlPropListAddProperty;

  S := ExtractFilePath(ParamStr(0)) + 'Templates.dat';
  if FileExists(S) then
    SynAutoComplete.AutoCompleteList.LoadFromFile(S);
  UpdateTemplateMenuItems;


  // Read CmpParsing.ini
  InitCompilerOutputParsingVars;

  // Add the control buttons to the IO panel ---------------------
  for CtrlCount := Low(TControlType) to High(TControlType) do
  begin
    Item := TTBXItem.Create(Self);
    Item.Hint := ControlNames[CtrlCount] + '|';
    Item.ImageIndex := Ord(CtrlCount);
    Item.Images := ControlsImages;
    Item.AutoCheck := True;
    Item.GroupIndex := 1;
    Item.Enabled := False;
    tbIOCtrls.Items.Add(Item);
  end;
  // Add the cursor button
  CursorItem := TTBXItem.Create(Self);
  CursorItem.ImageIndex := Ord(High(CtrlCount)) + 1;
  CursorItem.Images := ControlsImages;
  CursorItem.AutoCheck := True;
  CursorItem.GroupIndex := 1;
  CursorItem.Checked := True;
  CursorItem.Enabled := False;
  tbIOCtrls.Items.Add(CursorItem);
//-----------------------------------------------------------------

  // Get access to the shell imagelist
  SystemImageList.Handle := SHGetFileInfo('', 0, SHInfo, SizeOf(TSHFileInfo),
    SHGFI_SYSICONINDEX or SHGFI_SMALLICON);

  // Load plugins
  Plugins := TPlugins.Create;

  // Load toolbar position again for load positions of any toolbars created by the plugins
  if OptionsIni is TRegistryIniFile then
    TBRegLoadPositions(Self, HKEY_CURRENT_USER, 'Software\HM Software\NIS Edit\ToolBars')
  else
    TBIniLoadPositions(Self, OptionsIni.FileName, 'ToolBar_');

  // Load lang file and toolbar theme after plugins load for the plugin notyfications
  LoadLangFile(OptionsIni.ReadString('Options', 'Language', 'English'));
  AddThemeNotification(Self);
  TBXSetTheme(OptionsIni.ReadString('ToolBars', 'Theme', 'Default'));

  PostMessage(Handle, WM_HIDE_SPLASH, 0, 0);
  if (not Options.SaveFileList) and Options.ShowMelcomeDlg and not SwitchPassed('nww') then
    PostMessage(Handle, WM_SHOWSTARTUPFRM, 0, 0);
end;

procedure TMainFrm.AddToRecent(const FileName: String);
begin
  if FileName <> '' then MRU.Add(FileName);
end;

procedure TMainFrm.FormDestroy(Sender: TObject);
var
  C: Integer;
begin
  if Assigned(Utils.HtmlHelp) then
    Utils.HtmlHelp(Handle, PChar(HelpFileName), HH_CLOSE_ALL, 0);

  FreeAndNil(Plugins);

  RemoveThemeNotification(Self);

  SaveOptions(OptionsIni, [soSaveCompSettings, soSaveDefines, soSaveFileList]);
  DefineList.Free;

  if AutoCompleteListModified then
   SynAutoComplete.AutoCompleteList.SaveToFile(ExtractFilePath(ParamStr(0)) +
     'Templates.dat');
  SynAutoComplete.Free;

  for C := 0 to MDIChildCount - 1 do
    if MDIChildren[C] is TCustomMDIChild then
     TCustomMDIChild(MDIChildren[C]).Node := nil;
end;

procedure TMainFrm.InsertColorCmdExecute(Sender: TObject);
var
  ColorDlg: TColorDialog;
begin
  ColorDlg := TColorDialog.Create(Self);
  try
    ColorDlg.Options := [cdFullOpen];
    if ColorDlg.Execute then
      CurSynEdit.SelText := ' ' + ColorToHTML(ColorDlg.Color);
  finally
    ColorDlg.Free;
  end;
end;

procedure TMainFrm.InsertFileNameCmdExecute(Sender: TObject);
var
  F, S: String;
begin
  OpenDlg.Filter := LangStr('AllFileFilter');
  OpenDlg.FileName := '';
  OpenDlg.Title := LangStr('InsertFileCaption');
  if OpenDlg.Execute then
  begin
    S := OpenDlg.FileName;
    F := TCustomMDIChild(ActiveMDIChild).FileName;
    if F <> '' then S := ExtractRelativePath(F, S);
    CurSynEdit.SelText := ' ' + QuoteIfNeeded(S);
  end;
end;

procedure TMainFrm.FormShow(Sender: TObject);
var
  C: Integer;
  NoFilesOpened: Boolean;
  WindowPlacement: TWindowPlacement;
begin
  for C := 1 to ParamCount do
  try
    ExecuteCommand(ParamStr(C));
  except
    { No se dispersa la excepción para que el resto del evento se ejecute
      correctamente. }
    Application.HandleException(Self);
  end;

  NoFilesOpened := True;
  if Options.SaveFileList then
    NoFilesOpened := not LoadFileList(OptionsIni);

  { Creamos el editor por defecto si aun no se an abierto archivos
    y si no hay opciones que lo impidan. }
  if NoFilesOpened and (not SwitchPassed('nde')) and (EditFrm = nil) and
    (MDIChildCount = 0) then FirstEdit := OpenScriptFile('');

  Left := (Monitor.Width - Width) div 2;
  Top := (Monitor.Height - Height) div 2;

  if OptionsIni.ReadBool('State', 'WindowMaximized', False) then
    WindowState := wsMaximized;
  WindowPlacement.length := SizeOf(WindowPlacement);
  GetWindowPlacement (Handle, @WindowPlacement);
  WindowPlacement.rcNormalPosition.Left := OptionsIni.ReadInteger('State',
    'WindowLeft', WindowPlacement.rcNormalPosition.Left);
  WindowPlacement.rcNormalPosition.Top := OptionsIni.ReadInteger('State',
    'WindowTop', WindowPlacement.rcNormalPosition.Top);
  WindowPlacement.rcNormalPosition.Right := OptionsIni.ReadInteger('State',
    'WindowRight', WindowPlacement.rcNormalPosition.Right);
  WindowPlacement.rcNormalPosition.Bottom := OptionsIni.ReadInteger('State',
    'WindowBottom', WindowPlacement.rcNormalPosition.Bottom);
  SetWindowPlacement (Handle, @WindowPlacement);

  { Para evitar que este evento se ejecute dos veses. }
  OnShow := nil;
end;

procedure TMainFrm.WMDropFiles(var Msg: TMessage);
Var
  Hnd: THandle;
  Count, C: Integer;
  FileName: String;
begin
  Hnd := THandle(Msg.WParam);
  try
    Count := DragQueryFile(Hnd, UINT(-1), nil, 0);
    for C := 0 to Count - 1 do
    begin
      SetLength(FileName, MAX_PATH);
      SetLength(FileName, DragQueryFile(Hnd, C, PChar(FileName), MAX_PATH));
      try
        OpenFile(FileName);
      except
        Application.HandleException(Self);
      end;
    end;
  finally
    Msg.Result := 0;
    DragFinish(Hnd);
    FileName := '';
  end;
end;

procedure TMainFrm.MRUClick(Sender: TObject;
  const Filename: String);
begin
   OpenFile(FileName);
end;

procedure TMainFrm.NSISHelpCmdExecute(Sender: TObject);
begin
  ShowHelp('');
end;

procedure TMainFrm.AboutCmdExecute(Sender: TObject);
begin
  with TAboutFrm.Create(Self) do
  try
    ShowModal;
  finally
    Free;
  end;
end;

procedure TMainFrm.ExitCmdExecute(Sender: TObject);
begin
  Close;
end;

procedure TMainFrm.LoadLangStrs;

  procedure AssignToggleVisivilityControl(Item: TTBXVisibilityToggleItem;
    Control: TControl);
  begin
    Item.Caption := '';
    Item.Control := nil;
    Item.Control := Control;
  end;

  procedure AssignToggleVisivilityText(Item: TTBXVisibilityToggleItem;
    const TextId: String);
  var
      I: Integer;
    Temp, aCaption, aShortCut: String;
  begin
    Temp := LangStr(TextId);
    aCaption := ExtractStr(Temp, '|');
    Item.Caption := aCaption;
    I := AnsiPos('&', aCaption);
    aShortCut := Trim(ExtractStr(Temp, '|'));
    if aShortCut <> '' then
      Item.ShortCut := TextToShortCut(aShortCut);
    if I > 0 then Delete(aCaption, I, 1);
    Item.Hint := aCaption + '|' + ExtractStr(Temp, '|');
  end;

  function CreateURLTBItem(const I: Integer): TTBCustomItem;
  var
    S: String;
  begin
    Result := nil;
    S := LangStr('URLLink' + IntToStr(I), '*');
    if (S <> '') and (S <> '*') then
    begin
      if S = '-' then
      begin
        Result := TTBXSeparatorItem.Create(Self);
        Result.Name := 'hmURLLink' + IntToStr(I) + 'Separator';
      end else
      begin
        Result := TTBXItem.Create(Self);
        Result.Name := 'hmURLLink' + IntToStr(I) + 'Item';
        Result.Caption := ExtractStr(S, '|');
        Result.ShortCut := TextToShortCut(ExtractStr(S, '|'));
        Result.Hint :=  ExtractStr(S, '|');
        Result.ImageIndex := StrToIntDef(ExtractStr(S, '|'), -1);
        Result.OnClick := BrowseSite;
      end;
      hmURLGroupItem.Add(Result);
    end;
  end;

var
  C: Integer;
begin
  Caption := LangStr('MainCaption');

{$IFDEF DEV_COMPILE}
  Caption := Caption  + ' CVS ' + DateTimeToStr(FileDateToDateTime(FileAge(ParamStr(0))));
{$ENDIF}

  FileMenu.Caption := LangStr('FileMenu');
  EditMenu.Caption := LangStr('EditMenu');
  SearchMenu.Caption := LangStr('SearchMenu');
  FormatMenu.Caption := LangStr('FormatMenu');
  ViewMenu.Caption := LangStr('ViewMenu');
  ToolsMenu.Caption := LangStr('ToolsMenu');
  NSISMenu.Caption := LangStr('NSISMenu');
  WindowMenu.Caption := LangStr('WindowMenu');
  HelpMenu.Caption := LangStr('HelpMenu');
  vmToolBarsItem.Caption := LangStr('ToolBarsMenu');

  fmReopenItem.Caption := LangStr('Reopen');

  tmTemplateItem.Caption := LangStr('CodeTemplates');
  puTemplateItem.Caption := LangStr('CodeTemplates');

  AssignActionText(OpenFileCmd, 'FileOpen');
  AssignActionText(SaveFileCmd, 'FileSave');
  AssignActionText(SaveFileAsCmd, 'FileSaveAs');
  AssignActionText(PrintCmd, 'FilePrint');
  AssignActionText(ConfigPrintCmd, 'FileConfigPrint');
  AssignActionText(ExitCmd, 'FileExit');

  AssignActionText(NewScriptCmd, 'BlankFile');
  AssignActionText(WizardCmd, 'WizardFile');
  AssignActionText(NewTemplateCmd, 'TemplateFile');
  AssignActionText(NewIOCmd, 'NewIOFile');

  AssignActionText(UndoCmd, 'EditUndo');
  AssignActionText(RedoCmd, 'EditRedo');
  AssignActionText(CutCmd, 'EditCut');
  AssignActionText(CopyCmd, 'EditCopy');
  AssignActionText(PasteCmd, 'EditPaste');
  AssignActionText(CopyAsHTMLCmd, 'EditCopyAsHTML');

  AssignActionText(SelectAllCmd, 'EditSelectAll');
  AssignActionText(FindCmd, 'EditFind');

  AssignActionText(FindNextCmd, 'EditFindNext');
  AssignActionText(ReplaceCmd, 'EditReplace');
  AssignActionText(GotoLineCmd, 'SearchGotoLine');

  AssignActionText(IdentTextCmd, 'FormatIndent');
  AssignActionText(UnIdentTextCmd, 'FormatUnindent');
  AssignActionText(UpperCaseCmd, 'FormatUpperCase');
  AssignActionText(LowerCaseCmd, 'FormatLowerCase');
  AssignActionText(ToggleCaseCmd, 'FormatToggleCase');
  AssignActionText(CoteCmd, 'FormatQuoteSelection');

  AssignActionText(LogBoxCmd, 'ViewLogBox');
  AssignActionText(ViewIOPanelCmd, 'ViewIOPanel');
  AssignActionText(ViewSpecialCharsCmd, 'ViewSpecialChars');

  tbStandard.Caption := LangStr('TBStandardCaption');
  tbEdit.Caption := LangStr('TBEditCaption');
  tbSearch.Caption := LangStr('TBSearchCaption');
  tbView.Caption := LangStr('TBViewCaption');
  tbNSIS.Caption := LangStr('TBNSISCaption');
  tbMenu.Caption := LangStr('TBMenuCaption');
  tbFormat.Caption := LangStr('TBFormatCaption');
  tbWindow.Caption := LangStr('TBWindowCaption');

  AssignToggleVisivilityText(vmVisibilityToggleStatusBarItem, 'ViewStatusBar');

  AssignToggleVisivilityControl(vmVisibilityToggleStandarItem, tbStandard);
  AssignToggleVisivilityControl(vmVisibilityToggleEditItem, tbEdit);
  AssignToggleVisivilityControl(vmVisibilityToggleSearchItem, tbSearch);
  AssignToggleVisivilityControl(vmVisibilityToggleViewItem, tbView);
  AssignToggleVisivilityControl(vmVisibilityToggleFormatItem, tbFormat);
  AssignToggleVisivilityControl(vmVisibilityToggleNSISItem, tbNSIS);
  AssignToggleVisivilityControl(vmVisibilityToggleWindowItem, tbWindow);

  AssignActionText(InsertColorCmd, 'ToolsInsertColor');
  AssignActionText(InsertFileNameCmd, 'ToolsInsertFile');
  AssignActionText(EditCodeTemplatesCmd, 'ToolsEditCodeTemplate');

  AssignActionText(CompScriptCmd, 'NSISCompil');
  AssignActionText(CompRunCmd, 'NSISCompilRun');
  AssignActionText(RunInstallerCmd, 'NSISExec');
  AssignActionText(ConfigCmd, 'NSISConfig');

  AssignActionText(ArrangleCmd, 'WindowArrangle');
  AssignActionText(CascadeCmd, 'WindowCascade');
  AssignActionText(TileHorCmd, 'WindowTileHorizontal');
  AssignActionText(TileVerCmd, 'WindowTileVertical');
  AssignActionText(NextWindowCmd, 'WindowNext');
  AssignActionText(PriorWindowCmd, 'WindowPrior');
  AssignActionText(CMRWindowCmd, 'WindowSMU');
  AssignActionText(CloseWinCmd, 'WindowClose');

  AssignActionText(NSISHelpCmd, 'HelpNSIS');
  AssignActionText(AboutCmd, 'HelpAbout');

  //  Load URL help items
  C := 1;
  hmURLGroupItem.Clear;
  while CreateURLTBItem(C) <> nil do Inc(C);


  AssignActionText(SendToBackCmd, 'SendToBack');
  AssignActionText(BringToFrontCmd, 'BringToFront');
  AssignActionText(DeleteControlCmd, 'Delete');
  AssignActionText(SetTabOrderCmd, 'SetTabOrder');
  iopResizeItem.Caption := LangStr('ResizeWinTo');
  iopResizeItem.Clear;

  IOPanel.Caption := LangStr('IOPanelCaption');
  WinListPanel.Caption := LangStr('WindowList');
  AssignToggleVisivilityText(vmVisibilityToggleWinListItem, 'ViewWindowList');

  AssignActionText(ToggleDesingModeCmd, 'IOToggleDesignMode');

  BrowserPanel.Caption := LangStr('Browser');
  AssignToggleVisivilityText(vmVisibilityToggleBrowserItem, 'ViewBrowser');
  AssignActionText(ShowOptionsCmd, 'ViewOptions');
  wtbListItem.Caption := LangStr('WindowList');

  CloseWindowCmd.Caption := CloseWinCmd.Caption;
  ShowWindowCmd.Caption := LangStr('WindowShow');
  CompWinCmd.Caption := CompScriptCmd.Caption;
  CompRunWinCmd.Caption := CompRunCmd.Caption;
  RunWinCmd.Caption := RunInstallerCmd.Caption;
  SaveWinCmd.Caption := SaveFileCmd.Caption;
  SaveAsWinCmd.Caption := SaveFileAsCmd.Caption;

  for C := 0 to ComponentCount - 1 do
    if Components[C] is TTBXToolbar then
      TTBXToolbar(Components[C]).ChevronHint := LangStr('MoreButtons') + '|';

  for C := 0 to smToggleBookmarkItem.Count - 1 do
    smToggleBookmarkItem.Items[C].Caption := LangStr('Bookmark') + ' &' + IntToStr(C);

  smToggleBookmarkItem.Caption := LangStr('ToggleBookmark');
  smGotoBookmarkItem.Caption := LangStr('GotoBookmark');
  puToggleBookmarkItem.Caption := smToggleBookmarkItem.Caption;
  puGotoBookmarkItem.Caption := smGotoBookmarkItem.Caption;
end;

procedure TMainFrm.SetUseHighLighter(Value: Boolean);
var
  C: Integer;
begin
  if Value <> FUseHighLighter then
  begin
    FUseHighLighter := Value;
    for C := MDIChildCount - 1 downto 0 do
     if MDIChildren[C] is TCustomMDIChild then
      TCustomMDIChild(MDIChildren[C]).UseHighLighter := FUseHighLighter;
  end;
end;

function TMainFrm.OpenFile(AFileName: String; AReopen: Boolean = False;
  NoAddToRecent: Boolean = False): TCustomMDIChild;
begin
  Screen.Cursor := crHourGlass;
  try
    { Convert 8.3 file names }
    AFileName := ShortToLongPath(ExpandFileName(AFileName));
    Result := nil;

    if not AReopen then
    begin
      { Check if the file is already open }
      if AFileName <> '' then Result := FindMDIChild(AFileName);
      if (Result <> nil) and (Result.FileName <> '') then
      begin
        if IsIconic(Result.Handle) then
          ShowWindow(Result.Handle, SW_RESTORE)
        else
          Result.Show;
        Exit;
      end;
    end;

    if not NoAddToRecent then
      AddToRecent(AFileName);
    try
      if AnsiSameText(ExtractFileExt(AFileName), '.ini') then
        Result := OpenIniFile(AFileName)
      else
        Result := OpenScriptFile(AFileName);
    except
      MRU.Remove(AFileName);
      raise;
    end;
  finally
    Screen.Cursor := crDefault;
  end;
end;


procedure TMainFrm.WMShowStartupFrm(var Msg: TMessage);
var
  C: Integer;
begin
  if NoStartup then Exit;

  with TStartupFrm.Create(Self) do
  try
    FilesLst.Items.AddStrings(MRU.Items);
    FilesLst.Selected[0] := True;
    UpdateHorizontalExtent(FilesLst);
    if ShowModal = mrOK then
    begin
      Application.ProcessMessages;
      if EmptyChk.Checked then
      begin
        if FirstEdit = nil then
          OpenFile('')
        else
          FirstEdit := nil;
      end else
      if WizardChk.Checked then
        WizardCmd.Execute else
      if OpenChk.Checked then
      begin
        if FilesLst.Selected[0] or (FilesLst.SelCount = 0) then
          OpenFileCmd.Execute
        else begin
          for C := 1 to FilesLst.Items.Count - 1 do
            if FilesLst.Selected[C] then
              OpenFile(FilesLst.Items[C])
        end;
      end;
    end;
    Options.ShowMelcomeDlg := not StartupChk.Checked;
  finally
    Free;
  end;
end;

procedure TMainFrm.WizardCmdExecute(Sender: TObject);
var
  S: String;
begin
  WizardFrm := TWizardFrm.Create(Self);
  try
    if WizardFrm.ShowModal = mrOK then
    begin
      OpenFile('');

      S := '';
      if WizardFrm.RelativeChk.Checked then
        S := WizardFrm.SaveDlg.FileName;
      WizardFrm.GenerateCode(EditFrm.Edit.Lines, S);

      EditFrm.Edit.Modified := True;

      if WizardFrm.SaveChk.Checked then
        EditFrm.SaveFile(WizardFrm.SaveDlg.FileName);

      if WizardFrm.CompChk.Checked then
        EditFrm.Compilar;
    end;
  finally
    FreeAndNil(WizardFrm);
  end;
end;

procedure TMainFrm.NewTemplateCmdExecute(Sender: TObject);
var
  C: Integer;
begin
  OpenDlg.Filter := GetLangFileFilter(['NSISFileFilter', 'INIFileFilter']);
  OpenDlg.FileName := '';
  OpenDlg.Title := LangStr('OpenTemplateCaption');
  if OpenDlg.Execute then
  for C := OpenDlg.Files.Count - 1 downto 0 do
    OpenTemplate(OpenDlg.Files[C]);
end;

procedure TMainFrm.EditCodeTemplatesCmdExecute(Sender: TObject);
var
  ThisTimeModified: Boolean;
begin
  with TCodeTemplateFrm.Create(Self) do
  try
    ThisTimeModified := ShowModal = mrOK;
  finally
    Free;
  end;
  if ThisTimeModified then
  begin
    AutoCompleteListModified := True;
    UpdateTemplateMenuItems;
  end;
end;

procedure TMainFrm.AppActivate(Sender: TObject);
begin
  if not IsIconic(Application.Handle) and (CurMDIChild <> nil) then
     CurMDIChild.Activate;
end;

procedure TMainFrm.FileMenuClick(Sender: TObject);
begin
  fmReopenItem.Enabled := MRU.Items.Count > 0;
end;

procedure TMainFrm.stbOpenItemPopup(Sender: TTBCustomItem;
  FromLink: Boolean);
begin
  if MRU.Items.Count <= 0 then Abort;
end;

procedure TMainFrm.IdentTextCmdExecute(Sender: TObject);
begin
  CurSynEdit.ExecuteCommand(ecBlockIndent, #0, nil);
end;

procedure TMainFrm.UnIdentTextCmdExecute(Sender: TObject);
begin
  CurSynEdit.ExecuteCommand(ecBlockUnindent, #0, nil);
end;

procedure TMainFrm.UpperCaseCmdExecute(Sender: TObject);
var
  OldBB, OldBE: TPoint;
begin
  with CurSynEdit do
  if SelText = '' then
    ExecuteCommand(ecUpperCase, #0, nil) else
  begin
    OldBB := BlockBegin;
    OldBE := BlockEnd;
    SelText := AnsiUpperCase(SelText);
    BlockBegin := OldBB;
    BlockEnd := OldBE;
  end;
end;

procedure TMainFrm.LowerCaseCmdExecute(Sender: TObject);
var
  OldBB, OldBE: TPoint;
begin
  with CurSynEdit do
  if SelText = '' then
    ExecuteCommand(ecLowerCase, #0, nil) else
  begin
    OldBB := BlockBegin;
    OldBE := BlockEnd;
    SelText := AnsiLowerCase(SelText);
    BlockBegin := OldBB;
    BlockEnd := OldBE;
  end;
end;

procedure TMainFrm.ToggleCaseCmdExecute(Sender: TObject);
begin
  CurSynEdit.ExecuteCommand(ecToggleCase, #0, nil);
end;

procedure TMainFrm.CoteCmdExecute(Sender: TObject);
var
  OldCaretXY: TPoint;
begin
  with CurSynEdit do
  if SelText = '' then
  begin
    OldCaretXY := CaretXY;
    BlockBegin := WordStart;
    BlockEnd := WordEnd;
    SelText := QuoteStr(SelText);
    BlockBegin := CaretXY;
    Blockend := CaretXY;
    CaretXY := Point(OldCaretXY.X + 1 , OldCaretXY.Y);
  end else
    SelText := QuoteStr(SelText);
end;

procedure TMainFrm.WMCopyData(var Msg: TWMCopyData);
var
  S: String;
  C: Integer;
begin
  if Msg.CopyDataStruct^.dwData = SecondInstCmds then
  begin
    with TStringList.Create do
    try
      SetString(S, PChar(Msg.CopyDataStruct^.lpData), Msg.CopyDataStruct^.cbData);
      Text := S;
      for C := 0 to Count - 1 do
      try
        ExecuteCommand(Strings[C]);
      except
        Application.HandleException(Self);
      end;
    finally
      Free;
    end;

    if IsIconic(Application.Handle) then
      Application.Restore
    else begin
      Application.BringToFront;
      ForceForegroundWindow(Application.Handle);
    end;

    Msg.Result := Ord(True);
  end
    else inherited;
end;

procedure TMainFrm.ExecuteCommand(const Cmd: String);
const
  SCompileScriptCmd = 'Compile';
  SRunCmd = 'Run';
  SLoadLang = 'LoadLang';

  function IsCommand(const Command: String): Boolean;
  begin
    Result := Copy(Cmd, 1, Length(Command)+1) = Command + ':';
    if Result then
    begin
      NoStartup := True;
      NoLoadFileList := True;
    end;
  end;

  function GetCommandParam: String;
  begin
    Result := UnQuote(Copy(Cmd, AnsiPos(':', Cmd) + 1, MaxInt))
  end;

begin
  if Cmd <> '' then
  begin
    if IsCommand(SCompileScriptCmd) or IsCommand(SRunCmd) then
      OpenScriptFile(GetCommandParam).Compilar(IsCommand(SRunCmd))
    else if IsCommand(SLoadLang) then
    begin
      LoadLangFile(GetCommandParam);
      RememberLang := False;
    end else
    if not (Cmd[1] in ['/', '-']) then
    begin
      OpenFile(Cmd);
      NoStartup := True;
      NoLoadFileList := True;
    end;
  end;
end;

procedure TMainFrm.AssignIniAttri;
begin
  SynINI.KeyAttri.Assign(SynNSIS.KeyAttri);
  SynINI.CommentAttri.Assign(SynNSIS.CommentAttri);
  SynINI.SectionAttri.Assign(SynNSIS.DirectiveAttri);
  SynINI.TextAttri.Assign(SynNSIS.StringAttri);
  SynINI.StringAttri.Assign(SynNSIS.StringAttri);
  SynINI.NumberAttri.Assign(SynNSIS.StringAttri);
  SynINI.SpaceAttri.Assign(SynNSIS.SpaceAttri);
  SynINI.SymbolAttri.Assign(SynNSIS.ParameterAttri);
end;

procedure TMainFrm.NewIOCmdExecute(Sender: TObject);
begin
  OpenIniFile('');
end;

procedure TMainFrm.SaveDlgTypeChange(Sender: TObject);
var
  ExtPtr: PChar;
begin
  ExtPtr := PChar(FExtencions[SaveDlg.FilterIndex]);
  SendMessage(GetParent(SaveDlg.Handle), CDM_SETDEFEXT, 0, lParam(ExtPtr));
end;

procedure TMainFrm.ShowHelp(const Command: String);

  function GetCommandHelpLocalURL(const IsCHM: Boolean): String;
  var
    Target, Ext, ExtValueName, BaseNameDefault, DotCountValueName,
    BaseNameValueName, BaseName: String;
    DotCount, DotCountDefault: Integer;

    function GetPageId: String;
    var
      P: PChar;
      I, C: Integer;
    begin
      P := PChar(Target);
      C := 0;
      I := 0;
      while P^ <> #0 do
      begin
        if P^ = '.' then Inc(C);
        if C = DotCount then Break;
        Inc(I);
        Inc(P);
      end;
      Result := Copy(Target, 1, I);
    end;

  begin
    if IsCHM then
      Result := ''
    else
      Result := HelpFileName;
    if Command = '' then Exit;
    with TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'Config\HelpIndex.ini') do
    try
      Target := ReadString('Index', Command, '');
      if Target <> '' then
      begin
        if IsCHM then
        begin
          BaseNameValueName := 'HelpFileBaseNameCHM';
          ExtValueName := 'HelpFileExtCHM';
          BaseNameDefault := 'Section';
          DotCountValueName := 'DotCountCHM';
          DotCountDefault := 2;
        end else
        begin
          BaseNameValueName := 'HelpFileBaseName';
          ExtValueName := 'HelpFileExt';
          BaseNameDefault := 'Chapter';
          DotCountValueName := 'DotCount';
          DotCountDefault := 1;
        end;
        BaseName := ReadString('Options', BaseNameValueName, BaseNameDefault);
        Ext := ReadString('Options', ExtValueName, 'html');
        DotCount := ReadInteger('Options', DotCountValueName, DotCountDefault);
        Result := BaseName + GetPageId + '.' + Ext + '#' + Target;
        if not IsCHM then
          Result := ExtractFilePath(HelpFileName) + Result;
      end;
    finally
      Free;
    end;
  end;

var
  TempLocalURL: String;
  
  function GetHTMLHelpDataValue: Cardinal;
  begin
    TempLocalURL := GetCommandHelpLocalURL(True);
    if TempLocalURL = '' then
      Result := 0
    else
      Result := Cardinal(PChar(TempLocalURL));
  end;

begin
  if not FileExists(HelpFileName) and FileExists(Compiler) then
    HelpFileName := ExtractFilePath(Compiler) + DefaultHelpFile;
  if not FileExists(HelpFileName) then
  begin
    WarningDlg(LangStr('NoDocs'));
    if (not ShowConfig(2, True)) or (not FileExists(HelpFileName)) then Exit;
  end;
  if SameText(ExtractFileExt(HelpFileName), '.chm') and LoadHHCTRL then
    Utils.HtmlHelp(Handle, PChar(HelpFileName), HH_DISPLAY_TOPIC, GetHTMLHelpDataValue)
  else
    GotoURL(GetCommandHelpLocalURL(False));
end;

procedure TMainFrm.vmVisibilityToggleStatusBarItemClick(Sender: TObject);
begin
  EstBar.Top := ClientHeight;
end;

function TMainFrm.WordHaveHintUsage(const S: String): Boolean;
begin
   Result := SynNSIS.IdentKind(PChar(S)) in [SynHighlighterNSIS.tkKey,
     SynHighlighterNSIS.tkFunction, SynHighlighterNSIS.tkDirective];
end;

function TMainFrm.GetCompilerCmdLine(const ScriptFileName: String;
  NotifyWnd: HWnd): String;

  function GetParams: String;

    function GetDefines: String;
    var
      CurName: String;
      C: Integer;

      function GetValue: String;
      begin
        Result := DefineList.Values[CurName];
        if (Result <> '') and (AnsiPos(' ', Result) > 0) then
          Result := AnsiQuotedStr(Result, '"');
        if Result <> '' then
          Result := '=' + Result + ' '
        else
          Result := ' ';
      end;

    begin
      Result := '';
      for C := 0 to DefineList.Count - 1 do
      begin
        CurName := DefineList.Names[C];
        Result := Result + '/D' + CurName + GetValue;
      end;
    end;

  begin
    Result := OptionsIni.ReadString('Compiler', 'KK', '') + ' ';

    if OptionsIni.ReadBool('Compiler', 'UseNotifyWindow', False) and IsWindow(NotifyWnd) then
      Result := Result + Format('/NOTIFYHWND %d ', [NotifyWnd]);

    if Options.CompNoConfig then
      Result := Result + '/NOCONFIG ';

    if Options.CompNOCD then
      Result := Result + '/NOCD ';

    Result := Result + GetDefines;
  end;

begin
   Result := Format('"%s" %s "%s"', [Compiler, GetParams, ScriptFileName]);
end;

procedure TMainFrm.CopyAsHTMLCmdExecute(Sender: TObject);
var
  Exporter: TSynExporterHTML;
  Lines: TStrings;
begin
  Exporter := TSynExporterHTML.Create(Self);
  try
    Exporter.Highlighter := CurSynEdit.Highlighter;
    Exporter.CreateHTMLFragment := True;
    Exporter.ExportAsText := True;
    Lines := TStringList.Create;
    try
      Lines.Text := CurSynEdit.SelText;
      Exporter.ExportAll(Lines);
      Exporter.CopyToClipboard;
    finally
      Lines.Free;
    end;
  finally
    Exporter.Free;
  end;
end;

procedure TMainFrm.CopyAsHTMLCmdUpdate(Sender: TObject);
begin
  CopyAsHTMLCmd.Enabled := (CurSynEdit <> nil) and CurSynEdit.SelAvail
    and (CurSynEdit.Highlighter <> nil);
end;

procedure TMainFrm.OpenTemplate(const TemplateFile: String);
begin
  with OpenFile(TemplateFile, True, True) do
  begin
    FileName := '';
    InitValues;
    Modified := True;
  end;
end;

procedure TMainFrm.EditPopupPopup(Sender: TObject);
begin
  puTemplateItem.Enabled := (CurEditFrm <> nil) and
    (tmTemplateItem.Count > 0);
  puToggleBookmarkItem.Enabled := CurSynEdit <> nil;
  puGotoBookmarkItem.Enabled := puToggleBookmarkItem.Enabled and
    (CurSynEdit.Marks.Count > 0);
end;

procedure TMainFrm.ToolsMenuPopup(Sender: TTBCustomItem;
  FromLink: Boolean);
begin
  tmTemplateItem.Enabled := (CurEditFrm <> nil) and
    (tmTemplateItem.Count > 0);
end;

procedure TMainFrm.UpdateTemplateMenuItems;
var
  List: TStrings;
  C: Integer;
  Item: TTBXItem;
begin
  tmTemplateItem.Clear;
  List := TStringList.Create;
  try
    SynAutoComplete.GetTokenList(List);
    for C := 0 to List.Count -1 do
    begin
       Item := TTBXItem.Create(Self);
       Item.Caption := List[C];
       Item.OnClick := TemplateItemMenuClick;
       tmTemplateItem.Add(Item);
    end;
  finally
    List.Free;
  end;
end;

procedure TMainFrm.TemplateItemMenuClick(Sender: TObject);
begin
  SynAutoComplete.Execute(TTBXItem(Sender).Caption, CurEditFrm.Edit, False);
end;

function TMainFrm.GetNSISVersion: String;
var
  ProcHandle, ReadHandle: THandle;
  Buf: array[0..1024] of Char;
  BytesReaded: Cardinal;
  I: Integer;
begin
  if NSISVersion = '' then
  begin
    NSISVersion := '';
    if CreatePipeAndProcess('"' + Compiler + '" /VERSION', ProcHandle, ReadHandle) then
    begin
      if WaitForSingleObject(ProcHandle, 10000) = WAIT_OBJECT_0 then
      begin
        ReadFile(ReadHandle, Buf, SizeOf(Buf) - 1, BytesReaded, nil);
        CloseHandle(ProcHandle);
        CloseHandle(ReadHandle);

        Buf[BytesReaded] := #0;
        NSISVersion := Trim(Buf);

        { Check for old NSIS versions that not support the /VERSION command }
        I := AnsiPos(' - ', NSISVersion);
        if I = 0 then I := AnsiPos(#13, NSISVersion);
        if I > 0 then SetLength(NSISVersion, I-1);
      end;
    end;
  end;
  Result := NSISVersion;
end;

procedure TMainFrm.LoadLangFile(const ALangFile: String);
var
  C: Integer;
begin
  ResetLang(ExtractFilePath(ParamStr(0)) + 'Lang\' + ALangFile + '.lng');
  LoadLangStrs;
  UpdateStatus;
  InitFont(Font);
  for C := 0 to Screen.FormCount - 1 do
    Screen.Forms[C].Perform(WM_LANG_SET, 0, 0);
  Plugins.Notify(E_LANGCHANGED, Integer(PChar(LangFile)), StrToIntDef(LangStr('LangID'), 0));
end;

procedure TMainFrm.ApplicationException(Sender: TObject;
  E: Exception);
const
  SErrorStr = 'Cannot create file';
begin
  { To translate the exception message. I think that EFOpenError is the only
    exception that need to be translated. }
  if E is EFOpenError then
    E.Message := LangStrFormat('OpenFileError', [Copy(E.Message, Length(SErrorStr), MaxInt)]);

  // This work only if you modify the TZPropList.UpdateText method in the ZPropLst unit:
  // go to line 1745 and replace Application.ShowException(Exception(ExceptObject)); with
  // Application.HandleException(Self);
  if ((E is EPropertyError) or (E is EConvertError)) and (Sender is TZPropList) then
     Beep
   else
     Application.ShowException(E);
end;


function TMainFrm.CurDesignerFrm: TIODesignerFrm;
begin
  if ActiveMDIChild is TIODesignerFrm then
    Result := TIODesignerFrm(ActiveMDIChild)
  else
    Result := nil;
end;

procedure TMainFrm.IOCrtlPropListChange(Sender: TZPropList;
  Prop: TPropertyEditor);
begin
  if CurDesignerFrm <> nil then
  begin
    CurDesignerFrm.UpdateDisplay;
    CurDesignerFrm.Modified := True;
  end;
end;

procedure TMainFrm.SaveFileAsCmdUpdate(Sender: TObject);
begin
  SaveFileAsCmd.Enabled := (CurMDIChild <> nil);
end;

function TMainFrm.FindMDIChild(const FileName: String): TCustomMDIChild;
var
  C: Integer;
begin
  for C := 0 to MDIChildCount - 1 do
   if (MDIChildren[C] is TCustomMDIChild) then
   begin
     Result := TCustomMDIChild(MDIChildren[C]);
     if AnsiCompareFileName(Result.FileName, FileName) = 0 then Exit;
   end;
   Result := nil;
end;

function TMainFrm.OpenScriptFile(AFileName: String): TEditFrm;
var
  TempLines: TFileStream;
  {$IFDEF _TEST_LOAD_SPEED_}
  LoadStartTime: Cardinal;
  {$ENDIF}
begin
  {$IFDEF _TEST_LOAD_SPEED_}
  LoadStartTime := GetTickCount;
  {$ENDIF}

  TempLines := nil;
  try
    try
      { Load the file before create the window for avoid flicker if the
        file can't be opened. }
      if AFileName <> '' then
        TempLines := TFileStream.Create(AFileName, fmOpenRead or fmShareDenyNone);
    except
      NoStartup := True;
      raise;
    end;

    { if is the default window and isn't modified then load the file in it }
    if (FirstEdit <> nil) and (not FirstEdit.Edit.Modified) and (AFileName <> '') then
      EditFrm := FirstEdit
    else
      EditFrm := TEditFrm.Create(Self);

    with EditFrm do
    begin
      FileName := AFileName;
      try
        if TempLines <> nil then
          Edit.Lines.LoadFromStream(TempLines);
      except
        if FirstEdit <> EditFrm then
          FreeAndNil(EditFrm);
        raise;
      end;
      InitValues;
    end;
   { Asignamos nil al editor por defecto para evitar conflictos. }
    FirstEdit := nil;
  finally
    TempLines.Free;
  end;
  EditFrm.Show;
  Result := EditFrm;            

  {$IFDEF _TEST_LOAD_SPEED_}
  ShowMessage('File loaded in ' + IntToStr(GetTickCount - LoadStartTime) + ' ms');
  {$ENDIF}
end;

function TMainFrm.OpenIniFile(AFileName: String): TIODesignerFrm;
begin
  if (AFileName <> '') and (not IsValidIOFile(AFileName)) then
    raise Exception.CreateFmt(LangStr('NoValidIOIni'), [AFileName]);

  IODesignerFrm := TIODesignerFrm.Create(Self);
  if AFileName <> '' then
  try
    IODesignerFrm.LoadFile(AFileName);
  except
    FreeAndNil(IODesignerFrm);
    raise;
  end;
  IODesignerFrm.InitValues;
  IODesignerFrm.Show;
  UpdateStatus;
  Result := IODesignerFrm;
end;

procedure TMainFrm.CheckEditSel(Sender: TObject);
begin
  TAction(Sender).Enabled := (CurSynEdit <> nil) and CurSynEdit.SelAvail and
    (not CurSynEdit.ReadOnly);
end;

procedure TMainFrm.ExecuteDesingAction(Sender: TObject);
begin
  if Sender = BringToFrontCmd then
    CurDesignerFrm.RTDesigner.BringToFront
  else if Sender = SendToBackCmd then
    CurDesignerFrm.RTDesigner.SendToBack
  else if Sender = DeleteControlCmd then
    CurDesignerFrm.RTDesigner.DeleteSelection;
  CurDesignerFrm.Modified := True;
  IOCrtlPropList.Synchronize;  
end;

procedure TMainFrm.UpdateDesignAction(Sender: TObject);
begin
   TAction(Sender).Enabled := (CurDesignerFrm <> nil) and
     (CurDesignerFrm.RTDesigner.ControlCount > 0)
end;

function TMainFrm.CurSynEdit: TSynEdit;
begin
  if ActiveMDIChild is TCustomMDIChild then
    Result := TCustomMDIChild(ActiveMDIChild).SynEdit
  else
    Result := nil;
end;

function TMainFrm.CurMDIChild: TCustomMDIChild;
begin
  if ActiveMDIChild is TCustomMDIChild then
    Result := TCustomMDIChild(ActiveMDIChild)
  else
    Result := nil;
end;

procedure TMainFrm.ShowIOPanel;
begin
  IOPanel.Visible := ViewIOPanelCmd.Checked;
end;

procedure TMainFrm.AdjustSideDocks;
begin
  RightMultiDock.Left := ClientWidth;
  LeftMultiDock.Left := 0;
end;

procedure TMainFrm.IOPanelDockChanged(Sender: TObject);
begin
  AdjustSideDocks;
end;

procedure TMainFrm.ViewIOPanelCmdExecute(Sender: TObject);
begin
  ViewIOPanelCmd.Checked := not ViewIOPanelCmd.Checked;
  if (CurDesignerFrm <> nil) and CurDesignerFrm.DesignMode then
    IOPanel.Visible := ViewIOPanelCmd.Checked;
end;

procedure TMainFrm.EnableIOControls(const AEnabled: Boolean);
var
  C: Integer;
begin
  if not AEnabled then IOCrtlPropList.CurObj := nil;
  for C := 0 to tbIOCtrls.Items.Count - 1 do
    tbIOCtrls.Items[C].Enabled := AEnabled;
end;

procedure TMainFrm.ToggleDesingModeCmdUpdate(Sender: TObject);
begin
  ToggleDesingModeCmd.Enabled := CurDesignerFrm <> nil;
end;

procedure TMainFrm.ToggleDesingModeCmdExecute(Sender: TObject);
begin
  with CurDesignerFrm do
   DesignMode := not DesignMode;
end;

procedure TMainFrm.IOPanelClose(Sender: TObject);
begin
  ViewIOPanelCmd.Checked := False;
end;

procedure TMainFrm.ApplyOptions;
var
  C: Integer;
begin
  for C := 0 to ComponentCount - 1 do
  begin
    if Components[C] is TTBXToolBar then
      TTBXToolBar(Components[C]).SmoothDrag := Options.SmoothToolBar
    else if Components[C] is TTBXDockablePanel then
    begin
      TTBXDockablePanel(Components[C]).SmoothDrag := Options.SmoothPanel;
      TTBXDockablePanel(Components[C]).SmoothDockedResize := Options.SmoothPanel;
    end;
  end;
end;

procedure TMainFrm.BrowserCommandStateChange(Sender: TObject;
  Command: Integer; Enable: WordBool);
begin
  case Command of
    CSC_NAVIGATEFORWARD: btbForwardItem.Enabled := Enable;
    CSC_NAVIGATEBACK: btbBackItem.Enabled := Enable;
  end;
end;

procedure TMainFrm.BrowserStatusTextChange(Sender: TObject;
  const Text: WideString);
begin
  BrowserStatusBar.Panels[0].Caption := Text;
end;

procedure TMainFrm.BrowserTitleChange(Sender: TObject;
  const Text: WideString);
begin
  BrowserPanel.Caption := LangStr('Browser') + ' - ' + Text;
end;

procedure TMainFrm.BrowserProgressChange(Sender: TObject; Progress,
  ProgressMax: Integer);
begin
  BrowserProgressBar.Visible := Progress > 0;
  BrowserProgressBar.Max := ProgressMax;
  BrowserProgressBar.Position := Progress;
end;

procedure TMainFrm.BrowserNavigateComplete2(Sender: TObject;
  const pDisp: IDispatch; var URL: OleVariant);
begin
  try URLField.Text := URL; except end;
end;

procedure TMainFrm.btbBackItemClick(Sender: TObject);
begin
  try Browser.GoBack; except end;
end;

procedure TMainFrm.btbForwardItemClick(Sender: TObject);
begin
  try Browser.GoForward except end;
end;

procedure TMainFrm.btbStopItemClick(Sender: TObject);
begin
  try Browser.Stop except end;
end;

procedure TMainFrm.btbRefreshItemClick(Sender: TObject);
begin
  try Browser.Refresh except end;
end;

procedure TMainFrm.btbGoItemClick(Sender: TObject);
begin
  Browser.Navigate(URLField.Text);
end;

procedure TMainFrm.btbHomeItemClick(Sender: TObject);
begin
  Browser.Navigate(Options.BrowserHome);
end;

procedure TMainFrm.BrowserPanelVisibleChanged(Sender: TObject);
begin
  AdjustSideDocks;
  if (Browser <> nil) and BrowserPanel.Visible and
     FirstTimeShowBrowser then
  begin
    FirstTimeShowBrowser := False;
    btbHomeItem.Click;
  end;
end;

procedure TMainFrm.GotoLineCmdExecute(Sender: TObject);
var
  Ln: String;
begin
  with CurSynEdit do
  begin
    Ln := IntToStr(CaretY);
    if InputQuery(LangStr('GotoLineCaption'), LangStr('GotoLinePrompt'), Ln) then
    begin
      CaretY := StrToIntDef(Ln, CaretY);
      EnsureCursorPosVisibleEx(True);
    end;
  end;
end;

procedure TMainFrm.ViewSpecialCharsCmdUpdate(Sender: TObject);
begin
  ViewSpecialCharsCmd.Enabled := CurSynEdit <> nil;
  ViewSpecialCharsCmd.Checked := ViewSpecialCharsCmd.Enabled and
    (eoShowSpecialChars in CurSynEdit.Options);
end;

procedure TMainFrm.ViewSpecialCharsCmdExecute(Sender: TObject);
begin
  with CurSynEdit do
  begin
    if eoShowSpecialChars in Options then
      Options := Options - [eoShowSpecialChars]
    else
      Options := Options + [eoShowSpecialChars];
  end;
end;

procedure TMainFrm.UpdateWindowCmd(Sender: TObject);
begin
  TAction(Sender).Enabled := TileVerCmd.Enabled;
  wtbListItem.Enabled := TileVerCmd.Enabled;
end;

procedure TMainFrm.ExecuteWindowCmd(Sender: TObject);
begin
 if Sender = NextWindowCmd then Next
 else if Sender = PriorWindowCmd then Previous;
end;

procedure TMainFrm.ApplicationHint(Sender: TObject);
begin
  UpdateStatus;
end;

procedure TMainFrm.BrowseSite(Sender: TObject);
begin
  GotoUrl(TTBXItem(Sender).Hint);
end;


procedure TMainFrm.WMHideSplash(var Msg: TMessage);
begin 
  HideSplash;
end;

procedure TMainFrm.WinListChange(Sender: TObject; Node: TTreeNode);
begin
  TForm(Node.Data).Show;
end;

procedure TMainFrm.FlagsPopupItemClick(Sender: TObject);
var
  S: String;
  C: Integer;
  CurCtrl: TIOControl;
begin
  S := '';
  TTBXItem(Sender).Checked := not TTBXItem(Sender).Checked;
  for C := 0 to IOCtrlFlagsPopup.Items.Count - 1 do
  with IOCtrlFlagsPopup.Items[C] do
    if Checked then S := S + Caption + '|';

  if (S <> '') and (AnsiLastChar(S)^ = '|') then
    SetLength(S, Length(S) - 1);

  CurCtrl := TIOControl(CurDesignerFrm.RTDesigner.Control[0]);
  CurCtrl.Properties.Flags := S;
  CurCtrl.UpdateDisplay;
  IOCrtlPropList.Synchronize;
end;

procedure TMainFrm.CheckForValidCompiler;
begin
  if not FileExists(Compiler) then
  begin
    WarningDlg(LangStr('NoCompiler'));
    if (not ShowConfig(2, True)) or (not FileExists(Compiler)) then Abort;
  end;
end;

procedure TMainFrm.SaveAsMDIChild(MDIChild: TCustomMDIChild);
const
  Exts: array[Boolean] of String = ('nsi', 'ini');
var
  Filters: array[1..3] of String;
  AlreadySaved: Boolean;
begin
  FillChar(Filters, SizeOf(Filters), #0);
  FillChar(FExtencions, SizeOf(FExtencions), #0);

  AlreadySaved := MDIChild.FileName <> '';
  if MDIChild.FileName = '' then
    SaveDlg.FileName := MDIChild.Caption
  else
    SaveDlg.FileName := ChangeFileExt(ExtractFileName(MDIChild.FileName), '');

  if MDIChild is TIODesignerFrm then
  begin
    Filters[1] := 'INIFileFilter';
    FExtencions[1] := 'ini';
    if AlreadySaved and (MDIChild.SynEdit <> nil) and
     (MDIChild.SynEdit.Highlighter <> nil) then
    begin
      Filters[2] := 'HTMLFileFilter';
      Filters[3] := 'RTFFileFilter';
      FExtencions[2] := 'htm';
      FExtencions[3] := 'rtf';
    end;
  end else
  if MDIChild is TEditFrm then
  begin
    Filters[1] := 'NSISFileFilter';
    FExtencions[1] := 'nsi';
    if AlreadySaved and (MDIChild.SynEdit <> nil) and
     (MDIChild.SynEdit.Highlighter <> nil) then
    begin
      Filters[2] := 'HTMLFileFilter';
      Filters[3] := 'RTFFileFilter';
      FExtencions[2] := 'htm';
      FExtencions[3] := 'rtf';
    end else
    begin
      Filters[2] := 'NSHFileFilter';
      FExtencions[2] := 'nsh';
    end;
  end;

  SaveDlg.DefaultExt := FExtencions[1];
  SaveDlg.Filter := GetLangFileFilter(Filters);
  SaveDlg.FilterIndex := 1;

  if SaveDlg.Execute then
  begin
    Application.ProcessMessages;
    if not AlreadySaved then
      MDIChild.SaveFile(SaveDlg.FileName) else
    case SaveDlg.FilterIndex of
      1, 4: MDIChild.SaveFile(SaveDlg.FileName);
      2: if MDIChild.SynEdit <> nil then
            SynEditExportLines(MDIChild.SynEdit, TSynExporterHTML, SaveDlg.FileName)
         else
           MDIChild.SaveFile(SaveDlg.FileName);
      3: if MDIChild.SynEdit <> nil then
           SynEditExportLines(MDIChild.SynEdit, TSynExporterRTF, SaveDlg.FileName)
         else
           MDIChild.SaveFile(SaveDlg.FileName);
    end;
    UpdateStatus;
  end
   else Abort;
end;

procedure TMainFrm.SaveMDIChild(MDIChild: TCustomMDIChild);
begin
  with MDIChild do
  begin
    if FileName = '' then
      SaveAsMDIChild(MDIChild)
    else
      SaveFile('');
    if (not Options.UndoAfterSave) then
    begin
      if (SynEdit <> nil) then
        SynEdit.ClearUndo
      else if MDIChild is TIODesignerFrm then
        TIODesignerFrm(MDIChild).RTDesigner.ResetUndo;
    end;
  end;
end;


procedure TMainFrm.WinListPopupPopup(Sender: TObject);
begin
  WinListActionForm := nil;
  if WinList.Selected = nil then Abort;
  WinListActionForm := TCustomMDIChild(WinList.Selected.Data);
end;

procedure TMainFrm.ShowWindowCmdExecute(Sender: TObject);
begin
  WinListActionForm.Show;
end;

procedure TMainFrm.CloseWindowCmdExecute(Sender: TObject);
begin
  WinListActionForm.Close;
end;

procedure TMainFrm.CompWinCmdUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := (WinListActionForm is TEditFrm) and TEditFrm(WinListActionForm).AllowCompile;
end;

procedure TMainFrm.CompWinCmdExecute(Sender: TObject);
begin
  CheckForValidCompiler;
  SaveMDIChild(WinListActionForm);
  TEditFrm(WinListActionForm).Compilar(Sender = CompRunWinCmd);
end;

procedure TMainFrm.RunWinCmdUpdate(Sender: TObject);
begin
  RunWinCmd.Enabled := (WinListActionForm is TEditFrm) and (not TEditFrm(WinListActionForm).IsCompiling) and
    TEditFrm(WinListActionForm).SuccessCompile;
end;

procedure TMainFrm.RunWinCmdExecute(Sender: TObject);
begin
  TEditFrm(WinListActionForm).RunSetup;
end;

procedure TMainFrm.SaveWinCmdUpdate(Sender: TObject);
begin
  SaveWinCmd.Enabled := (WinListActionForm <> nil) and (WinListActionForm.Modified or
    (WinListActionForm.FileName = ''));
end;

procedure TMainFrm.SaveWinCmdExecute(Sender: TObject);
begin
  SaveMDIChild(WinListActionForm);
end;

procedure TMainFrm.SaveAsWinCmdExecute(Sender: TObject);
begin
  SaveAsMDIChild(WinListActionForm);
end;

procedure TMainFrm.CreateBrowser;
begin
  try
    Browser := TWebBrowser.Create(Self);
    TControl(Browser).Parent := BrowserPanel;
    Browser.Align := alClient;
    Browser.OnCommandStateChange := BrowserCommandStateChange;
    Browser.OnStatusTextChange := BrowserStatusTextChange;
    Browser.OnTitleChange := BrowserTitleChange;
    Browser.OnProgressChange := BrowserProgressChange;
    Browser.OnNavigateComplete2 := BrowserNavigateComplete2;
  except
    Application.HandleException(Self);
    Browser := nil;
  end;
end;

procedure TMainFrm.GotoBookmarkClick(Sender: TObject);
begin
  CurSynEdit.GotoBookMark(TTBXItem(Sender).Tag);
end;

procedure TMainFrm.ToggleBookmarkClick(Sender: TObject);
begin
  with CurSynEdit do
    if not TTBXItem(Sender).Checked then
      SetBookMark(TTBXItem(Sender).Tag, CaretX, CaretY)
    else
      ClearBookMark(TTBXItem(Sender).Tag);
end;

procedure TMainFrm.smToggleBookmarkItemPopup(Sender: TTBCustomItem;
  FromLink: Boolean);
var
  C: Integer;
begin
  for C := 0 to smToggleBookmarkItem.Count - 1 do
    smToggleBookmarkItem.Items[C].Checked := False;
  with CurSynEdit do
  for C := 0 to Marks.Count - 1 do
    smToggleBookmarkItem.Items[Marks[C].BookmarkNumber].Checked := True;
end;

procedure TMainFrm.smGotoBookmarkItemPopup(Sender: TTBCustomItem;
  FromLink: Boolean);
var
  List: TStringList;
  Item: TTBXItem;
  C: Integer;
begin
  List := TStringList.Create;
  try
    with CursynEdit do
    for C := 0 to Marks.Count - 1 do
    begin
      Item := TTBXItem.Create(Self);
      Item.Caption := LangStr('Bookmark') + ' &' + IntToStr(Marks[C].BookmarkNumber);
      Item.Tag := Marks[C].BookmarkNumber;
      Item.OnClick := GotoBookmarkClick;
      List.AddObject(IntToStr(Item.Tag), Item);
    end;
    List.Sort;
    smGotoBookmarkItem.Clear;
    for C := 0 to List.Count - 1 do
      smGotoBookmarkItem.Add(TTBXItem(List.Objects[C]));
  finally
    List.Free;
  end;
end;

procedure TMainFrm.SearchMenuPopup(Sender: TTBCustomItem; FromLink: Boolean);
begin
  smToggleBookmarkItem.Enabled := CurSynEdit <> nil;
  smGotoBookmarkItem.Enabled := smToggleBookmarkItem.Enabled and
    (CurSynEdit.Marks.Count > 0);
end;

procedure TMainFrm.URLFieldKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
    btbGoItem.Click;
end;

function TMainFrm.FindItemByName(const ItemName: String): TTBCustomItem;
var
  Comp: TComponent;
begin
  Comp := FindComponent(ItemName);
  if Comp is TTBCustomItem then
    Result := TTBCustomItem(Comp)
  else
    Result := nil;
end;

function TMainFrm.FindToolBarByName(const TBName: String): TTBCustomToolBar;
var
  Comp: TComponent;
begin
  Comp := FindComponent(TBName);
  if Comp is TTBCustomToolBar then
    Result := TTBCustomToolBar(Comp)
  else
    Result := nil;
end;

function TMainFrm.FintTBItemsByToolBarName(const TBName: String): TTBCustomItem;
var
  Comp: TComponent;
begin
  Comp := FindComponent(TBName);
  if Comp is TTBCustomToolBar then
    Result := TTBCustomToolBar(Comp).Items
  else if Comp is TTBPopupMenu then
    Result := TTBPopupMenu(Comp).Items
  else
    Result := nil;
end;

procedure TMainFrm.InsertToolBarItem(const ParentItemName: String;
  AtIndex: Integer; ItemData: PTBItemData);
var
  ParentItem: TTBCustomItem;
  NewItem: TTBCustomItem;
begin
  NewItem := nil;
  try
    // Find a toolbar or popup menu
    ParentItem := FintTBItemsByToolBarName(ParentItemName);
    // if no toolbar or popup menu found then find for individual items
    if ParentItem = nil then
      ParentItem := FindItemByName(ParentItemName);

    // if no ItemData then create a separator
    if ItemData <> nil then
      NewItem := TTBXPluginItem.CreateItem(ItemData)
    else
      NewItem := TTBXSeparatorItem.Create(Self);

    // If index < 0 then add the item at the bottom of the list
    if AtIndex >= 0 then
      ParentItem.Insert(AtIndex, NewItem)
    else
      ParentItem.Add(NewItem);
  except
    NewItem.Free;
    raise;
  end;
end;

procedure TMainFrm.GotoURL(const URL: String);
begin
  if (not Options.UseDefBrowser) and (Browser <> nil) and
    (GetKeyState(VK_SHIFT) >= 0) then
  begin
    Browser.Navigate(URL);
    FirstTimeShowBrowser := False;
    BrowserPanel.Show;
  end else
    ShellExecute(Handle, 'open', PChar(URL),
      nil, nil, SW_NORMAL);
end;

procedure TMainFrm.TBMThemeChange(var Msg: TMessage);
var
  S: String;
begin
  if Msg.WParam = TSC_AFTERVIEWCHANGE then
  begin
    S := TBXCurrentTheme;
    Plugins.Notify(E_TBTHEMECHANGED, Integer(PChar(S)));
  end;
end;

procedure TMainFrm.ApplicationMessage(var Msg: TMSG; var Handled: Boolean);
begin
  if Assigned(Plugins) then
    Handled := Plugins.MessageHook(@Msg);
end;

procedure TMainFrm.SetTabOrderCmdExecute(Sender: TObject);
begin
  if SetIOTabOrder(CurDesignerFrm) then
    IOCrtlPropList.Synchronize;
end;

procedure TMainFrm.SetTabOrderCmdUpdate(Sender: TObject);
begin
  SetTabOrderCmd.Enabled := CurDesignerFrm <> nil;
end;

procedure TMainFrm.IOCrtlPropListAddProperty(Sender: TZPropList;
  Prop: TPropertyEditor; var AllowAdd: Boolean);
begin
  case Options.ShowIODimsKind of
    sdRightBottom: if SameText(Prop.GetName, 'Width') or SameText(Prop.GetName, 'Height') then AllowAdd := False;
    sdWidthHeight: if SameText(Prop.GetName, 'Right') or SameText(Prop.GetName, 'Bottom') then AllowAdd := False;
    sdBoth: AllowAdd := True;
  end;
end;

type
  TTBXResizeItem = class(TTBXItem)
  private
    FSize: TPoint;
  public
    property Size: TPoint read FSize write FSize;
  end;

procedure TMainFrm.ResizeDesigner(Sender: TObject);
begin
  with TTBXResizeItem(Sender).Size do
    CurDesignerFrm.ResizeTo(X, Y);
end;

procedure TMainFrm.DesignMenuPopup(Sender: TObject);
var
  ItemCaption, Dims, S: String;
  Item: TTBXResizeItem;
begin
  if (iopResizeItem.Count = 0) then
  begin
    S := LangStr('ResizeItems');
    while S <> '' do
    begin
      ItemCaption := ExtractStr(S, '|');
      Dims := ExtractStr(S, ';');
      if (GetXValue(Dims) > 0) and (GetYValue(Dims) > 0) then
      begin
        Item := TTBXResizeItem.Create(Self);
        Item.Caption := ItemCaption + ' (' + Dims + ')';
        Item.OnClick := ResizeDesigner;
        Item.Size := Point(GetXValue(Dims), GetYValue(Dims));
        iopResizeItem.Add(Item);
      end;
    end;
  end;
  iopResizeItem.Enabled := iopResizeItem.Count > 0;
  iopResizeItem.Visible := iopResizeItem.Enabled;
end;

procedure TMainFrm.CMRWindowCmdExecute(Sender: TObject);
begin
  if ((FLastUsedWindow = nil) or (FLastUsedWindow = CurMDIChild)) and (MDIChildCount > 1) then
    FLastUsedWindow := TCustomMDIChild(MDIChildren[1]);
  if FLastUsedWindow <> nil then
    FLastUsedWindow.Show;
end;

procedure TMainFrm.CMRWindowCmdUpdate(Sender: TObject);
begin
  CMRWindowCmd.Enabled := MDIChildCount > 1;
end;

procedure TMainFrm.LoadOptions(IniFile: TCustomIniFile; const LoadOptionsOptions: TLoadOptionsOptions);
var
  C, DefGridDim: Integer;
  S: String;
begin
  with IniFile do
  begin
    Options.ShowMelcomeDlg := ReadBool('Options', 'ShowStartup', True);
    Options.IniFilesDesignMode := ReadBool('Options', 'IniFilesDesignMode', True);
    Options.SmoothToolBar := ReadBool('Options', 'SmoothToolBar', True);
    Options.SmoothPanel := ReadBool('Options', 'SmoothToolPanel', False);
    Options.SaveFileList := ReadBool('Options', 'SaveFileList', False);
    Options.BrowserHome := ReadString('Options', 'BrowserHome',
      'http://forums.winamp.com/forumdisplay.php?s=&forumid=65');

    Options.UseDefBrowser := ReadBool('Options', 'UseDefBrowser', True);
    Options.IOShowGrid := ReadBool('Options', 'IOShowGrid', True);
    Options.IOSnapToGrid := ReadBool('Options', 'IOSnapToGrid', False);
    Options.ShowIODimsKind := TShowIODimsKind(ReadInteger('Options', 'ShowIODimsKind', 0));
    Options.IOGridKind := TGridKind(ReadInteger('Options', 'GridKind', Ord(gkDots)));
    Options.IOGridColor := ReadInteger('Options', 'GridColor', clBlack);

    DefGridDim := PixelsToDialogUnitsX(8, GetAveCharSize(Canvas).X);
    Options.IOGridDims.X := ReadInteger('Options', 'IOGridDimsX', DefGridDim);
    Options.IOGridDims.Y := ReadInteger('Options', 'IOGridDimsY', DefGridDim);
    if Options.IOGridDims.X < 1 then
      Options.IOGridDims.X := DefGridDim;
    if Options.IOGridDims.Y < 1 then
      Options.IOGridDims.Y := DefGridDim;

    ApplyOptions;

    EstBar.Visible := ReadBool('Options', 'StatusBarVisible', EstBar.Visible);
    ViewIOPanelCmd.Checked := ReadBool('Options', 'IOPanelVisible', True);
    Options.ShowCmdHint := ReadBool('Options', 'UsageHints', True);
    MRU.LoadFromIni(IniFile, 'Recent');
    Options.UndoAfterSave := ReadBool('Options', 'UndoAfterSave', True);
    EditorOptions.Font.Name := LangIni.ReadString('Fonts', 'DefaultEditorFontName', EditorOptions.Font.Name);
    EditorOptions.Font.Size := LangIni.ReadInteger('Fonts', 'DefaultEditorFontSize', EditorOptions.Font.Size);
    EditorOptions.LoadFromIni(IniFile, 'Options');

    if IniFile is TRegistryIniFile then
    begin
      TBRegLoadPositions(Self, HKEY_CURRENT_USER, 'Software\HM Software\NIS Edit\ToolBars');
      SynNSIS.LoadFromRegistry(HKEY_CURRENT_USER, 'Software\HM Software\NIS Edit\SynColors');
    end else
    begin
      TBIniLoadPositions(Self, IniFile.FileName, 'ToolBar_');
      SynNSIS.LoadFromFile(IniFile.FileName);
    end;

    SynNSIS.HighlightVarsInsideStrings := ReadBool('SynColors',
      'HighlightVarsInsideStrings', True);
    SetUseHighLighter(ReadBool('Options', 'Highlighter', True));
    AssignIniAttri;

    Compiler := ReadString('Compiler', 'Compiler', '');
    HelpFileName := ReadString('Compiler', 'CompHelp', '');

    Options.CompNoConfig := ReadBool('Compiler', 'NoConfig', False);
    Options.CompNOCD := ReadBool('Compiler', 'NOCD', False);

    if (HelpFileName = '') or (Compiler = '') then
    with TRegistry.Create do
    try
      RootKey := HKEY_LOCAL_MACHINE;
      if OpenKeyReadOnly('SOFTWARE\NSIS') then
      begin
        if Compiler = '' then Compiler :=
          IncludeTrailingBackSlash(ReadString('')) + 'makensis.exe';
        if HelpFileName = '' then HelpFileName := ExtractFilePath(Compiler) + DefaultHelpFile;
      end;
    finally
      Free;
    end;

    if loLoadDefines in LoadOptionsOptions then
    begin
      DefineList.Clear;
      ReadSection('Compiler\Defines', DefineList);
      for C := 0 to DefineList.Count - 1 do
      begin
        S := DefineList[C];
        DefineList[C] := S + '=' + ReadString('Compiler\Defines', S, '');
      end;
    end;

    SynAutoComplete.ShortCut := ReadInteger('Options','AutoCompleteShortCut', SynAutoComplete.ShortCut);

    if loLoadLang in LoadOptionsOptions then
      LoadLangFile(ReadString('Options', 'Language', 'English'));

    if (loLoadTBTheme in LoadOptionsOptions) then
    begin
      S := ReadString('ToolBars', 'Theme', 'Default');
      if (TBXCurrentTheme <> S) then TBXSetTheme(S);
    end;
  end;
end;

procedure TMainFrm.SaveOptions(IniFile: TCustomIniFile; const SaveOptionsOptions: TSaveOptionsOptions);
var
  WindowPlacement: TWindowPlacement;
  C: Integer;
  S: String;
begin
  with IniFile do
  begin
    if soSaveCompSettings in SaveOptionsOptions then
    begin
      WriteString('Compiler', 'Compiler', Compiler);
      WriteString('Compiler', 'CompHelp', HelpFileName);
      WriteBool('Compiler', 'NoConfig', Options.CompNoConfig);
      WriteBool('Compiler', 'NOCD', Options.CompNOCD);
    end;

    if soSaveDefines in SaveOptionsOptions then
    begin
      EraseSection('Compiler\Defines');
      for C := 0 to DefineList.Count - 1 do
      begin
        S := DefineList.Names[C];
        WriteString('Compiler\Defines', S, DefineList.Values[S]);
      end;
    end;

    WriteBool('Options', 'UseDefBrowser', Options.UseDefBrowser);
    WriteBool('Options', 'UsageHints', Options.ShowCmdHint);
    WriteBool('Options', 'Highlighter', FUseHighlighter);
    WriteInteger('Options', 'AutoCompleteShortCut', SynAutoComplete.ShortCut);
    WriteBool('Options', 'UndoAfterSave', Options.UndoAfterSave);
    WriteBool('Options', 'StatusBarVisible', EstBar.Visible);
    WriteString('Options', 'BrowserHome', Options.BrowserHome);
    WriteBool('Options', 'IOPanelVisible', ViewIOPanelCmd.Checked);
    if RememberLang then
      WriteString('Options', 'Language', ChangeFileExt(ExtractFileName(LangFile), ''));

    WriteBool('Options', 'ShowStartup', Options.ShowMelcomeDlg);
    WriteBool('Options', 'IniFilesDesignMode', Options.IniFilesDesignMode);
    WriteBool('Options', 'SmoothToolBar', Options.SmoothToolBar);
    WriteBool('Options', 'SmoothToolPanel', Options.SmoothPanel);
    WriteBool('Options', 'SaveFileList', Options.SaveFileList);

    WriteBool('Options', 'IOShowGrid', Options.IOShowGrid);
    WriteBool('Options', 'IOSnapToGrid', Options.IOSnapToGrid);
    WriteInteger('Options', 'ShowIODimsKind', Ord(Options.ShowIODimsKind));

    WriteInteger('Options', 'IOGridDimsX', Options.IOGridDims.X);
    WriteInteger('Options', 'IOGridDimsY', Options.IOGridDims.Y);
    WriteInteger('Options', 'GridKind', Ord(Options.IOGridKind));
    WriteInteger('Options', 'GridColor', Options.IOGridColor);

    EditorOptions.SaveToIni(IniFile, 'Options');

    WindowPlacement.length := SizeOf(WindowPlacement);
    GetWindowPlacement(Handle, @WindowPlacement);
    WriteInteger('State', 'WindowLeft', WindowPlacement.rcNormalPosition.Left);
    WriteInteger('State', 'WindowTop', WindowPlacement.rcNormalPosition.Top);
    WriteInteger('State', 'WindowRight', WindowPlacement.rcNormalPosition.Right);
    WriteInteger('State', 'WindowBottom', WindowPlacement.rcNormalPosition.Bottom);
    WriteBool('State', 'WindowMaximized', WindowState = wsMaximized);

    MRU.SaveToIni(IniFile, 'Recent');
    WriteBool('SynColors', 'HighlightVarsInsideStrings', SynNSIS.HighlightVarsInsideStrings);
    WriteString('ToolBars', 'Theme', TBXCurrentTheme);

    if IniFile is TRegistryIniFile then
    begin
      SynNSIS.SaveToRegistry(HKEY_CURRENT_USER, 'Software\HM Software\NIS Edit\SynColors');
      TBRegSavePositions(Self, HKEY_CURRENT_USER, 'Software\HM Software\NIS Edit\ToolBars');
    end else
    begin
      SynNSIS.SaveToFile(IniFile.FileName);
      TBIniSavePositions(Self, IniFile.FileName, 'ToolBar_');
    end;

    if soSaveFileList in SaveOptionsOptions then
      SaveFileList(IniFile);
  end;
end;

function TMainFrm.LoadFileList(IniFile: TCustomIniFile): Boolean;
var
  C: Integer;
  List: TStrings;
  WinPlacStr, Value: String;
  SaveViewIOPanel: Boolean;
  WindowPlacement: TWindowPlacement;
  Form: TCustomMDIChild;
begin
  Result := False;
  if NoLoadFileList then Exit;
  List := TStringList.Create;
  MaximizeFirst := False;
  SaveViewIOPanel := ViewIOPanelCmd.Checked;
  ViewIOPanelCmd.Checked := False;
  try
    IniFile.ReadSection('OpenedFiles', List);
    for C := List.Count - 1 downto 0 do
    begin
      Value := IniFile.ReadString('OpenedFiles', List[C], '');
      try
        Form := OpenFile(List[C]);

        WinPlacStr := ExtractStr(Value, ',');

        if Form is TIODesignerFrm then
           TIODesignerFrm(Form).DesignMode := Value = '';

        if TextToBin(WinPlacStr, WindowPlacement, SizeOf(TWindowPlacement)) then
          SetWindowPlacement(Form.Handle, @WindowPlacement);

        if Form.SynEdit <> nil then
          with Form.SynEdit do
          begin
            CaretY := StrToIntDef(ExtractStr(Value, ','), 1);
            CaretX := StrToIntDef(ExtractStr(Value, ','), 1);
            LeftChar := StrToIntDef(ExtractStr(Value, ','), 1);
            TopLine := StrToIntDef(ExtractStr(Value, ','), 1);
          end;
      except
        Application.HandleException(Self);
      end;
      Result := True;
    end;
  finally
    ViewIOPanelCmd.Checked := SaveViewIOPanel;
    MaximizeFirst := True;
    List.Free;
  end;
  if (MDIChildCount > 0) and (MDIChildren[0] is TCustomMDIChild) then
    TCustomMDIChild(MDIChildren[0]).Activate;
end;

procedure TMainFrm.SaveFileList(IniFile: TCustomIniFile);
var
  C: Integer;
  Value: String;
  WindowPlacement: TWindowPlacement;
begin
  IniFile.EraseSection('OpenedFiles');
  IniFile.UpdateFile;
  if Options.SaveFileList then
  for C := 0 to MDIChildCount - 1 do
    if MDIChildren[C] is TCustomMDIChild then
      with TCustomMDIChild(MDIChildren[C]) do
        if FileName <> '' then
        begin
          WindowPlacement.length := SizeOf(WindowPlacement);
          GetWindowPlacement(Handle, @WindowPlacement);
          Value := BinToText(WindowPlacement, WindowPlacement.length);
          if SynEdit <> nil then
            with SynEdit do
              Value := Value + Format(',%d,%d,%d,%d', [CaretY, CaretX, LeftChar, TopLine]);
          IniFile.WriteString('OpenedFiles', FileName, Value);
        end;
end;


initialization
  SynHighlighterNSIS.TokensFileName := ExtractFilePath(ParamStr(0)) + 'Config\Syntax.ini';
end.
