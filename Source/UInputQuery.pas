{
  HM NIS Edit (c) 2003 Héctor Mauricio Rodríguez Segura <ranametal@users.sourceforge.net>
  For conditions of distribution and use, see license.txt

  Input Query form
}
unit UInputQuery;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TInputQueryFrm = class(TForm)
    Label1: TStaticText;
    Edit1: TEdit;
    Button1: TButton;
    Button2: TButton;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

{var
  InputQueryFrm: TInputQueryFrm;}

implementation

uses Utils;

{$R *.DFM}

procedure TInputQueryFrm.FormCreate(Sender: TObject);
begin
  InitFont(Font);
  Button2.Caption := LangStr('OK');
  Button1.Caption := LangStr('Cancel');
end;

end.
