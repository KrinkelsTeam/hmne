unit UIOTabOrder;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, NewGroupBox, UIODesigner;

type
  TIOTabOrderFrm = class(TForm)
    NewGroupBox1: TNewGroupBox;
    ControlList: TListBox;
    AceptarBtn: TButton;
    CancelarBtn: TButton;
    UpBtn: TButton;
    DownBtn: TButton;
    procedure FormCreate(Sender: TObject);
    procedure ControlListDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure ControlListDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure UpBtnClick(Sender: TObject);
    procedure DownBtnClick(Sender: TObject);
  private
    FForm: TIODesignerFrm;
  public
    { Public declarations }
  end;

var
  IOTabOrderFrm: TIOTabOrderFrm;

function SetIOTabOrder(Form: TIODesignerFrm): Boolean;
implementation

uses Utils, IOControls;

{$R *.DFM}

function SetIOTabOrder(Form: TIODesignerFrm): Boolean;
var
  C: Integer;
begin
  IOTabOrderFrm := TIOTabOrderFrm.Create(Application);
  try
    Form.DesignPanel.GetControlList(IOTabOrderFrm.ControlList.Items);
    UpdateHorizontalExtent(IOTabOrderFrm.ControlList);
    IOTabOrderFrm.FForm := Form;
    if IOTabOrderFrm.ControlList.Items.Count > 0 then
      IOTabOrderFrm.ControlList.ItemIndex := 0;
    Result := IOTabOrderFrm.ShowModal = mrOK;
    if Result then
    begin
      for C := 0 to IOTabOrderFrm.ControlList.Items.Count - 1 do
        TIOControl(IOTabOrderFrm.ControlList.Items.Objects[C]).SetFieldNum(C + 1);
      Form.Modified := True;
    end;
  finally
    FreeAndNil(IOTabOrderFrm);
  end;
end;

procedure TIOTabOrderFrm.FormCreate(Sender: TObject);
begin
  InitFont(Font);
  Caption := LangStr('TabOrderCaption');
  AceptarBtn.Caption := LangStr('OK');
  CancelarBtn.Caption := LangStr('Cancel');
  UpBtn.Caption := LangStr('Up');
  DownBtn.Caption := LangStr('Down');
end;

procedure TIOTabOrderFrm.ControlListDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  X := ControlList.ItemAtPos(Point(X, Y), True);
  Y := ControlList.ItemIndex;
  Accept := (ControlList = Source) and (X > -1) and (Y > -1) and (X <> Y);
end;

procedure TIOTabOrderFrm.ControlListDragDrop(Sender, Source: TObject; X,
  Y: Integer);
begin
   X := ControlList.ItemAtPos(Point(X, Y), True);
   ControlList.Items.Move(ControlList.ItemIndex, X);
   ControlList.ItemIndex := X;
end;

procedure TIOTabOrderFrm.UpBtnClick(Sender: TObject);
var
  I: Integer;
begin
  I := ControlList.ItemIndex;
  if I > 0 then
  begin
    ControlList.Items.Move(I, I - 1);
    ControlList.ItemIndex := I - 1;
  end;
end;

procedure TIOTabOrderFrm.DownBtnClick(Sender: TObject);
var
  I: Integer;
begin
  I := ControlList.ItemIndex;
  if (I >= 0) and (I + 1 < ControlList.Items.Count) then
  begin
    ControlList.Items.Move(I, I + 1);
    ControlList.ItemIndex := I + 1;
  end;
end;

end.
