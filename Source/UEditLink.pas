{
  HM NIS Edit (c) 2003 Héctor Mauricio Rodríguez Segura <ranametal@users.sourceforge.net>
  For conditions of distribution and use, see license.txt

  Wizard edit link form

}
unit UEditLink;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TEditLinkFrm = class(TForm)
    Label1: TStaticText;
    LinkEdt: TComboBox;
    Label2: TStaticText;
    DestinoEdt: TComboBox;
    Button1: TButton;
    Button2: TButton;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure DestinoEdtChange(Sender: TObject);
    procedure LinkEdtChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


function EditLink(var Lnk, Dest: String): Boolean;
implementation

uses UWizard, ScriptGen, Utils;

{$R *.DFM}

function EditLink(var Lnk, Dest: String): Boolean;
begin
  with TEditLinkFrm.Create(Application) do
  try
    WizardFrm.GetFileList(DestinoEdt.Items);
    WizardFrm.GetShortCutDirList(LinkEdt.Items);
    DestinoEdt.ItemIndex := DestinoEdt.Items.IndexOf(Dest);
    LinkEdt.Text := Lnk;
    Result := ShowModal = mrOk;
    if Result then
    begin
      Dest := DestinoEdt.Items[DestinoEdt.ItemIndex];
      Lnk := LinkEdt.Text;
    end;
  finally
    Free;
  end;
end;

procedure TEditLinkFrm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if ModalResult = mrOK then
  begin
    CanClose := LinkEdt.Text <>'';
    if not CanClose then
      WarningDlg(LangStr('NoLinkName'));
  end;
end;

procedure TEditLinkFrm.FormCreate(Sender: TObject);
begin
  InitFont(Font);
  Caption := LangStr('EditLinkCaption');
  Label1.Caption := LangStr('ShortCut');
  Label2.Caption := LangStr('Dest');
  Button2.Caption := LangStr('OK');
  Button1.Caption := LangStr('Cancel');
end;

procedure TEditLinkFrm.DestinoEdtChange(Sender: TObject);
begin
  if (LinkEdt.Text = '') and (LinkEdt.Tag = 0) then
  begin
    LinkEdt.Text := '$ICONS_GROUP\' + ExtractFileName(ChangeFileExt(DestinoEdt.Text, '.lnk'));
    LinkEdt.Tag := 0;
  end;
end;

procedure TEditLinkFrm.LinkEdtChange(Sender: TObject);
begin
  LinkEdt.Tag := 1;
  if LinkEdt.Text = '' then
    LinkEdt.Tag := 0;
end;

end.
