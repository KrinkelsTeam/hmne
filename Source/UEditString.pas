{
  HM NIS Edit (c) 2003 Héctor Mauricio Rodríguez Segura <ranametal@users.sourceforge.net>
  For conditions of distribution and use, see license.txt

  String list editor form
}
unit UEditString;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, PropEditors;

type
  TEditStringsFrm = class(TForm)
    Edit: TMemo;
    AceptarBtn: TButton;
    CancelarBtn: TButton;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function EditLines(Lines: TStrings; const DlgCaption: String): Boolean;
implementation

uses Utils;

{$R *.DFM}

function EditLines(Lines: TStrings; const DlgCaption: String): Boolean;
begin
  with TEditStringsFrm.Create(Application) do
  try
    Caption := LangStr(DlgCaption);
    Edit.Lines.Assign(Lines);
    Result := ShowModal = mrOk;
    if Result then
      Lines.Assign(Edit.Lines);
  finally
    Free;
  end;
end;                                                        

{ TEditStringsFrm }

procedure TEditStringsFrm.FormCreate(Sender: TObject);
begin
  InitFont(Font);
  AceptarBtn.Caption := LangStr('OK');
  CancelarBtn.Caption := LangStr('Cancel');
end;

end.
