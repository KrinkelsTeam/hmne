{
  HM NIS Edit (c) 2003 Héctor Mauricio Rodríguez Segura <ranametal@users.sourceforge.net>
  For conditions of distribution and use, see license.txt

  Instal Options controls property editors

}
unit PropEditors;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DsgnIntf, StdCtrls, ExtCtrls;

type
  TFlagsStringProperty = class(TStringProperty)
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
  end;

  TListItemsProperty = class(TStringProperty)
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
  end;

  TFilterStringProperty = class(TStringProperty)
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
  end;

  TTxtColorStringProperty = class(TStringProperty)
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
  end;

  TTextStringProperty = class(TStringProperty)
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
  end;

  TFieldNumProperty = class(TIntegerProperty)
  public
    procedure GetValues(Proc: TGetStrProc); override;
    function GetAttributes: TPropertyAttributes; override;
  end;

implementation

uses UMain, Utils, TypInfo, UEditString, UFilter, IOControls, TBX;

{ TFlagsStringProperty }

procedure TFlagsStringProperty.Edit;
var
  C: Integer;
  Item: TTBXItem;
  Ctrl: TIOControl;
  FlagsList: TStrings;
begin
  MainFrm.IOCtrlFlagsPopup.Items.Clear;
  FlagsList := TStringList.Create;
  try
    Ctrl := TIOControlProperties(GetComponent(0)).Control;
    Ctrl.GetValidFlags(FlagsList);
    for C := 0 to FlagsList.Count - 1 do
    begin
      Item := TTBXItem.Create(MainFrm);
      Item.Caption := FlagsList[C];
      Item.Checked := Ctrl.HaveFlag(Item.Caption);
      Item.OnClick := MainFrm.FlagsPopupItemClick;
      MainFrm.IOCtrlFlagsPopup.Items.Add(Item);
    end;
  finally
    FlagsList.Free;
  end;
  with Mouse.CursorPos do MainFrm.IOCtrlFlagsPopup.Popup(X, Y);
{ ;

  for C := 0 to FlagsPopup.Items.Count - 1 do
  with FlagsPopup.Items[C] do
  begin
    S := FlagsEdt.Text;
    Visible := TCtrlFlags(Tag) in ValidCtrlFlags[CurrentDesignPanel.ControlType];
    Checked := Visible and CurrentDesignPanel.HaveFlag(Caption);
  end;}
end;

function TFlagsStringProperty.GetAttributes: TPropertyAttributes;
begin
  Result := inherited GetAttributes + [paDialog];
end;

{ TListItemsProperty }

procedure TListItemsProperty.Edit;
var
  Lines: TStrings;
begin
  Lines := TStringList.Create;
  try
    CommaListToStrList(GetValue, '|', Lines);
    if EditLines(Lines, 'EditListItemsCaption') then
      SetValue(StrListToCommaList(Lines, '|'));
  finally
    Lines.Free;
  end;
end;

function TListItemsProperty.GetAttributes: TPropertyAttributes;
begin
  Result := inherited GetAttributes + [paDialog];
end;

{ TFilterStringProperty }

procedure TFilterStringProperty.Edit;
var
  S: String;
begin
  S := GetValue;
  if EditFilter(S) then
    SetValue(S);
end;

function TFilterStringProperty.GetAttributes: TPropertyAttributes;
begin
  Result := inherited GetAttributes + [paDialog];
end;

{ TTxtColorString }

procedure TTxtColorStringProperty.Edit;
var
  S: String;
begin
  with TColorDialog.Create(Application) do
  try
    S := GetValue;
    if Length(S) > 2 then
      Color := TColor(StrToIntDef('$' + Copy(S, 3, 8), 0));
    if Execute then
      SetValue('0x' + IntToHex(Color, 6));
  finally
    Free;
  end;
end;

function TTxtColorStringProperty.GetAttributes: TPropertyAttributes;
begin
  Result := inherited GetAttributes + [paDialog];
end;

{ TTextStringProperty }

procedure TTextStringProperty.Edit;
var
  Strs: TStrings;
begin
  Strs := TStringList.Create;
  try
    Strs.Text := ConvertNewLines(GetValue);
    if EditLines(Strs, 'EditTextCaption') then
      SetValue(ConvertNewLines(TrimRight(Strs.Text), False));
  finally
    Strs.Free;
  end;
end;

function TTextStringProperty.GetAttributes: TPropertyAttributes;
begin
  Result := inherited GetAttributes + [paDialog];
end;

{ TFieldNumProperty }

function TFieldNumProperty.GetAttributes: TPropertyAttributes;
begin
  Result := inherited GetAttributes + [paValueList];
end;

procedure TFieldNumProperty.GetValues(Proc: TGetStrProc);
var
  Ctrl: TWinControl;
  C, I: Integer;
begin
  Ctrl := TIOControlProperties(GetComponent(0)).Control.Parent;
  I := 0;
  for C := 0 to Ctrl.ControlCount - 1 do
    if Ctrl.Controls[C] is TIOControl then
    begin
      Inc(I);
      Proc(IntToStr(I));
    end;
end;

initialization
  RegisterPropertyEditor(TypeInfo(TFlagsString), nil, '', TFlagsStringProperty);
  RegisterPropertyEditor(TypeInfo(TListItemsString), nil, '', TListItemsProperty);
  RegisterPropertyEditor(TypeInfo(TFilterString), nil, '', TFilterStringProperty);
  RegisterPropertyEditor(TypeInfo(TTxtColorString), nil, '', TTxtColorStringProperty);
  RegisterPropertyEditor(TypeInfo(TTextString), TLabelProperties, '', TTextStringProperty);
  RegisterPropertyEditor(TypeInfo(TStateString), TTextProperties, '', TTextStringProperty);
  RegisterPropertyEditor(TypeInfo(TFieldNum), nil, '', TFieldNumProperty);
end.
