{
  HM NIS Edit (c) 2003 Héctor Mauricio Rodríguez Segura <ranametal@users.sourceforge.net>
  For conditions of distribution and use, see license.txt

  Wizard edit file form

}
unit UEditFile;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ScriptGen, NewGroupBox;

type
  TEditFileFrm = class(TForm)
    Label1: TStaticText;
    OrigenEdt: TEdit;
    Button1: TButton;
    Label2: TStaticText;
    DestinoEdt: TComboBox;
    Button2: TButton;
    Button3: TButton;
    AbrirDlg: TOpenDialog;
    NewGroupBox1: TNewGroupBox;
    OverwriteChk: TComboBox;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

{var
  EditFileFrm: TEditFileFrm;}

function EditArchivo(var Origen, Destino: String; var Overwrite: TOverwriteType;
  MultiSelect: Boolean = True): Boolean;
implementation

uses UWizard, Utils;

{$R *.DFM}

function EditArchivo(var Origen, Destino: String; var Overwrite: TOverwriteType;
  MultiSelect: Boolean = True): Boolean;
begin
  with TEditFileFrm.Create(Application) do
  try
    OrigenEdt.Text := Origen;
    DestinoEdt.Text := Destino;
    if DestinoEdt.Text = '' then DestinoEdt.Text := '$INSTDIR';
    OverwriteChk.ItemIndex := Ord(OverWrite)-1;
    if MultiSelect then
      AbrirDlg.Options := AbrirDlg.Options + [ofAllowMultiSelect]
    else
      AbrirDlg.Options := AbrirDlg.Options - [ofAllowMultiSelect];
    Result := ShowModal = mrOK;
    if Result then
    begin
      Origen := OrigenEdt.Text;
      Destino := DestinoEdt.Text;
      Overwrite := TOverwriteType(OverwriteChk.ItemIndex+1);
    end;
  finally
    Free;
  end;
end;

procedure TEditFileFrm.Button1Click(Sender: TObject);
var
  C :Integer;
  S: String;
begin
  if AbrirDlg.Execute then
  begin
    S := '';
    for C := AbrirDlg.Files.Count - 1 downto 0 do
      S := S + AbrirDlg.Files[C] + ';';
    if (S <> '') and (AnsiLastChar(S)^ = ';') then
      SetLength(S, Length(S)-1);
    OrigenEdt.Text := S;
  end;
end;

procedure TEditFileFrm.FormCreate(Sender: TObject);
begin
  InitFont(Font);
  if WizardFrm <> nil then
    WizardFrm.GetDirList(DestinoEdt.Items);
  Caption := LangStr('EditFileCaption');
  Label1.Caption := LangStr('OrgDile');
  Label2.Caption := LangStr('DirDest');
  Button3.Caption := LangStr('OK');
  Button2.Caption := LangStr('Cancel');
  NewGroupBox1.Caption := LangStr('IfFileExists');
  OverwriteChk.Items.Add(LangStr('OverwriteOn'));
  OverwriteChk.Items.Add(LangStr('OverwriteOff'));
  OverwriteChk.Items.Add(LangStr('OverwriteTry'));
  OverwriteChk.Items.Add(LangStr('OverwriteIfNewer'));
  AbrirDlg.Filter := LangStr('AllFileFilter');
end;

end.
