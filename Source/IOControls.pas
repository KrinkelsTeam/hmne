{
  HM NIS Edit (c) 2003 Héctor Mauricio Rodríguez Segura <ranametal@users.sourceforge.net>
  For conditions of distribution and use, see license.txt

  Instal Options controls design classes

}
unit IOControls;

interface
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  StdCtrls, ExtCtrls, IniFiles, NewGroupBox;

type
  TFlagsString = type String;
  TListItemsString = type String;
  TFilterString = type String;
  TTextString = type String;
  TStateString = type String;
  TTxtColorString = type String;
  TFieldNum = type Cardinal;

  TControlType = (ctLabel, ctText, ctPassword, ctCombobox, ctDropList,
    ctListbox, ctCheckBox, ctRadioButton, ctFileRequest, ctDirRequest,
      ctIcon, ctBitmap, ctGroupBox, ctLink, ctButton);

const
  ControlNames: array[TControlType] of String =
    ('Label', 'Text', 'Password', 'Combobox', 'DropList', 'Listbox', 'CheckBox',
      'RadioButton', 'FileRequest', 'DirRequest', 'Icon', 'Bitmap', 'GroupBox',
      'Link', 'Button');

  RequestButtonWidth = 15;
  EditHeight = 21;

type
  TIOControl = class;
  TPropertiesClass = class of TCustomIOControlProperties;
  TCustomIOControlProperties = class(TPersistent)
  private
    FMaxLen: Integer;
    FMinLen: Integer;
    FText: TTextString;
    FFlags: TFlagsString;
    FValidateText: String;
    FState: TStateString;
    FControl: TIOControl;
    function GetLeft: Integer;
    function GetBottom: Integer;
    function GetRight: Integer;
    function GetTop: Integer;
    procedure SetLeft(const Value: Integer);
    procedure SetBottom(const Value: Integer);
    procedure SetRight(const Value: Integer);
    procedure SetTop(const Value: Integer);
    function GetFieldNum: TFieldNum;
    procedure SetFieldNum(const Value: TFieldNum);
    function GetHeight: Integer;
    function GetWidth: Integer;
    procedure SetHeight(const Value: Integer);
    procedure SetWidth(const Value: Integer);
  public
    procedure LoadFromIni(Ini: TCustomIniFile; Section: String); virtual;
    procedure SaveToIni(Ini: TCustomIniFile; Section: String); virtual;
    constructor Create(AControl: TIOControl); virtual;
    property Control: TIOControl read FControl;
  //protected
    property FieldNum: TFieldNum read GetFieldNum write SetFieldNum;
    property Left: Integer read GetLeft write SetLeft;
    property Top: Integer read GetTop write SetTop;
    property Right: Integer read GetRight write SetRight;
    property Bottom: Integer read GetBottom write SetBottom;
    property Width: Integer read GetWidth write SetWidth;
    property Height: Integer read GetHeight write SetHeight;
    property Flags: TFlagsString read FFlags write FFlags;
    property Text: TTextString read FText write FText;
    property State: TStateString read FState write FState;
    property MaxLen: Integer read FMaxLen write FMaxLen;
    property MinLen: Integer read FMinLen write FMinLen;
    property ValidateText: String read FValidateText write FValidateText;
  end;

  TIOControlProperties = class(TCustomIOControlProperties)
  published
    property FieldNum;
    property Left;
    property Top;
    property Right;
    property Bottom;
    property Width;
    property Height;
    property Flags;
    property Text;
    property State;
    property MaxLen;
    property MinLen;
    property ValidateText;
  end;

  TLabelProperties = class(TCustomIOControlProperties)
  published
    property FieldNum;
    property Left;
    property Top;
    property Right;
    property Bottom;
    property Width;
    property Height;
    property Flags;
    property Text;
    property State;
  end;

  TTextProperties = class(TCustomIOControlProperties)
  published
    property FieldNum;
    property Left;
    property Top;
    property Right;
    property Bottom;
    property Width;
    property Height;
    property Flags;
    property Text;
    property State;
    property MaxLen;
    property MinLen;
    property ValidateText;
  end;

  TListProperties = class(TCustomIOControlProperties)
  private
    FListItems: TListItemsString;
  public
    procedure LoadFromIni(Ini: TCustomIniFile; Section: String); override;
    procedure SaveToIni(Ini: TCustomIniFile; Section: String); override;
  published
    property FieldNum;
    property Left;
    property Top;
    property Right;
    property Bottom;
    property Width;
    property Height;
    property Flags;
    property ListItems: TListItemsString read FListItems write FListItems;
    property Text;
    property State;
    property MaxLen;
    property MinLen;
    property ValidateText;
  end;

  TFileRequestProperties = class(TCustomIOControlProperties)
  private
    FFilter: TFilterString;
  public
    procedure LoadFromIni(Ini: TCustomIniFile; Section: String); override;
    procedure SaveToIni(Ini: TCustomIniFile; Section: String); override;
  published
    property FieldNum;
    property Left;
    property Top;
    property Right;
    property Bottom;
    property Width;
    property Height;
    property Flags;
    property Filter: TFilterString read FFilter write FFilter;
    property Text;
    property State;
    property MaxLen;
    property MinLen;
    property ValidateText;
  end;

  TDirRequestProperties = class(TCustomIOControlProperties)
  private
    FRoot: String;
  public
    procedure LoadFromIni(Ini: TCustomIniFile; Section: String); override;
    procedure SaveToIni(Ini: TCustomIniFile; Section: String); override;
  published
    property FieldNum;
    property Left;
    property Top;
    property Right;
    property Bottom;
    property Width;
    property Height;
    property Flags;
    property Text;
    property State;
    property Root: String read FRoot write FRoot;
    property MaxLen;
    property MinLen;
    property ValidateText;
  end;

  TLinkProperties =  class(TCustomIOControlProperties)
  private
    FTxtColor: TTxtColorString;
  public
    procedure LoadFromIni(Ini: TCustomIniFile; Section: String); override;
    procedure SaveToIni(Ini: TCustomIniFile; Section: String); override;
  published
    property FieldNum;
    property Left;
    property Top;
    property Right;
    property Bottom;
    property Width;
    property Height;
    property Flags;
    property Text;
    property State;
    property TxtColor: TTxtColorString read FTxtColor write FTxtColor;
  end;

  TButtonProperties = class(TCustomIOControlProperties)
  published
    property FieldNum;
    property Left;
    property Top;
    property Right;
    property Bottom;
    property Width;
    property Height;
    property Flags;
    property Text;
    property State;
  end;

  TAccessControl = class(TControl);

  TIOControlClass = class of TIOControl;
  TIOControl = class(TCustomPanel)
  private
    FControlType: String;
    FDisplayText: String;
    //FOriginalWindowProc: TWndMethod;

    DlgLeft, DlgTop, DlgBottom, DlgRight: Integer;

    FMoved, FResized: Boolean;
    FPaintControlCopy: Boolean;
    procedure WMWindowPosChanging(var Msg: TWMWindowPosChanged); message  WM_WINDOWPOSCHANGING;
    procedure SetProperties(const Value: TCustomIOControlProperties);
    procedure CreateProperties;
    //procedure NewWindowProc(var Message: TMessage);
  protected
    FControl: TWinControl;
    FUseSpecialBottom, FChangeDisabledColor: Boolean;
    FProperties: TCustomIOControlProperties;
    FPropertiesClass: TPropertiesClass;
    procedure CreateControl(ControlClass: TWinControlClass); virtual;
    procedure SetControlType(Value: String);
    procedure UpdateControlAlign;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Paint; override;
    procedure Resize; override;

    function HaveFlag(const AFlag: String): Boolean;
    procedure UpdateDisplay; virtual;
    procedure UpdateDlgUnits;
    procedure UpdatePostions;
    procedure GetValidFlags(List: TStrings);
    procedure ClearOtherControls;

    procedure SetTop(const Value: Integer);
    procedure SetLeft(const Value: Integer);
    procedure SetBottom(const Value: Integer);
    procedure SetRight(const Value: Integer);

    function GetTop: Integer;
    function GetLeft: Integer;
    function GetRight: Integer;
    function GetBottom: Integer;

    function GetHeight: Integer;
    function GetWidth: Integer;
    procedure SetHeight(const Value: Integer);
    procedure SetWidth(const Value: Integer);

    procedure SetFieldNum(const Value: TFieldNum);
    function GetFieldNum: TFieldNum;

    procedure SaveToIni(Ini: TCustomIniFile; FieldNum: TFieldNum); virtual;
    procedure LoadFromIni(Ini: TCustomIniFile; FieldNum: TFieldNum); virtual;

    property Moved: Boolean read FMoved write FMoved;
    property Resized: Boolean read FResized write FResized;
    property PaintControlCopy: Boolean read FPaintControlCopy write FPaintControlCopy;

    property ControlType: String read FControlType;
    property DisplayText: String read FDisplayText;
  published
    property Properties: TCustomIOControlProperties read FProperties write SetProperties;
  end;

  TIOLabel = class(TIOControl)
  public
    procedure UpdateDisplay; override;
    constructor Create(AOwner: TComponent); override;
  end;

  TIOText = class(TIOControl)
  public
    procedure UpdateDisplay; override;
    constructor Create(AOwner: TComponent); override;
  end;

  TIOPassword = class(TIOText)
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TIOCombobox = class(TIOControl)
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TIODropList = class(TIOCombobox)
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TIOListbox = class(TIOControl)
  public
    procedure UpdateDisplay; override;
    constructor Create(AOwner: TComponent); override;
  end;

  TIOCheckBox = class(TIOControl)
  public
    procedure UpdateDisplay; override;
    constructor Create(AOwner: TComponent); override;
  end;

  TIORadioButton = class(TIOControl)
  public
    procedure UpdateDisplay; override;
    constructor Create(AOwner: TComponent); override;
  end;

  TIOFileRequest = class(TIOControl)
  public
     procedure UpdateDisplay; override;
     constructor Create(AOwner: TComponent); override;
  end;

  TIODirRequest = class(TIOFileRequest)
  public
     constructor Create(AOwner: TComponent); override;
  end;

  TIOIcon = class(TIOControl)
  public
     constructor Create(AOwner: TComponent); override;
     procedure Paint; override;
  end;

  TIOBitmap = class(TIOIcon)
  public
     constructor Create(AOwner: TComponent); override;
  end;

  TIOGroupBox = class(TIOControl)
  public
     procedure UpdateDisplay; override;
     constructor Create(AOwner: TComponent); override;
  end;

  TIOLink = class(TIOLabel)
  protected
    procedure CMParentFontChanged(var Message: TMessage); message CM_PARENTFONTCHANGED;
  public
     constructor Create(AOwner: TComponent); override;
     procedure UpdateDisplay; override;
  end;

  TIOButton = class(TIOControl)
  public
    constructor Create(AOwner: TComponent); override;
    procedure UpdateDisplay; override;
  end;

const
  ControlClasses: array[TControlType] of TIOControlClass =
    (TIOLabel, TIOText, TIOPassword, TIOCombobox, TIODropList, TIOListbox, TIOCheckBox,
     TIORadioButton, TIOFileRequest, TIODirRequest, TIOIcon, TIOBitmap, TIOGroupBox,
     TIOLink, TIOButton);

implementation
uses
  RTDesign, UIODesigner, Utils;

{ TIOControl }

var
  GlobalPaintControlCopy: Boolean;

procedure TIOControl.ClearOtherControls;
var
  DestroyList: TList;
  C: Integer;
begin
  DestroyList := TList.Create;
  try
    for C := 0 to ControlCount - 1 do
      if Controls[C] <> FControl then
        DestroyList.Add(Controls[C]);
    for C := 0 to DestroyList.Count - 1 do
      TControl(DestroyList[C]).Free;
  finally
    DestroyList.Free;
  end;
end;

constructor TIOControl.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FPaintControlCopy := GlobalPaintControlCopy;
  CreateProperties;
  FChangeDisabledColor := False;
  ControlStyle := ControlStyle - [csAcceptsControls];
  BevelOuter := bvNone;
  FullRepaint := FPaintControlCopy;
  Constraints.MinHeight := 9;
  Constraints.MinWidth := 9;
  Height := 32;
  Width := 32;
end;

procedure TIOControl.CreateControl(ControlClass: TWinControlClass);
begin
  FControl := ControlClass.Create(Self);
  FControl.Parent := Self;
  FControl.TabStop := False;
  Height := FControl.Height;
  Width := FControl.Width;
  UpdateControlAlign;
{  FOriginalWindowProc := FControl.WindowProc;
  FControl.WindowProc := NewWindowProc;}
end;

procedure TIOControl.CreateProperties;
begin
  if FPropertiesClass = nil then
    FPropertiesClass := TIOControlProperties;
  FProperties := FPropertiesClass.Create(Self);
end;

destructor TIOControl.Destroy;
begin
  FProperties.Free;
  inherited Destroy;
end;

function TIOControl.GetBottom: Integer;
begin
  if FUseSpecialBottom then
  begin
    if DlgBottom < 0 then
      Result := PixelsToDialogUnitsY((Height + Top) - (Parent.ClientRect.Bottom - Parent.ClientRect.Top),
        TDesignPanel(Parent).AvCharSize.Y) div 2
    else
      Result := PixelsToDialogUnitsY(Height + Top, TDesignPanel(Parent).AvCharSize.Y);
  end else
    if DlgBottom < 0 then
      Result := PixelsToDialogUnitsY((Top + Height) - (Parent.ClientRect.Bottom - Parent.ClientRect.Top),
        TDesignPanel(Parent).AvCharSize.Y) div 2
    else
      Result := PixelsToDialogUnitsY(Top + Height, TDesignPanel(Parent).AvCharSize.Y);
end;

function TIOControl.GetFieldNum: TFieldNum;
var
  C: Integer;
begin
  Result := 0;
  for C := 0 to Parent.ControlCount - 1 do
    if Parent.Controls[C] is TIOControl then
    begin
      Inc(Result);
      if Parent.Controls[C] = Self then Exit;
    end;
end;

function TIOControl.GetHeight: Integer;
begin
  Result := PixelsToDialogUnitsY(Height, TDesignPanel(Parent).AvCharSize.Y);
end;

function TIOControl.GetLeft: Integer;
begin
  if DlgLeft < 0 then
    Result := PixelsToDialogUnitsX(Left - (Parent.ClientRect.Right - Parent.ClientRect.Left),
      TDesignPanel(Parent).AvCharSize.X) div 2
  else
    Result := PixelsToDialogUnitsX(Left, TDesignPanel(Parent).AvCharSize.X);
end;

function TIOControl.GetRight: Integer;
begin
  if DlgRight < 0 then
    Result := PixelsToDialogUnitsX((Left + Width) - (Parent.ClientRect.Right - Parent.ClientRect.Left),
      TDesignPanel(Parent).AvCharSize.X) div 2
  else
    Result := PixelsToDialogUnitsX(Left + Width, TDesignPanel(Parent).AvCharSize.X);
end;

function TIOControl.GetTop: Integer;
begin
  if DlgTop < 0 then
    Result := PixelsToDialogUnitsY(Top - (Parent.ClientRect.Bottom - Parent.ClientRect.Top),
      TDesignPanel(Parent).AvCharSize.Y) div 2
  else
    Result := PixelsToDialogUnitsY(Top, TDesignPanel(Parent).AvCharSize.Y);
end;

procedure TIOControl.GetValidFlags(List: TStrings);
var
  S: String;
begin
  List.BeginUpdate;
  try
    List.Clear;
    with TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'Config\IOCtrlFlags.ini') do
    try
      S := ReadString('Valid Control Flags', FControlType, '');
      while S <> '' do
        List.Add(ExtractStr(S, '|'));
    finally
      Free;
    end;
  finally
    List.EndUpdate;
  end;
end;

function TIOControl.GetWidth: Integer;
begin
  Result := PixelsToDialogUnitsX(Width, TDesignPanel(Parent).AvCharSize.X);
end;

function TIOControl.HaveFlag(const AFlag: String): Boolean;
var
  TmpFlags: String;
begin
  TmpFlags := FProperties.FFlags;
  while TmpFlags <> '' do
  if ExtractStr(TmpFlags, '|') = AFlag then
  begin
     Result := True;
     Exit;
  end;
  Result := False;
end;

procedure TIOControl.LoadFromIni(Ini: TCustomIniFile; FieldNum: TFieldNum);
var
  SectionName: String;
begin
  SectionName := 'Field ' + IntToStr(FieldNum);
  FProperties.LoadFromIni(Ini, SectionName);
  SetLeft(Ini.ReadInteger(SectionName, 'Left', 0));
  SetTop(Ini.ReadInteger(SectionName, 'Top', 0));
  SetRight(Ini.ReadInteger(SectionName, 'Right', 0));
  SetBottom(Ini.ReadInteger(SectionName, 'Bottom', 0));
  FResized := True;
  UpdateDisplay;
end;

{procedure TIOControl.NewWindowProc(var Message: TMessage);
begin
  if Message.Msg = CM_ENTER then
    Abort
  else
    FOriginalWindowProc(Message);
end;}

procedure TIOControl.Paint;
begin
  if FPaintControlCopy and (FControl <> nil) then
    FControl.PaintTo(Canvas.Handle, 0, 0);
end;

procedure TIOControl.Resize;
begin
  if FPaintControlCopy and (FControl <> nil) then
  begin
    FControl.Left := Width + 6;
    FControl.Top := Height + 6;
    FControl.Height := Height;
    FControl.Width := Width;
  end;
end;

procedure TIOControl.SaveToIni(Ini: TCustomIniFile; FieldNum: TFieldNum);
var
  SectionName: String;
begin
  SectionName := 'Field ' + IntToStr(FieldNum);
  Ini.WriteString(SectionName, 'Type', FControlType);
  FProperties.SaveToIni(Ini, SectionName);
  Ini.WriteInteger(SectionName, 'Left', {DlgLeft}GetLeft);
  Ini.WriteInteger(SectionName, 'Right', {DlgRight}GetRight);
  Ini.WriteInteger(SectionName, 'Top', {DlgTop}GetTop);
  Ini.WriteInteger(SectionName, 'Bottom', {DlgBottom}GetBottom);
end;

procedure TIOControl.SetBottom(const Value: Integer);
begin
  DlgBottom := Value;
  if FUseSpecialBottom then
  begin
    if Value < 0 then
      Height :=  (((2*DialogUnitsToPixelsY(Value, TDesignPanel(Parent).AvCharSize.Y)) - Top) + Parent.ClientRect.Bottom - Parent.ClientRect.Top)// - FControl.Tag
    else
      Height := DialogUnitsToPixelsY(Value, TDesignPanel(Parent).AvCharSize.Y) - Top;
  end else
    if Value < 0 then
      Height := (2*DialogUnitsToPixelsY(Value, TDesignPanel(Parent).AvCharSize.Y) + Parent.ClientRect.Bottom - Parent.ClientRect.Top) - Top
    else
      Height := DialogUnitsToPixelsY(Value, TDesignPanel(Parent).AvCharSize.Y) - Top;
end;

procedure TIOControl.SetControlType(Value: String);
begin
  FControlType := Value;
  Hint := Value + '|';
  FProperties.FText := Value;
end;

procedure TIOControl.SetFieldNum(const Value: TFieldNum);
begin
  SetChildOrder(Self, Value - 1);
end;

procedure TIOControl.SetHeight(const Value: Integer);
begin
  if GetBottom >= 0 then
    Height := DialogUnitsToPixelsY(Value, TDesignPanel(Parent).AvCharSize.Y);
end;

procedure TIOControl.SetLeft(const Value: Integer);
begin
  DlgLeft := Value;
  if Value < 0 then
    Left := (2 * DialogUnitsToPixelsX(Value, TDesignPanel(Parent).AvCharSize.X) + Parent.ClientRect.Right - Parent.ClientRect.Left)
  else
    Left := DialogUnitsToPixelsX(Value, TDesignPanel(Parent).AvCharSize.X);
end;

procedure TIOControl.SetProperties(const Value: TCustomIOControlProperties);
begin
  { nothing }
end;

procedure TIOControl.SetRight(const Value: Integer);
begin
  DlgRight := Value;
  if Value < 0 then
    Width := (2 * DialogUnitsToPixelsX(Value, TDesignPanel(Parent).AvCharSize.X) + Parent.ClientRect.Right - Parent.ClientRect.Left) - Left
  else
    Width := DialogUnitsToPixelsX(Value, TDesignPanel(Parent).AvCharSize.X) - Left
end;

procedure TIOControl.SetTop(const Value: Integer);
begin
  DlgTop := Value;
  if Value < 0 then
    Top := (2 * DialogUnitsToPixelsY(Value, TDesignPanel(Parent).AvCharSize.Y) + Parent.ClientRect.Bottom - Parent.ClientRect.Top)
  else
    Top := DialogUnitsToPixelsY(Value, TDesignPanel(Parent).AvCharSize.Y)
end;

procedure TIOControl.SetWidth(const Value: Integer);
begin
  if GetRight >= 0 then
    Width := DialogUnitsToPixelsX(Value, TDesignPanel(Parent).AvCharSize.X);
end;

procedure TIOControl.UpdateControlAlign;
begin
  if FControl <> nil then
  if FPaintControlCopy then
  begin
    FControl.Align := alNone;
    FControl.Top := Height + 6;
    FControl.Left := Width + 6;
  end else
    FControl.Align := alClient;
end;

procedure TIOControl.UpdateDisplay;
var
  C: Integer;
begin
  Caption := '';
  for C := 0 to ControlCount - 1 do
  begin
    Controls[C].Enabled := not HaveFlag('DISABLED');
    if FChangeDisabledColor then
      SetCtrlEnabled(FControl, FControl.Enabled);
  end;
  FDisplayText := FProperties.FText + ': ' + FControlType;
  Visible := True;
  Repaint;
end;

procedure TIOControl.UpdateDlgUnits;
begin
  DlgLeft := GetLeft;
  DlgTop := GetTop;
  DlgBottom := GetBottom;
  DlgRight := GetRight;
end;

procedure TIOControl.UpdatePostions;
begin
  if DlgLeft < 0 then SetLeft(DlgLeft);
  if DlgTop < 0 then SetTop(DlgTop);
  if DlgBottom < 0 then SetBottom(DlgBottom);
  if DlgRight < 0 then SetRight(DlgRight);
end;

procedure TIOControl.WMWindowPosChanging(var Msg: TWMWindowPosChanged);
begin
  inherited;
  with Msg.WindowPos^ do
  begin
    if (x < 0) then x := 0;
    if (y < 0) then y := 0;
  end;
end;

{ TIOLabel }

constructor TIOLabel.Create(AOwner: TComponent);
begin
  if FPropertiesClass = nil then
    FPropertiesClass := TLabelProperties;
  inherited Create(AOwner);
  CreateControl(TStaticText);
  SetControlType('Label');
end;

procedure TIOLabel.UpdateDisplay;
begin
  TStaticText(FControl).Caption := ConvertNewLines(FProperties.FText);
  if not FResized then
  begin
    Height := Canvas.TextHeight(FProperties.FText);
    Width := Canvas.TextWidth(FProperties.FText);
  end;
  inherited UpdateDisplay;
end;

{ TIOText }

constructor TIOText.Create(AOwner: TComponent);
begin
  FPropertiesClass := TTextProperties;
  inherited Create(AOwner);
  CreateControl(TMemo);
  Height := EditHeight;
  SetControlType('Text');
  FProperties.FState := FProperties.FText;
  FProperties.FText := '';
end;

procedure TIOText.UpdateDisplay;
begin
  if HaveFlag('MULTILINE') then
    TMemo(FControl).Text := ConvertNewLines(FProperties.FState)
  else
    TMemo(FControl).Text := FProperties.FState;

  if not FPaintControlCopy then
  begin
    if HaveFlag('HSCROLL') and HaveFlag('VSCROLL') then
      TMemo(FControl).ScrollBars := ssBoth
    else if HaveFlag('VSCROLL') then
      TMemo(FControl).ScrollBars := ssVertical
    else if HaveFlag('HSCROLL') then
      TMemo(FControl).ScrollBars := ssHorizontal
    else
      TMemo(FControl).ScrollBars := ssNone;
  end;

  TMemo(FControl).WordWrap := (HaveFlag('MULTILINE') and not HaveFlag('HSCROLL')) and
    not HaveFlag('NOWORDWRAP');
  TMemo(FControl).Color := ReadOnlyColors[HaveFlag('READONLY') or not FControl.Enabled];

  inherited UpdateDisplay;

  if TMemo(FControl).Lines.Count > 0 then
    FDisplayText := TMemo(FControl).Lines[0] + ': ' + FControlType
  else
    FDisplayText := ': ' + FControlType;
end;

{ TIOPassword }

constructor TIOPassword.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  //TCustomEdit(FControl).PasswordChar := '*';
  SetControlType('Password');
  FProperties.FState := FProperties.FText;
  FProperties.FText := '';
end;

{ TIOCombobox }

constructor TIOCombobox.Create(AOwner: TComponent);
begin
  FPropertiesClass := TListProperties;
  inherited Create(AOwner);
  CreateControl(TComboBox);
  FUseSpecialBottom := True;
  FControl.Align := alTop;
  Height := 150;
  FChangeDisabledColor := True;
  SetControlType('Combobox');
end;


{ TIODropList }

constructor TIODropList.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  SetControlType('Droplist');
end;

{ TIOListbox }

constructor TIOListbox.Create(AOwner: TComponent);
begin
  FPropertiesClass := TListProperties;
  inherited Create(AOwner);
  CreateControl(TListBox);
  SetControlType('Listbox');
end;

procedure TIOListbox.UpdateDisplay;
begin
  CommaListToStrList(TListProperties(FProperties).FListItems, '|',
    TListBox(FControl).Items);

  inherited UpdateDisplay;
  
  if TListBox(FControl).Items.Count > 0 then
    FDisplayText := TListBox(FControl).Items[0] + ': ' + FControlType
  else
    FDisplayText := ': ' + FControlType;
end;

{ TIOCheckBox }

constructor TIOCheckBox.Create(AOwner: TComponent);
begin
  FPropertiesClass := TLabelProperties;
  inherited Create(AOwner);
  CreateControl(TCheckBox);
  SetControlType('Checkbox');
end;

procedure TIOCheckBox.UpdateDisplay;
begin
  AddWinLong(FControl.Handle, GWL_STYLE, BS_MULTILINE);
  TCheckBox(FControl).Caption := FProperties.FText;
  TCheckBox(FControl).Checked := FProperties.FState = '1';
  if HaveFlag('RIGHT') then
    TCheckBox(FControl).Alignment := taLeftJustify
  else
    TCheckBox(FControl).Alignment := taRightJustify;
  inherited UpdateDisplay;
end;

{ TIORadioButton }

constructor TIORadioButton.Create(AOwner: TComponent);
begin
  FPropertiesClass := TLabelProperties;
  inherited Create(AOwner);
  CreateControl(TRadioButton);
  SetControlType('RadioButton');
end;

procedure TIORadioButton.UpdateDisplay;
begin
  AddWinLong(FControl.Handle, GWL_STYLE, BS_MULTILINE);
  TRadioButton(FControl).Caption := FProperties.FText;
  TRadioButton(FControl).Checked := FProperties.FState = '1';
  if HaveFlag('RIGHT') then
    TRadioButton(FControl).Alignment := taLeftJustify
  else
    TRadioButton(FControl).Alignment := taRightJustify;
  inherited UpdateDisplay;
end;

{ TIOFileRequest }


type
  TRequestPanel = class(TCustomPanel)
  private
    FButtonWidth: Integer;
    FUpdateSize: Boolean;
    procedure CMEnabledChanged(var Msg: TMessage); message CM_ENABLEDCHANGED;
  public
    Edit: TMemo;
    Button: TButton;
    procedure Resize; override;
    constructor Create(AOwner: TComponent); override;
  end;

procedure TRequestPanel.CMEnabledChanged(var Msg: TMessage);
begin
  SetCtrlEnabled(Edit, Enabled);
  Button.Enabled := Enabled;
end;

constructor TRequestPanel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle - [csAcceptsControls];
  BevelOuter := bvNone;
  FullRepaint := False;
  FButtonWidth := -1;
  Edit := TMemo.Create(Self);
  Edit.Parent := Self;
  Edit.WordWrap := False;
  Edit.TabStop := False;
  Edit.Height := EditHeight;
  Button := TButton.Create(Self);
  Button.Parent := Self;
  Button.Caption := '...';
  Button.TabStop := False;
  Height := Edit.Height;
  Width := Edit.Width + FButtonWidth;
  FUpdateSize := True;
end;

procedure TRequestPanel.Resize;
begin
  inherited Resize;
  if not FUpdateSize then Exit;
  if FButtonWidth = -1 then
    FButtonWidth := DialogUnitsToPixelsX(RequestButtonWidth,
     TDesignPanel(Parent.Parent).AvCharSize.X);
  Edit.Height := Height;
  Edit.Width := Width - FButtonWidth;
  Button.Left := Edit.Width + 3;
  Button.Height := Height;
  Button.Width := FButtonWidth - 3;
end;

constructor TIOFileRequest.Create(AOwner: TComponent);
begin
  if FPropertiesClass = nil then
    FPropertiesClass := TFileRequestProperties;
  inherited Create(Aowner);
  CreateControl(TRequestPanel);
  SetControlType('FileRequest');
  FProperties.FState := FProperties.FText;
  FProperties.FText := '';
end;

procedure TIOFileRequest.UpdateDisplay;
begin
  with TRequestPanel(FControl) do
  begin
    Edit.Text := FProperties.FState;
    SetCtrlEnabled(Edit, Edit.Enabled);
    Edit.Color := ReadOnlyColors[HaveFlag('READONLY') or not Edit.Enabled];
    Resize;
  end;
  inherited UpdateDisplay;
  FDisplayText := FProperties.FState + ': ' + FControlType;
end;

{ TIODirRequest }

constructor TIODirRequest.Create(AOwner: TComponent);
begin
  FPropertiesClass := TDirRequestProperties;
  inherited Create(AOwner);
  SetControlType('DirRequest');
  FProperties.FState := FProperties.FText;
  FProperties.FText := '';
end;

{ TIOIcon }

constructor TIOIcon.Create(AOwner: TComponent);
begin
  FPropertiesClass := TLabelProperties;
  inherited Create(AOwner);
  SetControlType('Icon');
  FProperties.FText := '';
end;

procedure TIOIcon.Paint;
var
  Picture: TPicture;

  procedure PaintBorder;
  begin
    Canvas.Brush.Color := Color;
    Canvas.Brush.Style := bsSolid;
    Canvas.Pen.Style := psDash;
    Canvas.Rectangle(ClientRect);
  end;

begin
  inherited Paint;
  if FileExists(FProperties.FText) then
  begin
    Picture := TPicture.Create;
    try
      try
        Picture.LoadFromFile(FProperties.FText);
        Canvas.StretchDraw(ClientRect, Picture.Graphic);
      except
         { if the file isn't a valid graphic file }
         PaintBorder;
      end;
    finally
      Picture.Free;
    end;
  end else
    PaintBorder;
end;

{ TIOBitmap }

constructor TIOBitmap.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  SetControlType('Bitmap');
end;

{ TIOGroupBox }

constructor TIOGroupBox.Create(AOwner: TComponent);
begin
  FPropertiesClass := TLabelProperties;// TLinkProperties;
  inherited Create(AOwner);
  CreateControl(TNewGroupbox);
  //TNewGroupbox(FControl).AddTrailingSpaces := False;
  SetControlType('Groupbox');
end;

procedure TIOGroupBox.UpdateDisplay;
begin
  TNewGroupBox(FControl).Caption := FProperties.FText;
  inherited UpdateDisplay;  
end;

{ TIOLink }

procedure TIOLink.CMParentFontChanged(var Message: TMessage);
begin
  inherited;
  UpdateDisplay;
end;

constructor TIOLink.Create(AOwner: TComponent);
begin
  FPropertiesClass := TLinkProperties;
  inherited Create(AOwner);
  SetControlType('Link');
end;

procedure TIOLink.UpdateDisplay;
var
  S: String;
begin
  S := TLinkProperties(FProperties).FTxtColor;
  with TStaticText(FControl) do
  begin
    Font.Name := Self.Font.Name;
    Font.Size := Self.Font.Size;
    if Length(S) > 2 then
      Font.Color := TColor(StrToIntDef('$' + Copy(S, 3, 8), 0))
    else
      Font.Color := clBlue;
  end;
  inherited UpdateDisplay;
end;

{ TCustomIOControlProperties }

constructor TCustomIOControlProperties.Create(AControl: TIOControl);
begin
  inherited Create;
  FControl := AControl;
end;

function TCustomIOControlProperties.GetBottom: Integer;
begin
  Result := FControl.GetBottom;
end;

function TCustomIOControlProperties.GetFieldNum: TFieldNum;
begin
  Result := FControl.GetFieldNum;
end;

function TCustomIOControlProperties.GetHeight: Integer;
begin
  Result := FControl.GetHeight;
end;

function TCustomIOControlProperties.GetLeft: Integer;
begin
  Result := FControl.GetLeft;
end;

function TCustomIOControlProperties.GetRight: Integer;
begin
  Result := FControl.GetRight;
end;

function TCustomIOControlProperties.GetTop: Integer;
begin
  Result := FControl.GetTop;
end;

function TCustomIOControlProperties.GetWidth: Integer;
begin
  Result := FControl.GetWidth;
end;

procedure TCustomIOControlProperties.LoadFromIni(Ini: TCustomIniFile;
  Section: String);
begin
  with Ini do begin
    FMaxLen := ReadInteger(Section, 'MaxLen', 0);
    FMinLen := ReadInteger(Section, 'MinLen', 0);
    FText := ReadString(Section, 'Text', '');
    FFlags := ReadString(Section, 'Flags', '');
    FValidateText := ReadString(Section, 'ValidateText', '');
    FState := ReadString(Section, 'State', '');
  end;
end;

procedure TCustomIOControlProperties.SaveToIni(Ini: TCustomIniFile;
  Section: String);
begin
  with Ini do begin
    if FMaxLen <> 0 then
      WriteInteger(Section, 'MaxLen', FMaxLen);
    if FMinLen <> 0 then
      WriteInteger(Section, 'MinLen', FMinLen);
    if FText <> '' then
      WriteString(Section, 'Text', FText);
    if FFlags <> '' then
      WriteString(Section, 'Flags', FFlags);
    if FValidateText <> '' then
      WriteString(Section, 'ValidateText', FValidateText);
    if FState <> '' then
      WriteString(Section, 'State', FState);
  end;
end;

procedure TCustomIOControlProperties.SetBottom(const Value: Integer);
begin
  FControl.SetBottom(Value);
end;

procedure TCustomIOControlProperties.SetFieldNum(const Value: TFieldNum);
begin
  FControl.SetFieldNum(Value);
end;

procedure TCustomIOControlProperties.SetHeight(const Value: Integer);
begin
  FControl.SetHeight(Value);
end;

procedure TCustomIOControlProperties.SetLeft(const Value: Integer);
begin
  FControl.SetLeft(Value);
end;

procedure TCustomIOControlProperties.SetRight(const Value: Integer);
begin
  FControl.SetRight(Value);
end;

procedure TCustomIOControlProperties.SetTop(const Value: Integer);
begin
  FControl.SetTop(Value);
end;

procedure TCustomIOControlProperties.SetWidth(const Value: Integer);
begin
  FControl.SetWidth(Value);
end;

{ TListProperties }

procedure TListProperties.LoadFromIni(Ini: TCustomIniFile;
  Section: String);
begin
  inherited LoadFromIni(Ini, Section);
  FListItems := Ini.ReadString(Section, 'ListItems', '');
end;

procedure TListProperties.SaveToIni(Ini: TCustomIniFile; Section: String);
begin
  inherited SaveToIni(Ini, Section);
  Ini.WriteString(Section, 'ListItems', FListItems);
end;

{ TFileRequestProperties }

procedure TFileRequestProperties.LoadFromIni(Ini: TCustomIniFile;
  Section: String);
begin
  inherited LoadFromIni(Ini, Section);
  FFilter := Ini.ReadString(Section, 'Filter', '');
end;

procedure TFileRequestProperties.SaveToIni(Ini: TCustomIniFile;
  Section: String);
begin
  inherited SaveToIni(Ini, Section);
  if FFilter <> '' then
    Ini.WriteString(Section, 'Filter', FFilter);
end;

{ TDirRequestProperties }

procedure TDirRequestProperties.LoadFromIni(Ini: TCustomIniFile;
  Section: String);
begin
  inherited LoadFromIni(Ini, Section);
  FRoot := Ini.ReadString(Section, 'Root', '');
end;

procedure TDirRequestProperties.SaveToIni(Ini: TCustomIniFile;
  Section: String);
begin
  inherited SaveToIni(Ini, Section);
  if FRoot <> '' then
    Ini.WriteString(Section, 'Root', FRoot);
end;


{ TLinkProperties }

procedure TLinkProperties.LoadFromIni(Ini: TCustomIniFile;
  Section: String);
begin
  inherited LoadFromIni(Ini, Section);
  FTxtColor := Ini.ReadString(Section, 'TxtColor', '');
end;

procedure TLinkProperties.SaveToIni(Ini: TCustomIniFile; Section: String);
begin
  inherited SaveToIni(Ini, Section);
  if FTxtColor <> '' then
    Ini.WriteString(Section, 'TxtColor', FTxtColor);
end;

{ TIOButton }

constructor TIOButton.Create(AOwner: TComponent);
begin
  FPropertiesClass := TButtonProperties;
  inherited Create(AOwner);
  CreateControl(TButton);
  SetControlType('Button');
end;

procedure TIOButton.UpdateDisplay;
begin
  TButton(FControl).Caption := FProperties.FText;
  inherited UpdateDisplay;
end;

// --------------------------------------------------------------------
procedure RegisterClasses;
const
  RegControlClasses: array[1..10] of TControlClass =
    (TCustomPanel, TStaticText, TMemo, TCombobox, TListbox, TCheckBox,
      TRadioButton, TButton, TNewGroupBox, TRequestPanel);
var
  I: TControlType;
  I2: Integer;
begin
  for I2 := Low(RegControlClasses) to High(RegControlClasses) do
    RegisterClass(RegControlClasses[I2]);

  RegisterClass(TIOControl);
  for I := Low(ControlClasses) to High(ControlClasses) do
    RegisterClass(ControlClasses[I]);
end;

initialization
  RegisterClasses;
  GlobalPaintControlCopy := OptionsIni.ReadBool('Options',
    'IODesignerPaintControlCopy', False);
end.
