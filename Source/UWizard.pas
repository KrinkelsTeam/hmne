{
  HM NIS Edit (c) 2003 Héctor Mauricio Rodríguez Segura <ranametal@users.sourceforge.net>
  For conditions of distribution and use, see license.txt

  Wizard Form code

}
unit UWizard;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, ActnList, ScriptGen, TB2Item, TB2Dock, TB2Toolbar, ExtCtrls,
  TBX, NewGroupBox;

type
  TWizardFrm = class(TForm)
    Panel2: TPanel;
    Bevel2: TBevel;
    AtrasBtn: TButton;
    SiguienteBtn: TButton;
    CancelarBtn: TButton;
    ActionList1: TActionList;
    AgregarArchivoCmd: TAction;
    EditarArchivoCmd: TAction;
    EliminarArchivoCmd: TAction;
    NuevoGrupoCmd: TAction;
    EliminarGrupoCmd: TAction;
    PnlMain: TPanel;
    PageNameLabel: TStaticText;
    PageDescriptionLabel: TStaticText;
    Bevel1: TBevel;
    InnerImage: TImage;
    OpenLicDlg: TOpenDialog;
    EditarGrupoCmd: TAction;
    AgregarLinkCmd: TAction;
    EliminarLinkCmd: TAction;
    EditLinkCmd: TAction;
    OpenIconDlg: TOpenDialog;
    SaveDlg: TSaveDialog;
    OpenDlg: TOpenDialog;
    ColorDlg: TColorDialog;
    NB1: TNotebook;
    WelcomeImage: TImage;
    WelcomeLabel1: TStaticText;
    WelcomeLabel2: TStaticText;
    WelcomeLabel3: TStaticText;
    WelcomeLabel4: TStaticText;
    Label2: TStaticText;
    Label3: TStaticText;
    Label4: TStaticText;
    Label1: TStaticText;
    VersionEdt: TEdit;
    WebEdt: TEdit;
    NombreEdt: TEdit;
    PublisherEdt: TEdit;
    Label5: TStaticText;
    Label10: TStaticText;
    Label12: TStaticText;
    Label13: TStaticText;
    Label15: TStaticText;
    LangEdt: TComboBox;
    InstIconEdt: TEdit;
    Button1: TButton;
    ExeEdt: TEdit;
    Button3: TButton;
    GroupBox2: TNewGroupBox;
    DirEdt: TComboBox;
    DirChk: TCheckBox;
    GroupBox1: TNewGroupBox;
    LicFileEdt: TEdit;
    ExaminarLicBtn: TButton;
    CmpChk: TCheckBox;
    Bevel3: TBevel;
    GroupBox3: TNewGroupBox;
    GrupoEdt: TEdit;
    InicioChk: TCheckBox;
    WebIconChk: TCheckBox;
    UninstIconChk: TCheckBox;
    IconLst: TListView;
    TBToolbar1: TTBXToolbar;
    TBItem3: TTBXItem;
    TBItem2: TTBXItem;
    TBItem1: TTBXItem;
    Label6: TStaticText;
    Label7: TStaticText;
    Label8: TStaticText;
    ParamsEdt: TEdit;
    FinishedImage: TImage;
    Label9: TStaticText;
    Label16: TStaticText;
    Label17: TStaticText;
    CompChk: TCheckBox;
    SaveChk: TCheckBox;
    RelativeChk: TCheckBox;
    ProgramaEdt: TComboBox;
    LeameEdt: TComboBox;
    GroupBox4: TNewGroupBox;
    UseUninstChk: TCheckBox;
    Label11: TStaticText;
    Label18: TStaticText;
    Label19: TStaticText;
    UninstIconEdt: TEdit;
    BUIBtn: TButton;
    UninstSuccesMsgEdt: TEdit;
    UninstPromptEdt: TEdit;
    GuiEdt: TComboBox;
    CompressEdt: TComboBox;
    NewGroupBox1: TNewGroupBox;
    TBToolbar2: TTBXToolbar;
    TBItem6: TTBXItem;
    TBItem5: TTBXItem;
    TBItem4: TTBXItem;
    TBToolbar3: TTBXToolbar;
    TBItem9: TTBXItem;
    TBItem8: TTBXItem;
    TBItem7: TTBXItem;
    FileLst: TListView;
    GrupoLst: TListBox;
    ComentGrp: TMemo;
    Label14: TStaticText;
    LicenseForceSelectionBtns: TNewGroupBox;
    LicenseForceSelectionBtns1: TRadioButton;
    LicenseForceSelectionBtns2: TRadioButton;
    LicenseForceSelectionBtns3: TRadioButton;
    procedure FormDestroy(Sender: TObject);
    procedure ComentGrpChange(Sender: TObject);
    procedure GrupoLstClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ComentGrpKeyPress(Sender: TObject; var Key: Char);
    procedure FileLstDblClick(Sender: TObject);
    procedure AgregarArchivoCmdExecute(Sender: TObject);
    procedure EditarArchivoCmdExecute(Sender: TObject);
    procedure EliminarArchivoCmdExecute(Sender: TObject);
    procedure NuevoGrupoCmdExecute(Sender: TObject);
    procedure EliminarGrupoCmdExecute(Sender: TObject);
    procedure CheckGrupoIdx(Sender: TObject);
    procedure CheckFileSelected(Sender: TObject);
    procedure AtrasBtnClick(Sender: TObject);
    procedure SiguienteBtnClick(Sender: TObject);
    procedure ExaminarLicBtnClick(Sender: TObject);
    procedure GrupoLstDblClick(Sender: TObject);
    procedure EliminarGrupoCmdUpdate(Sender: TObject);
    procedure EditarGrupoCmdExecute(Sender: TObject);
    procedure AgregarLinkCmdExecute(Sender: TObject);
    procedure EliminarLinkCmdUpdate(Sender: TObject);
    procedure EliminarLinkCmdExecute(Sender: TObject);
    procedure EditLinkCmdExecute(Sender: TObject);
    procedure IconLstDblClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure BUIBtnClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure AgregarLinkCmdUpdate(Sender: TObject);
    procedure SaveChkClick(Sender: TObject);
    procedure SetTag(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure NombreEdtChange(Sender: TObject);
    procedure GrupoLstDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure GrupoLstDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure LicFileEdtChange(Sender: TObject);
    procedure UseUninstChkClick(Sender: TObject);
  private
    HaveFiles: Boolean;
    SaveRelative: Boolean;
    SaveComp: Boolean;
    NeedUpdateLists: Boolean;
    function GrupoActual: TSection;
    procedure UpdateGrupo;
    procedure UpdatePag;
    procedure DeleteLinks(const FileName: String);
    procedure AgregarArchivos(Origen, Destino: String; OvrWrt: TOverWriteType);
    function ChangeToNSISDir(const S: String): String;
  public
    procedure GetFileList(Lst: TStrings; const Ext: String = '');
    procedure GetDirList(Lst: TStrings);
    procedure GetShortCutDirList(Lst: TStrings);
    function FirstFile(const Ext: String): String;
    procedure GenerateCode(ALines: TStrings; AScriptFile: String = '');
  end;

var
  WizardFrm: TWizardFrm;


implementation

uses UEditFile, UEditLink, Utils, UMain;

{$R *.DFM}

{
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
    WizardFrm.Free;
  end;
}

type
  TPages = (pagWelcome, pagAppInfo, pagInstOptions, pagDirectory, pagFiles,
    pagStartMenu, pagPostExec, pagUninstOptions, pagFinish);

procedure TWizardFrm.FormDestroy(Sender: TObject);
var
  C: Integer;
begin
  for C := 0 to GrupoLst.Items.Count - 1 do
    GrupoLst.Items.Objects[C].Free;
end;

function TWizardFrm.GrupoActual: TSection;
begin
  Result := nil;
  if GrupoLst.ItemIndex >= 0 then
    Result := TSection(GrupoLst.Items.Objects[GrupoLst.ItemIndex]);
end;

procedure TWizardFrm.ComentGrpChange(Sender: TObject);
begin
  if GrupoActual <> nil then
    GrupoActual.Comment := ComentGrp.Text;
end;

procedure TWizardFrm.GrupoLstClick(Sender: TObject);
var
  C: Integer;
  Grupo: TSection;
begin
  Grupo := GrupoActual;
  ComentGrp.OnChange := nil;
  if Grupo <> nil then ComentGrp.Text := Grupo.Comment;
  ComentGrp.OnChange := ComentGrpChange;

  FileLst.Items.BeginUpdate;
  try
    FileLst.Items.Clear;
    if Grupo = nil then Exit;
    for C := 0 to Grupo.Files.Count - 1 do
     with FileLst.Items.Add do
     begin
       Caption := GetFile(Grupo.Files[C]);
       SubItems.Add(GetDestDir(Grupo.Files[C]));
       SubItems.Add(IntToStr(Ord(GetOverwrite(Grupo.Files[C]))));
     end;
  finally
    FileLst.Items.EndUpdate;
  end;
end;

procedure TWizardFrm.FormCreate(Sender: TObject);
var
  Found, C: Integer;
  SR: TSearchRec;
begin
  InitFont(Font);
  
  SaveRelative := True;
  SaveComp := False;
  NeedUpdateLists := True;

  PageNameLabel.Font.Style := [fsBold];
  FinishedImage.Picture := WelcomeImage.Picture;

  Found := FindFirst(ExtractFilePath(MainFrm.Compiler) +
    'Contrib\Language files\*.nlf', faArchive, SR);
  while Found = 0 do
  begin
    LangEdt.Items.Add(ChangeFileExt(SR.Name, ''));
    Found := FindNext(SR);
  end;
  FindClose(SR);
  
  CommaListToStrList(LangStr('DefaultWizardSections'), ';', GrupoLst.Items);
  for C := 0 to GrupoLst.Items.Count - 1 do
    GrupoLst.Items.Objects[C] := TSection.Create;

  if GrupoLst.Items.Count = 0 then
    GrupoLst.Items.AddObject(LangStr('DefaultSection'), TSection.Create);

  GrupoLst.ItemIndex := 0;
  CommaListToStrList(LangStr('DefaultWizardFiles'), ';', GrupoActual.Files);
  for C := 0 to GrupoActual.Files.Count - 1 do
    GrupoActual.Files[C] := ChangeVar(GrupoActual.Files[C], '[NISEDTDIR]',
       ExtractFileDir(ParamStr(0)));
  GrupoLstClick(GrupoLst);

  LicFileEdt.Text := ChangeVar(LangStr('DefaultWizardLicFile'), '[NISEDTDIR]',
    ExtractFileDir(ParamStr(0)));

  NombreEdtChange(NombreEdt);
  NB1.PageIndex := 0;
  UpdateGrupo;
  UpdatePag;

  Caption := LangStr('WizardCaption');

  OpenLicDlg.Filter := GetLangFileFilter(['LicFileFilter', 'RTFFileFilter',
    'TextFileFilter']);
  OpenIconDlg.Filter := GetLangFileFilter(['IconFileFilter']);

  WelcomeLabel1.Caption := LangStr('WelcomeLabel1');
  WelcomeLabel2.Caption := LangStr('WelcomeLabel2');
  WelcomeLabel3.Caption := LangStr('WelcomeLabel3');
  WelcomeLabel4.Caption := LangStr('WelcomeLabel4');

  AtrasBtn.Caption := LangStr('Back');
  SiguienteBtn.Caption := LangStr('Next');
  CancelarBtn.Caption := LangStr('Cancel');

  Label1.Caption := LangStr('AppName');
  Label2.Caption := LangStr('AppVersion');
  Label3.Caption := LangStr('AppPublisher');
  Label4.Caption := LangStr('AppWeb');

  NombreEdt.Text := LangStr('DefaultAppName');
  VersionEdt.Text := LangStr('DefaultAppVersion');
  PublisherEdt.Text := LangStr('DefaultAppPublisher');
  WebEdt.Text := LangStr('DefaultAppWeb');

  Label10.Caption := LangStr('InstallIcon');
  Label11.Caption := LangStr('UninstallIcon');
  Label12.Caption := LangStr('ExeInst');
  Label5.Caption := LangStr('LangInst');
  Label15.Caption := LangStr('GUI');
  Label13.Caption := LangStr('Compress');

  CompressEdt.Items.Add(LangStr('CompressZLib'));
  CompressEdt.Items.Add(LangStr('CompressBZip2'));
  CompressEdt.Items.Add(LangStr('CompressLZMA'));
  CompressEdt.Items.Add(LangStr('CompressNone'));
  GUIEdt.Items.Add(LangStr('GUIModern'));
  GUIEdt.Items.Add(LangStr('GUIClassic'));
  GUIEdt.Items.Add(LangStr('GUINone'));
  InstIconEdt.Text := LangStr('DefaultInstallIcon');
  UninstIconEdt.Text := LangStr('DefaultUninstallIcon');
  ExeEdt.Text := LangStr('DefaultExeInst');
  LangEdt.ItemIndex := LangEdt.Items.IndexOf(LangStr('DefaultLangInst'));
  GuiEdt.ItemIndex := GUIEdt.Items.IndexOf(LangStr('DefaultGUI'));
  CompressEdt.ItemIndex := CompressEdt.Items.IndexOf(LangStr('DefaultCompress'));

  GroupBox2.Caption := LangStr('InstallDir');
  DirChk.Caption := LangStr('ChangeInstallDir');
  GroupBox1.Caption := LangStr('LicenceFile');
  LicenseForceSelectionBtns.Caption := LangStr('LicenseForceSelection');
  LicenseForceSelectionBtns1.Caption := LangStr('NoLFS');
  LicenseForceSelectionBtns2.Caption := LangStr('LFSCheckBox');
  LicenseForceSelectionBtns3.Caption := LangStr('LFSRadioButtons');
  for C := 0 to LicenseForceSelectionBtns.ControlCount - 1 do
   with TRadioButton(LicenseForceSelectionBtns.Controls[C]) do
     if Caption = LangStr('DefaultLFS') then
     begin
       Checked := True;
       Break;
     end;


  Label14.Caption := LangStr('Description');
  FileLst.Columns[0].Caption := LangStr('FileColumn');
  FileLst.Columns[1].Caption := LangStr('DirDestColumn');
  CmpChk.Caption := LangStr('SelectInstallComponents');

  GroupBox3.Caption := LangStr('StartMenuDir');
  InicioChk.Caption := LangStr('ChangeStartMenuDir');
  WebIconChk.Caption := LangStr('CreateWebIcon');
  UninstIconChk.Caption := LangStr('CreateUninstallIcon');
  IconLst.Columns[0].Caption := LangStr('FilelLnkColumn');
  IconLst.Columns[1].Caption := LangStr('LinkDestColumn');

  Label6.Caption := LangStr('ExecProgram');
  Label7.Caption := LangStr('ExecProgramParams');
  Label8.Caption := LangStr('ExecReadme');

  UseUninstChk.Caption := LangStr('UseUninstaller');
  UseUninstChk.Width := CheckWidth + Canvas.TextWidth(UseUninstChk.Caption) + 7;
  Label19.Caption := LangStr('UninstPrompt');
  Label18.Caption := LangStr('UninstSuccesMsg');
  UninstSuccesMsgEdt.Text := LangStr('DefaultUninstSuccesMsg');
  UninstPromptEdt.Text := LangStr('DefaultUninstPrompt');

  Label16.Caption := LangStr('FinishLabel1');
  Label9.Caption := LangStr('FinishLabel2');
  Label17.Caption := LangStr('FinishLabel3');

  SaveChk.Caption := LangStr('SaveScript');
  RelativeChk.Caption := LangStr('RelativePaths');
  CompChk.Caption := LangStr('CompScript');

  AssignActionText(AgregarArchivoCmd, 'AddFiles');
  AssignActionText(EditarArchivoCmd, 'EditFile');
  AssignActionText(EliminarArchivoCmd, 'DeleteFile');
  AssignActionText(NuevoGrupoCmd, 'NewGroup');
  AssignActionText(EliminarGrupoCmd, 'DeleteGroup');
  AssignActionText(EditarGrupoCmd, 'EditGroup');
  AssignActionText(AgregarLinkCmd, 'AddLink');
  AssignActionText(EliminarLinkCmd, 'DeleteLink');
  AssignActionText(EditLinkCmd, 'EditLink');
end;

const
   pagBienvenido = 0;
   pagLicencia = 1;
   pagComponentes = 2;
   pagDirectorio = 3;
   pagInicio = 4;
   pagFin = 5;


procedure TWizardFrm.ComentGrpKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then Key := #0;
end;

procedure TWizardFrm.UpdateGrupo;
var
  C: Integer;
begin
  with GrupoActual do
  begin
    Files.Clear;
    for C := 0 to FileLst.Items.Count - 1 do
      Files.Add(FileLst.Items[C].Caption + '|' +
        FileLst.Items[C].SubItems[0] + '|' + FileLst.Items[C].SubItems[1]);
  end;
end;

procedure TWizardFrm.FileLstDblClick(Sender: TObject);
begin
  EditarArchivoCmd.Execute;
end;

procedure TWizardFrm.AgregarArchivoCmdExecute(Sender: TObject);
var
  Origen, Destino: String;
  OvrWrt: TOverwriteType;
begin
  Origen := ''; Destino := '';
  OvrWrt := otIfNewer;
  if EditArchivo(Origen, Destino, OvrWrt) then
  begin
    Application.ProcessMessages;
    Screen.Cursor := crHourGlass;
    try
      AgregarArchivos(Origen, Destino, OvrWrt);
      NeedUpdateLists := True;
    finally
      Screen.Cursor := crDefault;
    end;
  end;
end;

procedure TWizardFrm.EditarArchivoCmdExecute(Sender: TObject);
var
  Origen, Destino: String;
  OvrWrt: TOverWriteType;
  SelItem: TListItem;
begin
  SelItem := FileLst.Selected;
  if SelItem <> nil then
  begin
    Origen := SelItem.Caption;
    Destino := SelItem.SubItems[0];
    OvrWrt := TOverWriteType(StrToIntDef(SelItem.SubItems[1], Ord(otIfNewer)));
    if EditArchivo(Origen, Destino, OvrWrt, False) then
    begin
       SelItem.Caption := Origen;
       SelItem.SubItems[0] := Destino;
       SelItem.SubItems[1] := IntToStr(Ord(OvrWrt));
       NeedUpdateLists := True;
       UpdateGrupo;
    end;
  end;
end;

procedure TWizardFrm.EliminarArchivoCmdExecute(Sender: TObject);
var
  SelItem: TListItem;
  I: Integer;
begin
  SelItem := FileLst.Selected;
  if SelItem <> nil then
  begin
    DeleteLinks(IncludeTrailingBackSlash(SelItem.SubItems[0]) +
      ExtractFileName(SelItem.Caption));
    I := SelItem.Index;
    SelItem.Delete;
    if I >= FileLst.Items.Count then Dec(I);
    if I in [0..FileLst.Items.Count-1] then
      FileLst.Selected := FileLst.Items[I];
    NeedUpdateLists := True;
    UpdateGrupo;
  end;
end;

procedure TWizardFrm.NuevoGrupoCmdExecute(Sender: TObject);
var
  Grupo: String;
begin
  Grupo := '';
  if InputQuery(LangStr('NewGroup'), LangStr('NewGroupPrompt'), Grupo) then
  begin
    GrupoLst.ItemIndex := GrupoLst.Items.AddObject(Grupo, TSection.Create);
    GrupoLstClick(GrupoLst);
  end;
end;

procedure TWizardFrm.EliminarGrupoCmdExecute(Sender: TObject);
var
  C, I: Integer;
  S: String;
  G: TSection;
begin
  I := GrupoLst.ItemIndex;
  if (I >= 0) and (True) then
  begin
    G := TSection(GrupoLst.Items.Objects[I]);
    for C := 0 to G.Files.Count - 1 do
    begin
      S := G.Files[C];
      DeleteLinks(IncludeTrailingBackSlash(GetDestDir(S)) +
         ExtractFileName(GetFile(S)));
    end;
    GrupoLst.Items.Objects[I].Free;
    GrupoLst.Items.Delete(I);
    if GrupoLst.Items.Count-1 < I then
       I := GrupoLst.Items.Count-1;
    GrupoLst.ItemIndex := I;
    GrupoLstClick(GrupoLst);
  end;
end;

procedure TWizardFrm.CheckGrupoIdx(Sender: TObject);
begin
  TAction(Sender).Enabled := GrupoLst.ItemIndex >= 0;
end;

procedure TWizardFrm.CheckFileSelected(Sender: TObject);
begin
  TAction(Sender).Enabled := FileLst.Selected <> nil;
end;

procedure TWizardFrm.AtrasBtnClick(Sender: TObject);
var
  X: Integer;
begin
 if NB1.PageIndex > 0 then
 begin
   X := NB1.PageIndex - 1;
   if ((GUIEdt.ItemIndex in [1,2]) and (NB1.Pages.IndexOf('PostExec') = X)) then Dec(X);
   NB1.PageIndex := X;
   UpdatePag;
 end;
end;

procedure TWizardFrm.GenerateCode(ALines: TStrings; AScriptFile: String = '');
var
  C: Integer;
begin
  with TScriptGen.Create do
  try
    AllowCodeComments := GetKeyState(VK_SHIFT) >= 0;
    
    AppName := NombreEdt.Text;
    Version := VersionEdt.Text;
    Publisher := PublisherEdt.Text;
    WebSite := WebEdt.Text;

    InstIcon := InstIconEdt.Text;
    ExeInst := ExeEdt.Text;
    Lang := LangEdt.Text;
    ModernUI := GUIEdt.ItemIndex = 0;
    Silent := GUIEdt.ItemIndex = 2;
    CompressType := TCompressionType(CompressEdt.ItemIndex);

    UseBG := False;

    InstDir := DirEdt.Text;
    AllowDirChange := DirChk.Checked;

    LicenceFile := LicFileEdt.Text;
    for C := 0 to LicenseForceSelectionBtns.Controlcount - 1 do
     with TRadioButton(LicenseForceSelectionBtns.Controls[C]) do
     if Checked then begin
       LicenseForceSelection := TLicenseForceSelection(C);
       Break;
     end;

    AssignGroups(GrupoLst.Items);
    AllowComponetSelect := CmpChk.Checked;

    StartMenuDir := GrupoEdt.Text;
    AllowSelectStartMenu := InicioChk.Checked and InicioChk.Enabled;
    CreateWebIcon := WebIconChk.Checked and WebIconChk.Enabled;
    CreateUninstallIcon := UninstIconChk.Checked;
    for C := 0 to IconLst.Items.Count - 1 do
      AddLink(IconLst.Items[C].Caption + '|' + IconLst.Items[C].SubItems[0]);

    UseUninstaller := UseUninstChk.Checked;  
    FinishRun := ProgramaEdt.Text;
    FinishParams := ParamsEdt.Text;
    FinishReadme := LeameEdt.Text;

    UninstIcon := UninstIconEdt.Text;
    UninstPrompt := UninstPromptEdt.Text;
    UninstSuccessMsg := UninstSuccesMsgEdt.Text;

    MainExe := FirstFile('.exe');
    MainExeDir := ExtractFileDir(MainExe);

    RelativeBase := AScriptFile;

    Generate(ALines);
  finally
    Free;
  end;
end;

procedure TWizardFrm.SiguienteBtnClick(Sender: TObject);

  procedure Alerta(Const S: String; Ctrl: TWinControl = nil);
  begin
    WarningDlg(LangStr(S));
    if Ctrl <> nil then Ctrl.SetFocus;
    Abort;
  end;

  procedure CheckIfAvance;
  begin
    case NB1.PageIndex of
      Ord(pagAppInfo):
      begin
        if NombreEdt.Text = '' then
          Alerta('NoAppName', NombreEdt);
        if VersionEdt.Text = '' then
          Alerta('NoVersion', VersionEdt);
       end;

      Ord(pagInstOptions):
      begin
         if ExeEdt.Text = '' then
           Alerta('NoExeInst', ExeEdt);
         if (LangEdt.ItemIndex < 0) and (LangEdt.Items.Count > 0) then
           Alerta('NoLang', LangEdt);
         if GUIEdt.ItemIndex < 0 then
           Alerta('NoGUI', GUIEdt);
         if CompressEdt.ItemIndex < 0 then
           Alerta('NoCompress', CompressEdt);
       end;

       Ord(pagDirectory):
         if DirEdt.Text = '' then
           Alerta('NoDir', DirEdt);
    end;
  end;

var
  X: Integer;
begin
  CheckIfAvance;

  if NB1.PageIndex < NB1.Pages.Count-1 then
  begin
    X := NB1.PageIndex + 1;
    if (GUIEdt.ItemIndex in [1,2]) and (NB1.Pages.IndexOf('PostExec') = X) then Inc(X);
    NB1.PageIndex := X;
    UpdatePag;
  end else
  if NB1.PageIndex = NB1.Pages.Count-1 then
  begin
    SaveDlg.FileName := '';
    if SaveChk.Checked then
    begin
      SaveDlg.Filter := GetLangFileFilter(['NSISFileFilter']);
      SaveDlg.DefaultExt := 'nsi';
      if not SaveDlg.Execute then Exit;
    end;
    ModalResult := mrOK;
  end;
end;

procedure TWizardFrm.UpdatePag;

  procedure UpdateHaveFiles;
  var
    Lst: TStrings;
  begin
    Lst := TStringList.Create;
    try
      GetFileList(Lst);
      HaveFiles := Lst.Count > 0;
    finally
      Lst.Free;
    end;
  end;

  procedure SetTitle(const MsgIdTitle, MsgIdSubTitle: String);
  begin
    PageNameLabel.Caption := LangStr(MsgIdTitle);
    PageDescriptionLabel.Caption := AddPeriod(LangStr(MsgIdSubTitle));
  end;

var
  S: String;
  C: Integer;
begin
  PnlMain.Visible := NB1.PageIndex in [1..NB1.Pages.Count-2];
  AtrasBtn.Visible := NB1.PageIndex > 0;

  SiguienteBtn.Caption := LangStr('Next');
  NB1.ParentColor := True;

  { Los 'Begin' y 'end' que parece que sobran, estan para facilitar la inclusión
    de nuevas instrucciones en el futuro. }

  case TPages(NB1.PageIndex) of
    pagWelcome:
    begin
       NB1.Color := clWindow;
    end;

    pagAppInfo:
    begin
       SetTitle('AppInfoTitle', 'AppInfoSubTitle');
    end;

    pagInstOptions:
    begin
      SetTitle('OptionsTitle', 'OptionsSubTitle');
    end;

    pagDirectory:
    begin
      SetTitle('LicenceTitle', 'LicenceSubTitle');
      DirChk.Enabled := GUIEdt.ItemIndex in [0, 1];
      SetCtrlEnabled(LicFileEdt, DirChk.Enabled);
      ExaminarLicBtn.Enabled := DirChk.Enabled;
      for C := 0 to LicenseForceSelectionBtns.ControlCount - 1 do
        LicenseForceSelectionBtns.Controls[C].Enabled := DirChk.Enabled and (LicFileEdt.Text <> '');
      if NombreEdt.Modified then
        DirEdt.Items[0] := '$PROGRAMFILES\' + NombreEdt.Text;
      NombreEdt.Modified := False;
      if DirEdt.Tag = 0 then
        DirEdt.Text := '$PROGRAMFILES\' + NombreEdt.Text;
    end;

    pagFiles:
    begin
      SetTitle('FilesTitle', 'FilesSubTitle');
      ComentGrp.Enabled := GUIEdt.ItemIndex = 0;
      ComentGrp.Color := clWindow;
      if not ComentGrp.Enabled then ComentGrp.ParentColor := True;
      CmpChk.Enabled := GUIEdt.ItemIndex in [0,1];
    end;

    pagStartMenu:
    begin
      SetTitle('IconsTitle', 'IconsSubTitle');
      WebIconChk.Enabled := WebEdt.Text <> '';
      UpdateHaveFiles;
      InicioChk.Enabled := GUIEdt.ItemIndex = 0;
      if not GrupoEdt.Modified then
        GrupoEdt.Text := NombreEdt.Text;
      if IconLst.Items.Count = 0 then
      begin
        S := FirstFile('.exe');
        if S <> '' then
        begin
          with IconLst.Items.Add do
          begin
            Caption := '$ICONS_GROUP\' + NombreEdt.Text + '.lnk';
            SubItems.Add(S);
          end;
          with IconLst.Items.Add do
          begin
            Caption := '$DESKTOP\' + NombreEdt.Text + '.lnk';
            SubItems.Add(S);
          end;
        end;
        S := FirstFile('.hlp');
        if S = '' then S := FirstFile('.chm');
        if S <> '' then
        with IconLst.Items.Add do
        begin
          Caption := '$ICONS_GROUP\Help.lnk';
          SubItems.Add(S);
        end;
      end;
    end;

    pagPostExec:
    begin
      SetTitle('ExecFinishTitle', 'ExecFinishSubTitle');
      if NeedUpdateLists then
      begin
        GetFileList(LeameEdt.Items);
        { Esta tontera es pa' ahorrar tiempo y ganar velocidad }
        ProgramaEdt.Items.Clear;
        for C := 0 to LeameEdt.Items.Count - 1 do
        begin
          S := LeameEdt.Items[C];
          if SameText(ExtractFileExt(S), '.exe') then
            ProgramaEdt.Items.Append(S);
        end;
        NeedUpdateLists := False;
      end;
      if (ProgramaEdt.Tag = 0) and (ProgramaEdt.Items.Count > 0) then
        ProgramaEdt.Text := ProgramaEdt.Items[0];
    end;

    pagUninstOptions:
    begin
      SetTitle('UninstallTitle', 'UninstallSubTitle');
    end;

    pagFinish:
    begin
      NB1.Color := clWindow;
      SiguienteBtn.Caption := LangStr('Finish');
    end;
  end;
end;

procedure TWizardFrm.ExaminarLicBtnClick(Sender: TObject);
begin
  if OpenLicDlg.Execute then
    LicFileEdt.Text := OpenLicDlg.FileName;
end;

procedure TWizardFrm.GrupoLstDblClick(Sender: TObject);
begin
  EditarGrupoCmd.Execute;
end;

procedure TWizardFrm.EliminarGrupoCmdUpdate(Sender: TObject);
begin
  EliminarGrupoCmd.Enabled := (GrupoLst.ItemIndex >= 0) and (GrupoLst.Items.Count > 1);
end;

procedure TWizardFrm.EditarGrupoCmdExecute(Sender: TObject);
var
  Grupo: String;
begin
  Grupo := GrupoLst.Items[GrupoLst.ItemIndex];
  if InputQuery(LangStr('ModifyName'), LangStr('ModifyNamePrompt'), Grupo) then
    GrupoLst.Items[GrupoLst.ItemIndex] := Grupo;
end;

procedure TWizardFrm.AgregarArchivos(Origen, Destino: String; OvrWrt: TOverWriteType);
var
  I: Integer;
  S: String;

  function Exists: Boolean;
  var
    C: Integer;
  begin
    Result := True;
    for C := 0 to FileLst.Items.Count - 1 do
      if SameText(FileLst.Items[C].Caption, S) then Exit;
    Result := False;
  end;

begin
    while Origen <> '' do
    begin
      I := AnsiPos(';', Origen);
      if I = 0 then I := Length(Origen)+1;
      S := Copy(Origen, 1, I-1);
      System.Delete(Origen, 1, I);
      if not Exists then
      with FileLst.Items.Add do
      begin
        Caption := S;
        SubItems.Add(Destino);
        SubItems.Add(IntToStr(Ord(OvrWrt)));
      end;
    end;
    UpdateGrupo;
end;

procedure TWizardFrm.AgregarLinkCmdExecute(Sender: TObject);
var
  Link, Destino: String;
begin
  if EditLink(Link, Destino) then
  begin
    with IconLst.Items.Add do
    begin
      Caption := Link;
      SubItems.Add(Destino);
    end;
  end;
end;

procedure TWizardFrm.EliminarLinkCmdUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := IconLst.Selected <> nil;
end;

procedure TWizardFrm.EliminarLinkCmdExecute(Sender: TObject);
var
  Item: TListItem;
  I: Integer;
begin
  Item := IconLst.Selected;
  if Item <> nil then
  begin
    I := Item.Index;
    Item.Delete;
    if I >= IconLst.Items.Count then Dec(I);
    if I in [0..IconLst.Items.Count-1] then
      IconLst.Selected := IconLst.Items[I];
  end;
end;

procedure TWizardFrm.GetFileList(Lst: TStrings; const Ext: String = '');
var
  C, I: Integer;
  FileName: String;
begin
  Lst.BeginUpdate;
  try
    Lst.Clear;
    for C := 0 to Grupolst.Items.Count - 1 do
    with TSection(Grupolst.Items.Objects[C]) do
      for I := 0 to Files.Count - 1 do
      begin
        FileName := ExtractFileName(GetFile(Files[I]));
        if (Ext <> '') and (not SameText(ExtractFileExt(FileName), Ext)) then
          Continue;
        Lst.Add(IncludeTrailingBackSlash(GetDestDir(Files[I])) + FileName);
      end;
  finally
    Lst.EndUpdate;
  end;
end;

procedure TWizardFrm.EditLinkCmdExecute(Sender: TObject);
var
  Link, Destino: String;
begin
  Link := IconLst.Selected.Caption;
  Destino := IconLst.Selected.SubItems[0];
  if EditLink(Link, Destino) then
  begin
    IconLst.Selected.Caption := Link;
    IconLst.Selected.SubItems[0] := Destino;
  end;
end;

procedure TWizardFrm.IconLstDblClick(Sender: TObject);
begin
  EditLinkCmd.Execute;
end;

function TWizardFrm.FirstFile(const Ext: String): String;
var
  Lst: TStrings;
begin
  Lst := TStringList.Create;
  try
    GetFileList(Lst, Ext);
    if Lst.Count > 0 then
      Result := Lst[0]
    else
      Result := '';
  finally
    Lst.Free;
  end;
end;

procedure TWizardFrm.Button1Click(Sender: TObject);
begin
  OpenIconDlg.FileName := '';
  if OpenIconDlg.Execute then
    InstIconEdt.Text := ChangeToNSISDir(OpenIconDlg.FileName);
end;

procedure TWizardFrm.BUIBtnClick(Sender: TObject);
begin
  OpenIconDlg.FileName := '';
  if OpenIconDlg.Execute then
    UnInstIconEdt.Text := ChangeToNSISDir(OpenIconDlg.FileName);
end;

procedure TWizardFrm.Button3Click(Sender: TObject);
begin
  SaveDlg.Filter := GetLangFileFilter(['ExeFileFilter']);
  SaveDlg.DefaultExt := 'exe';
  If SaveDlg.Execute then
    ExeEdt.Text := SaveDlg.FileName;
end;

procedure TWizardFrm.DeleteLinks(const FileName: String);
var
  C: Integer;
begin
  C := 0;
  while C < IconLst.Items.Count do
  begin
    if SameText(IconLst.Items[C].SubItems[0], FileName) then
      IconLst.Items[C].Delete
    else
      Inc(C);
  end;
end;

procedure TWizardFrm.AgregarLinkCmdUpdate(Sender: TObject);
begin
  AgregarLinkCmd.Enabled := HaveFiles;
end;

procedure AddDefaultStrings(Lst: TStrings; const DefaultStrings: String);
var
  C: Integer;
  S: String;
begin
  with TStringList.Create do
  try
    Text := DefaultStrings;
    for C := 0 to Count - 1 do
    begin
      S := Strings[C];
      if (S <> '') and (Lst.IndexOf(S) < 0) then Lst.Add(S);
    end;
  finally
    Free;
  end;
end;

procedure TWizardFrm.GetDirList(Lst: TStrings);
var
  C, I: Integer;
  S: String;
begin
  Lst.BeginUpdate;
  try
    for C := 0 to Grupolst.Items.Count - 1 do
    with TSection(Grupolst.Items.Objects[C]) do
    for I := 0 to Files.Count - 1 do
    begin
      S := GetDestDir(Files[I]);
      if (S <> '') and (Lst.IndexOf(S) < 0) then Lst.Add(S);
    end;
    AddDefaultStrings(Lst, SDirs);
  finally
    Lst.EndUpdate;
  end;
end;

procedure TWizardFrm.GetShortCutDirList(Lst: TStrings);
var
  C: Integer;
  S: String;
begin
  Lst.BeginUpdate;
  try
    for C := 0 to IconLst.Items.Count - 1 do
    begin
      S := ExtractFileDir(IconLst.Items[C].Caption);
      if (S <> '') and (Lst.IndexOf(S) < 0) then Lst.Add(S);
    end;
    AddDefaultStrings(Lst, SShortCutDirs);
  finally
    Lst.EndUpdate;
  end;
end;

function TWizardFrm.ChangeToNSISDir(const S: String): String;
var
  S2, S3: String;
begin
  S2 := ExtractFileDir(MainFrm.Compiler);
  S3 := Copy(S, 1, Length(S2));
  if SameText(S2, S3) then
    Result := ChangeVar(S, S3, '${NSISDIR}')
  else
    Result := S;
end;

procedure TWizardFrm.SaveChkClick(Sender: TObject);
begin
   RelativeChk.Enabled := SaveChk.Checked;
   CompChk.Enabled := SaveChk.Checked;

   if RelativeChk.Enabled then
     RelativeChk.Checked := SaveRelative else
   begin
     SaveRelative := RelativeChk.Checked;
     RelativeChk.Checked := False;
   end;

   if CompChk.Enabled then
     CompChk.Checked := SaveComp else
   begin
     SaveComp := CompChk.Checked;
     CompChk.Checked := False;
   end;
end;

procedure TWizardFrm.SetTag(Sender: TObject);
begin
  TComponent(Sender).Tag := 1;
end;

procedure TWizardFrm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
   if ModalResult = mrCancel then
     CanClose := QuestionDlg(LangStr('ExitWizardPrompt')) = mrYes;
end;

procedure TWizardFrm.NombreEdtChange(Sender: TObject);
begin
  NombreEdt.Modified := True;
end;

procedure TWizardFrm.GrupoLstDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  X := GrupoLst.ItemAtPos(Point(X, Y), True);
  Y := GrupoLst.ItemIndex;
  Accept := (GrupoLst = Source) and (X > -1) and (Y > -1) and (X <> Y);
end;

procedure TWizardFrm.GrupoLstDragDrop(Sender, Source: TObject; X,
  Y: Integer);
begin
   X := GrupoLst.ItemAtPos(Point(X, Y), True);
   GrupoLst.Items.Move(GrupoLst.ItemIndex, X);
   GrupoLst.ItemIndex := X;
   GrupoLstClick(GrupoLst);
   NeedUpdateLists := True;
end;

procedure TWizardFrm.LicFileEdtChange(Sender: TObject);
var
  C: Integer;
begin
  for C := 0 to LicenseForceSelectionBtns.ControlCount - 1 do
    LicenseForceSelectionBtns.Controls[C].Enabled := LicFileEdt.Text <> '';
end;

procedure TWizardFrm.UseUninstChkClick(Sender: TObject);
begin
   SetCtrlEnabled(UninstPromptEdt, UseUninstChk.Checked);
   SetCtrlEnabled(UninstSuccesMsgEdt, UseUninstChk.Checked);
   SetCtrlEnabled(UninstIconEdt, UseUninstChk.Checked);
   BUIBtn.Enabled := UseUninstChk.Checked;
   Label19.Enabled := UseUninstChk.Checked;
   Label18.Enabled := UseUninstChk.Checked;
   Label11.Enabled := UseUninstChk.Checked;
end;

end.
