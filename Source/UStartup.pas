{
  HM NIS Edit (c) 2003 Héctor Mauricio Rodríguez Segura <ranametal@users.sourceforge.net>
  For conditions of distribution and use, see license.txt

  Startup Form code

}
unit UStartup;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, NewGroupBox;

type
  TStartupFrm = class(TForm)
    AceptarBtn: TButton;
    CancelarBtn: TButton;
    GroupBox1: TNewGroupBox;
    GroupBox2: TNewGroupBox;
    EmptyChk: TRadioButton;
    WizardChk: TRadioButton;
    OpenChk: TRadioButton;
    FilesLst: TListBox;
    StartupChk: TCheckBox;
    NewImage: TImage;
    OpenImage: TImage;
    procedure RadioButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DblClickChk(Sender: TObject);
    procedure FilesLstClick(Sender: TObject);
  private
  public
  end;

implementation

uses Utils, UMain;

{$R *.DFM}


procedure TStartupFrm.FormCreate(Sender: TObject);
begin
  InitFont(Font);
  FilesLst.Items.Add(LangStr('MoreFiles'));
  Caption := LangStr('StartupCaption');
  GroupBox1.Caption := LangStr('NewFile');
  GroupBox2.Caption := LangStr('OpenFile');
  EmptyChk.Caption := LangStr('EmptyScript');
  WizardChk.Caption := LangStr('WizardScript');
  OpenChk.Caption := LangStr('OpenExistingFile');
  StartupChk.Caption := LangStr('NoShowSartup');
  AceptarBtn.Caption := LangStr('OK');
  CancelarBtn.Caption := LangStr('Cancel');
  RadioButtonClick(OpenChk);
end;

procedure TStartupFrm.RadioButtonClick(Sender: TObject);
begin
  EmptyChk.Checked := Sender = EmptyChk;
  WizardChk.Checked := Sender = WizardChk;
  OpenChk.Checked := Sender = OpenChk;
  Fileslst.Enabled := Sender = OpenChk;
end;

procedure TStartupFrm.DblClickChk(Sender: TObject);
begin
  if AceptarBtn.Enabled then
    AceptarBtn.Click;
end;

procedure TStartupFrm.FilesLstClick(Sender: TObject);
begin
  if FilesLst.SelCount > 1 then
    FilesLst.Selected[0] := False;
end;

end.
