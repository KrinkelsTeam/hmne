{
  HM NIS Edit (c) 2003 Héctor Mauricio Rodríguez Segura <ranametal@users.sourceforge.net>
  For conditions of distribution and use, see license.txt

  About Box code

}
unit UAcerca;
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Credits;

type
  TAboutFrm = class(TForm)
    Button1: TButton;
    Bevel1: TBevel;
    Label5: TStaticText;
    Label6: TStaticText;
    VersionLbl: TStaticText;
    Panel1: TPanel;
    Image1: TImage;
    Label7: TStaticText;
    Label3: TStaticText;
    ScrollingCredits1: TScrollingCredits;
  private
    { Private declarations }
  public
    constructor Create(AOwner: TComponent); override;
  end;

implementation
uses ShellAPI, Registry, UMain, Utils;
{$R *.DFM}

constructor TAboutFrm.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  InitFont(Font);
  Label7.Caption := AppName + ' ' + AppVersion;
  Label3.Caption := AppCopyrigh;
  Button1.Caption := LangStr('OK');
  Caption := LangStr('AboutBoxCaption');
  if MainFrm.GetNSISVersion <> '' then
    VersionLbl.Caption := 'NSIS ' + MainFrm.GetNSISVersion + ' '
  else
    VersionLbl.Caption := '';
end;

end.
