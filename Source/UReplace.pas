{
  HM NIS Edit (c) 2003 Héctor Mauricio Rodríguez Segura <ranametal@users.sourceforge.net>
  For conditions of distribution and use, see license.txt

  Replace text form

}
unit UReplace;                                              

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  USearch, StdCtrls, ExtCtrls, NewGroupBox;

type
  TReplaceFrm = class(TSearchFrm)
    GroupBox2: TNewGroupBox;
    ReplaceEdt: TComboBox;
    ReplaceAllBtn: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

{var
  ReplaceFrm: TReplaceFrm;}
var
  LastReplaceText: String = '';


implementation

uses Utils;

{$R *.DFM}

var
  ReplaceHistory: TStrings;


procedure LoadReplaceOptions;
begin
  if ReplaceHistory <> nil then Exit;
  ReplaceHistory := TStringList.Create;
  ReplaceHistory.CommaText := OptionsIni.ReadString('State', 'ReplaceHistory', '');
end;

procedure SaveReplaceOptions;
begin
  if ReplaceHistory = nil then Exit;
  OptionsIni.WriteString('State', 'ReplaceHistory', ReplaceHistory.CommaText);
  ReplaceHistory.Free;
end;

procedure TReplaceFrm.FormCreate(Sender: TObject);
begin
  inherited;
  Caption := LangStr('ReplaceTextCaption');
  GroupBox2.Caption := LangStr('ReplaceText');
  ReplaceEdt.Text := LastReplaceText;
  ReplaceAllBtn.Caption := LangStr('ReplaceAll');
  LoadReplaceOptions;
  ReplaceEdt.Items.Assign(ReplaceHistory);
end;

procedure TReplaceFrm.FormDestroy(Sender: TObject);
var
  I: Integer;
begin
  inherited;
  if ModalResult in [mrOK, mrReplaceAll] then
  begin
    LastReplaceText := ReplaceEdt.Text;
    if LastReplaceText <> '' then
    begin
      I := ReplaceHistory.IndexOf(LastReplaceText);
      if  I < 0  then
        ReplaceHistory.Insert(0, LastReplaceText)
      else
        ReplaceHistory.Move(I, 0);
      while ReplaceHistory.Count > 20 do
        ReplaceHistory.Delete(ReplaceHistory.Count - 1);
    end;
  end;
end;

initialization
finalization
  try SaveReplaceOptions except end;
end.
