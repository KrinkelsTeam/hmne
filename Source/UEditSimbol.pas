{
  HM NIS Edit (c) 2003 Héctor Mauricio Rodríguez Segura <ranametal@users.sourceforge.net>
  For conditions of distribution and use, see license.txt

  Config edit simbol form
}
unit UEditSimbol;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TEditSimbolFrm = class(TForm)
    Label1: TStaticText;
    SimbEdt: TEdit;
    Label2: TStaticText;
    ValEdt: TEdit;
    Button1: TButton;
    Button2: TButton;
    Bevel1: TBevel;
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
  public
    procedure LoadStrings(const ACaption, ALabel1, ALabel2: String);
  end;

{var
  EditSimbolFrm: TEditSimbolFrm;}

function EditSimbol(var Simbol, Val: String): Boolean;
implementation

uses Utils, UConfig;

{$R *.DFM}

function EditSimbol(var Simbol, Val: String): Boolean;
begin
  with TEditSimbolFrm.Create(Application) do
  try
    LoadStrings('EditSimbolCaption', 'Simbol', 'Value');
    SimbEdt.Text := Simbol;
    ValEdt.Text := Val;
    Result := ShowModal = mrOK;
    if Result then
    begin
      Simbol := SimbEdt.Text;
      Val := ValEdt.Text;
    end;
  finally
    Free;
  end;
end;

procedure TEditSimbolFrm.FormCreate(Sender: TObject);
begin
   InitFont(Font);
   Button2.Caption := LangStr('OK');
   Button1.Caption := LangStr('Cancel');
end;

procedure TEditSimbolFrm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);

   function YaExiste: Boolean;
   var
     C: Integer;
   begin
     Result := True;
     for C := 0 to ConfigFrm.SimbLst.Items.Count - 1 do
       if AnsiSameText(ConfigFrm.SimbLst.Items[C].Caption, SimbEdt.Text) and
       (ConfigFrm.AddingSymbol or (ConfigFrm.SimbLst.Items[C] <> ConfigFrm.SimbLst.Selected)) then Exit;
     Result := False;
   end;

   procedure Error(const LangStrId: String);
   begin
      WarningDlg(LangStr(LangStrId));
      SimbEdt.SetFocus;
      Abort;
   end;

begin
  if ModalResult = mrOK then
  begin
    if SimbEdt.Text = '' then Error('NoSymbolName');
    if AnsiPos(' ', SimbEdt.Text) > 0 then Error('NoSymbolSpaces');
    if YaExiste then Error('DuplicateSymbol');
  end;
end;

procedure TEditSimbolFrm.LoadStrings(const ACaption, ALabel1,
  ALabel2: String);
begin                 
   Caption := LangStr(ACaption);
   Label1.Caption := LangStr(ALabel1);
   Label2.Caption := LangStr(ALabel2);
end;

end.
