unit NewGroupBox;

interface

uses
  Classes, Controls, ComCtrls;

type
  TNewGroupBox = class(TWinControl)
  private
    //FAddTrailingSpaces: Boolean;
    function GetCaption: TCaption;
    procedure SetCaption(Value: TCaption);
  protected
    procedure CreateParams(var Params: TCreateParams); override;
  public
    constructor Create(AOwner: TComponent); override;
    //property AddTrailingSpaces: Boolean read FAddTrailingSpaces write FAddTrailingSpaces;
  published
    property Align;
    property Anchors;
    property BiDiMode;
    property Caption: TCaption read GetCaption write SetCaption;
    property Color;
    property Constraints;
    property Ctl3D;
    property DockSite;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDockDrop;
    property OnDockOver;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnGetSiteInfo;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDock;
    property OnStartDrag;
    property OnUnDock;
  end;

procedure Register;
implementation

uses
  Windows, CommCtrl;

procedure Register;
begin
  RegisterComponents('HM NIS Edit', [TNewGroupBox]);
end;


{ TNewGroupBox }

constructor TNewGroupBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := [csAcceptsControls, csSetCaption];
  //FAddTrailingSpaces := True;
  Width := 185;
  Height := 105;
end;

procedure TNewGroupBox.CreateParams(var Params: TCreateParams);
begin 
  inherited CreateParams(Params);
  CreateSubClass(Params, 'BUTTON');
  Params.Style := Params.Style or BS_GROUPBOX;
end;

function TNewGroupBox.GetCaption: TCaption;
begin
  Result := inherited Caption;
end;

procedure TNewGroupBox.SetCaption(Value: TCaption);
begin
  if Value <> '' then
  begin
    if (Value[1] = '"') and (Value[Length(Value)] = '"') then
    begin
      Delete(Value, 1, 1);
      SetLength(Value, Length(Value) - 1);
    end;
    //if FAddTrailingSpaces then Value := ' ' + Value + ' ';
  end;
  inherited Caption := Value;
end;

end.
