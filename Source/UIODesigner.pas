{
  HM NIS Edit (c) 2003 Héctor Mauricio Rodríguez Segura <ranametal@users.sourceforge.net>
  For conditions of distribution and use, see license.txt

  InstallOptions Designer frame
}
unit UIODesigner;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  RTDesign, ExtCtrls, UCustomMDIChild, Menus, TB2Item, TBX, TB2Dock,
  TB2Toolbar, SynEdit, ActnList, StdActns;

type
  TBooleanValue = (Default, No, Yes);
  TIODesignerFrm = class;
  TIOSettings = class(TPersistent)
  private
    FBackEnabled: TBooleanValue;
    FCancelEnabled: TBooleanValue;
    FCancelShow: TBooleanValue;
    FBackButtonText: String;
    FNextButtonText: String;
    FRect: String;
    FCancelButtonText: String;
    FTitle: String;
  published
    property CancelEnabled: TBooleanValue read FCancelEnabled write FCancelEnabled;
    property CancelShow: TBooleanValue read FCancelShow write FCancelShow;
    property BackEnabled: TBooleanValue read FBackEnabled write FBackEnabled;
    property Title: String read FTitle write FTitle;
    property CancelButtonText: String read FCancelButtonText write FCancelButtonText;
    property NextButtonText: String read FNextButtonText write FNextButtonText;
    property BackButtonText: String read FBackButtonText write FBackButtonText;
    property Rect: String read FRect write FRect;
  end;

  TGridKind = (gkDots, gkLines);
  TDesignPanel = class(TPanel)
  private
    FGridX, FGridY: Integer;
    FDesignerFrm: TIODesignerFrm;
    FDialogUnit: TPoint;
    FAvCharSize: TPoint;
    FRTDesigner: TRTDesigner;
    FGridKind: TGridKind;
    FGridColor: TColor;
  protected
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
    function UpdateAction(Action: TBasicAction): boolean; override;
    function ExecuteAction(Action: TBasicAction): boolean; override;
    procedure GetControlList(List: TStrings);
    property GridX: Integer read FGridX write FGridX;
    property GridY: Integer read FGridY write FGridY;
    property AvCharSize: TPoint read FAvCharSize write FAvCharSize;
    property RTDesigner: TRTDesigner read FRTDesigner write FRTDesigner;
    property DialogUnit: TPoint read FDialogUnit write FDialogUnit;
    property DesignerFrm: TIODesignerFrm read FDesignerFrm;
    property GridKind: TGridKind read FGridKind write FGridKind;
    property GridColor: TColor read FGridColor write FGridColor;
  end;

  TIODesignerFrm = class(TCustomMDIChild)
    RTDesigner: TRTDesigner;
    Notebook: TNotebook;
    CodeEditor: TSynEdit;
    ParentDesignPanel: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure RTDesignerInsertQuery(Sender: TObject; Control: TControl;
      var aClass: TControlClass);
    procedure RTDesignerAfterInsert(Sender: TObject; Control: TControl);
    procedure RTDesignerBeforeSelectControl(Sender: TObject;
      Control: TControl; var DoSelect: Boolean);
    procedure RTDesignerBaseControlClick(Sender: TObject;
      var ClearSelection, DrawSelectionFrame: Boolean; Shift: TShiftState;
      X, Y: Integer);
    procedure RTDesignerAfterSized(Sender: TObject);
    procedure RTDesignerAfterMove(Sender: TObject);
    procedure RTDesignerRemoveControl(Sender: TObject; aControl: TControl);
    procedure RTDesignerGetPopupMenu(Sender: TObject;
      var Menu: TPopupMenu);
    procedure CodeEditorChange(Sender: TObject);
    procedure CodeEditorStatusChange(Sender: TObject;
      Changes: TSynStatusChanges);
    procedure RTDesignerKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormResize(Sender: TObject);
  private
    gControlType: Integer;
    FIOSettings: TIOSettings;
    FHeaderText: TStrings;
    procedure SetModified(const Value: Boolean);
    procedure DesignPanelResize(Sender: TObject);
    function GetModified: Boolean;
    function GetDesignMode: Boolean;
    procedure SetDesignMode(const Value: Boolean);
  protected
    function GetSynEdit: TSynEdit; override;
  public
    DesignPanel: TDesignPanel;
    procedure UpdateOptions;
    procedure UpdateDisplay;
    procedure UpdateEditor; override;
    procedure SaveFile(AFileName: String); override;
    procedure LoadFile(AFileName: String); override;
    procedure SaveToLines(Lines: TStrings);
    function LoadFromLines(Lines: TStrings): Boolean;
    function GetDesignPanelXY: TPoint;
    procedure AssignZList;
    procedure ResizeTo(const X, Y: Integer);

    property IOSettings: TIOSettings read FIOSettings;
    property Modified: Boolean read GetModified write SetModified;
    property DesignMode: Boolean read GetDesignMode write SetDesignMode;
  end;

var
  IODesignerFrm: TIODesignerFrm;

implementation

uses IniFiles, Utils, UMain, IOControls;

{$R *.DFM}

{ TDesignPanel }
constructor TDesignPanel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FDesignerFrm := TIODesignerFrm(AOwner);
  BevelOuter := bvNone;
  FullRepaint := False;
end;

function TDesignPanel.ExecuteAction(Action: TBasicAction): boolean;
var
  C: Integer;
begin
  if Action is TEditAction then
  begin
    Result := True;
    if Action is TEditCut then
    begin
      FRTDesigner.CopyToClipboard;
      FRTDesigner.DeleteSelection;
    end
    else if Action is TEditCopy then
      FRTDesigner.CopyToClipboard
    else if Action is TEditPaste then
    begin
      try
        FRTDesigner.PasteFromClipboard;
        for C := 0 to RTDesigner.ControlCount - 1 do
          TIOControl(FRTDesigner.Control[C]).UpdateDisplay;
      except
        ///
      end;
    end
    else if Action is TEditDelete then
      FRTDesigner.DeleteSelection
    else if Action is TEditUndo then
    begin
      RTDesigner.Undo;
      if RTDesigner.ControlCount > 0 then
        MainFrm.IOCrtlPropList.CurObj := TIOControl(RTDesigner.Control[0]).Properties
      else
        MainFrm.IOCrtlPropList.CurObj := FDesignerFrm.IOSettings;
      for C := 0 to RTDesigner.ControlCount - 1 do
        with TIOControl(FRTDesigner.Control[C]) do
        begin
          ClearOtherControls;
          UpdateDisplay;
        end;
    end
    else if Action is TEditSelectAll then
      FRTDesigner.SelectAll;
  end else
    Result := inherited ExecuteAction(Action);
end;

function TDesignPanel.UpdateAction(Action: TBasicAction): boolean;
begin
  if Action is TEditAction then
  begin
    Result := Focused;
    if Result then
    begin
      if (Action is TEditCut) or (Action is TEditCopy) then
        TEditAction(Action).Enabled := FRTDesigner.ControlCount > 0
      else if Action is TEditPaste then
        TEditAction(Action).Enabled := True//CanPaste
      else if Action is TEditDelete then
        TEditAction(Action).Enabled := FRTDesigner.ControlCount > 0
      else if Action is TEditUndo then
        TEditAction(Action).Enabled := RTDesigner.UndoKind <> ukNone
      else if Action is TEditSelectAll then
        TEditAction(Action).Enabled := True;
    end;
  end else
    Result := inherited UpdateAction(Action);
end;

procedure TDesignPanel.Paint;
var
  ColorRGB, X, Y, MaxX, MaxY, aGridX, aGridY: Integer;
  Dc: HDC;
begin
  if not MainFrm.Options.IOShowGrid then Exit;

  aGridX := GridX;
  aGridY := GridY;
  if aGridX < 1 then aGridX := 1;
  if aGridY < 1 then aGridY := 1;
  MaxX := ClientWidth div aGridX;
  MaxY := ClientHeight div aGridY;

  case FGridKind of
    gkDots: begin
      ColorRGB := ColorToRGB(FGridColor);
      Dc := Canvas.Handle;
      for X := 0 to MaxX do
        for Y := 0 to MaxY do
          SetPixel(Dc, X * aGridX, Y * aGridY, ColorRGB);
    end;
    gkLines: begin
      Canvas.Pen.Color := FGridColor;
      for X := 0 to MaxX do
      begin
        Canvas.MoveTo(X * aGridX, 0);
        Canvas.LineTo(X * aGridX, ClientHeight);
      end;
      for Y := 0 to MaxY do
      begin
        Canvas.MoveTo(0, Y * aGridY);
        Canvas.LineTo(ClientWidth, Y * aGridY);
      end;
    end;
  end;
end;

procedure TDesignPanel.GetControlList(List: TStrings);
var
  C: Integer;
begin
  List.BeginUpdate;
  try
    List.Clear;
    for C := 0 to ControlCount - 1 do
      if Controls[C] is TIOControl then
        List.AddObject(TIOControl(Controls[C]).DisplayText, Controls[C]);
  finally
    List.EndUpdate;
  end;
end;

{TIODesignerFrm}

procedure TIODesignerFrm.FormCreate(Sender: TObject);
begin
  FIOSettings := TIOSettings.Create;
  DesignPanel := TDesignPanel.Create(Self);
  with DesignPanel do
  begin
    Parent := ParentDesignPanel;
    RTDesigner := Self.RTDesigner;
    Align := alClient;
    OnResize := DesignPanelResize;
    AvCharSize := GetAveCharSize(Canvas);
    DialogUnit := Point(DialogUnitsToPixelsX(1, AvCharSize.X), DialogUnitsToPixelsY(1, AvCharSize.Y));
    UpdateOptions;
  end;
  RTDesigner.BaseControl := DesignPanel;
  CodeEditor.Highlighter := MainFrm.SynIni;
  SetDesignMode(MainFrm.Options.IniFilesDesignMode);
  FDefExt := '.ini';
end;

procedure TIODesignerFrm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if MainFrm.MDIChildCount = 1 then
  begin
    MainFrm.IOPanel.Hide;
    MainFrm.EnableIOControls(False);
  end;
end;

procedure TIODesignerFrm.FormDestroy(Sender: TObject);
begin
  try FreeAndNil(RTDesigner) except end;
  FIOSettings.Free;
  FHeaderText.Free;
end;

procedure TIODesignerFrm.FormActivate(Sender: TObject);
begin
  with MainFrm do
  begin
    if GetDesignMode then
    begin
      EnableIOControls(True);
      ShowIOPanel;
    end;{ else
    begin
      IOPanel.Visible := False;
      DisableIOControls;
    end;}
    AssignZList;
    UpdateStatus;
  end;
  if GetDesignMode then
    DesignPanel.SetFocus;
end;

procedure TIODesignerFrm.RTDesignerInsertQuery(Sender: TObject;
  Control: TControl; var aClass: TControlClass);
var
  C: Integer;
begin
  with MainFrm.tbIOCtrls do
  for C := 0 to Items.Count - 2 do
   if Items[C].Checked then
   begin
     gControlType := C;
     aClass := ControlClasses[TControlType(C)];
     Exit;
   end;
end;

type
  TAccessControl = class(TControl);
procedure TIODesignerFrm.RTDesignerAfterInsert(Sender: TObject;
  Control: TControl);
begin
  MainFrm.CursorItem.Checked := True;
  Control.Tag := Ord(gControlType);
  RTDesigner.AlignToGrid;
  RTDesigner.ShowSelection(True);
  TIOControl(Control).UpdateDisplay;
  TIOControl(Control).UpdateDlgUnits;
  TAccessControl(Control).Resize;
  RTDesigner.UpdateSelection;
  SetModified(True);
  RTDesigner.ResetUndo;
  //RTDesignerAfterMove(RTDesigner);
end;

procedure TIODesignerFrm.RTDesignerBeforeSelectControl(Sender: TObject;
  Control: TControl; var DoSelect: Boolean);
begin
  MainFrm.IOCrtlPropList.CurObj := TIOControl(Control).Properties;
end;

procedure TIODesignerFrm.UpdateDisplay;
var
  C: Integer;
  CtrlUpdated: Boolean;
begin
  CtrlUpdated := False;
  for C := 0 to RTDesigner.ControlCount - 1 do
  begin             
    if RTDesigner.Control[C] is TIOControl then
      TIOControl(RTDesigner.Control[C]).UpdateDisplay;
    CtrlUpdated := True;
  end;
  if CtrlUpdated then
    RTDesigner.UpdateSelection;
end;

procedure TIODesignerFrm.RTDesignerBaseControlClick(Sender: TObject;
  var ClearSelection, DrawSelectionFrame: Boolean; Shift: TShiftState; X,
  Y: Integer);
begin
  MainFrm.IOCrtlPropList.CurObj := IOSettings;
end;

procedure TIODesignerFrm.LoadFile(AFileName: String);
var
  Lines: TStrings;
begin
  FileName := AFileName;
  if GetDesignMode then
  begin
    Lines := TStringList.Create;
    try
      Lines.LoadFromFile(FileName);
      LoadFromLines(Lines);
    finally
      Lines.Free;
    end;
  end else
  begin
    Modified := False;
    CodeEditor.Lines.LoadFromFile(FileName);
  end;
end;

function TIODesignerFrm.LoadFromLines(Lines: TStrings): Boolean;

  function ControlNameToControlType(const ControlName: String): TControlType;
  begin
    for Result := Low(TControlType) to High(TControlType) do
      if SameText(ControlName, ControlNames[Result]) then Exit;
    raise Exception.CreateFmt(LangStr('NoValidIOControl'), [ControlName]);
  end;

var
  C, Fields: Integer;
  SaveModified: Boolean;
  Ini: TMemIniFile;
  S: String;
begin
  SaveModified := GetModified;
  Ini := TMemIniFile.Create('');
  try
    Ini.SetStrings(Lines);

    Fields := Ini.ReadInteger('Settings', 'NumFields', -1);
    Result := Fields >= 0;
    if not Result then Exit;

    FIOSettings.FTitle := Ini.ReadString('Settings', 'Title', '');

    FIOSettings.FCancelEnabled := TBooleanValue(Ini.ReadInteger('Settings', 'CancelEnabled', -1) + 1);
    FIOSettings.FCancelShow := TBooleanValue(Ini.ReadInteger('Settings', 'CancelShow', -1) + 1);
    FIOSettings.FBackEnabled := TBooleanValue(Ini.ReadInteger('Settings', 'BackEnabled', -1) + 1);

    FIOSettings.FCancelButtonText := Ini.ReadString('Settings', 'CancelButtonText', '');
    FIOSettings.FNextButtonText := Ini.ReadString('Settings', 'NextButtonText', '');
    FIOSettings.FBackButtonText := Ini.ReadString('Settings', 'BackButtonText', '');
    FIOSettings.FRect := Ini.ReadString('Settings', 'Rect', '');

    RTDesigner.ClearBaseControl;
    for C := 1 to Fields do
    begin
      try               
        with TIOControl(RTDesigner.AddControl(ControlClasses[ControlNameToControlType(Ini.ReadString('Field ' + IntToStr(C), 'Type', ''))],
          DesignPanel, 0, 0, '', False)) do LoadFromIni(Ini, C);
      except
        Application.HandleException(Self);
      end;
    end;
  finally
    Ini.Free;
    SetModified(SaveModified);
  end;

  // Save the comments of the top
  if FHeaderText = nil then
    FHeaderText := TStringList.Create;
  FHeaderText.Clear;
  for C := 0 to Lines.Count - 1 do
  begin
    S := Trim(Lines[C]);
    if (S <> '') and (S[1] = '[') and
      (AnsiLastChar(S)^ = ']') then Break;
    FHeaderText.Add(Lines[C]);
  end;
  //---
end;

procedure TIODesignerFrm.SaveFile(AFileName: String);
var
  Lines: TStrings;
begin
  if AFileName <> '' then
  begin
    FileName := AFileName;
    MainFrm.AddToRecent(FileName);
  end;

  if GetDesignMode then
  begin
    Lines := TStringList.Create;
    try
      SaveToLines(Lines);
      Lines.SaveToFile(FileName);
    finally
      Lines.Free;
    end;
  end else
    CodeEditor.Lines.SaveToFile(FileName);

  SetModified(False);
  InitValues;
end;

procedure TIODesignerFrm.SetModified(const Value: Boolean);
begin
  if Value <> GetModified then
  begin
    inherited Modified := Value;
    MainFrm.UpdateStatus;
  end;
end;

function TIODesignerFrm.GetSynEdit: TSynEdit;
begin
  if Notebook.PageIndex = 1 then
    Result := CodeEditor
  else
    Result := nil;
end;

function TIODesignerFrm.GetModified: Boolean;
begin
  Result := inherited Modified;
end;

procedure TIODesignerFrm.UpdateEditor;
begin
  if UseHighLighter then
    CodeEditor.Highlighter := MainFrm.SynIni
  else
    CodeEditor.Highlighter := nil;
  CodeEditor.Assign(MainFrm.EditorOptions);
  if DesignMode and ReadOnly then
  begin
    RTDesigner.EditMode := False;
    MainFrm.IOCrtlPropList.CurObj := nil;
  end;
  inherited UpdateEditor;
end;

function TIODesignerFrm.GetDesignPanelXY: TPoint;
begin
  with Result do
  begin
    X := PixelsToDialogUnitsX(DesignPanel.Width, DesignPanel.AvCharSize.X);
    Y := PixelsToDialogUnitsY(DesignPanel.Height, DesignPanel.AvCharSize.Y);
  end;
end;

function TIODesignerFrm.GetDesignMode: Boolean;
begin
  Result := Notebook.PageIndex = 0;
end;

procedure TIODesignerFrm.SetDesignMode(const Value: Boolean);
begin
  if Value <> GetDesignMode then
  begin
    RTDesigner.EditMode := Value;
    if Value then
    begin
      MainFrm.EnableIOControls(True);
      MainFrm.ShowIOPanel;
      LoadFromLines(CodeEditor.Lines);
      Notebook.PageIndex := 0;
      DesignPanel.SetFocus;
    end else
    begin
      MainFrm.IOPanel.Visible := False;
      MainFrm.EnableIOControls(False);
      SaveToLines(CodeEditor.Lines);
      Notebook.PageIndex := 1;
    end;
    AssignZList;
    UpdateEditor;
    MainFrm.UpdateStatus;
  end;
end;

procedure TIODesignerFrm.AssignZList;
begin
  if RTDesigner.ControlCount > 0 then
    MainFrm.IOCrtlPropList.CurObj := TIOControl(RTDesigner.Control[0]).Properties
  else
    MainFrm.IOCrtlPropList.CurObj := IOSettings;
end;

{var
 Len: Integer;
 Handles: array of HWnd;
function EnumChildWinProc(Handle: HWnd; Param: LParam): Bool; stdcall
begin
  Inc(Len);
  SetLength(Handles, Len);
  Handles[Len-1] := Handle;
  Result := True;
end;}

procedure TIODesignerFrm.SaveToLines(Lines: TStrings);
var
  C: Integer;
  Ini: TMemIniFile;
  NewDesginPanelList: TList;

  procedure ReorderPanels;
  var
    //Ctrl: TWinControl;
    C: Integer;
  begin
    {Handles := nil;
    Len := 0;
    EnumChildWindows(DesignPanel.Handle, @EnumChildWinProc, 0);}
    for C := 0 to DesignPanel.ControlCount - 1{Length(Handles) - 1}  do
    begin
      //Ctrl := FindControl(Handles[C]);
      if DesignPanel.Controls[C] {Ctrl} is TIOControl then
        NewDesginPanelList.Add(DesignPanel.Controls[C]{Ctrl});
    end;
  end;

begin
  NewDesginPanelList := TList.Create;
  try
    ReorderPanels;
    Ini := TMemIniFile.Create('');
    try
      Ini.WriteInteger('Settings', 'NumFields', NewDesginPanelList.Count);
      if IOSettings.Title <> '' then
        Ini.WriteString('Settings', 'Title', FIOSettings.FTitle);

      if FIOSettings.FCancelEnabled <> Default then
        Ini.WriteInteger('Settings', 'CancelEnabled', Ord(FIOSettings.FCancelEnabled) - 1);
      if IOSettings.CancelShow <> Default then
        Ini.WriteInteger('Settings', 'CancelShow', Ord(FIOSettings.FCancelShow) - 1);
      if IOSettings.BackEnabled <> Default then
        Ini.WriteInteger('Settings', 'BackEnabled', Ord(FIOSettings.FBackEnabled) - 1);

      if FIOSettings.FCancelButtonText <> '' then
        Ini.WriteString('Settings', 'CancelButtonText', FIOSettings.FCancelButtonText);
      if FIOSettings.FNextButtonText <> '' then
        Ini.WriteString('Settings', 'NextButtonText', FIOSettings.FNextButtonText);
      if FIOSettings.FBackButtonText <> '' then
        Ini.WriteString('Settings', 'BackButtonText', FIOSettings.FBackButtonText);
      if FIOSettings.FRect <> '' then
         Ini.WriteString('Settings', 'Rect', FIOSettings.FRect);

      for C :={ NewDesginPanelList.Count downto 1} 1 to NewDesginPanelList.Count do
        TIOControl(NewDesginPanelList[C - 1]).SaveToIni(Ini, C);

      Lines.Clear;
      if FHeaderText = nil then
        Lines.Add(LangStr('IOHeaderComment', '; Ini file generated by the HM NIS Edit IO designer.'))
      else
        Lines.AddStrings(FHeaderText);
      Ini.GetStrings(Lines);
    finally
      Ini.Free;
    end;
  finally
    NewDesginPanelList.Free;
  end;
end;

procedure TIODesignerFrm.RTDesignerAfterSized(Sender: TObject);
var
  C: Integer;
begin
  MainFrm.IOCrtlPropList.Synchronize;
  SetModified(True);
  for C := 0 to RTDesigner.ControlCount - 1 do
    TIOControl(RTDesigner.Control[C]).Resized := True;
end;

procedure TIODesignerFrm.RTDesignerAfterMove(Sender: TObject);
begin
  MainFrm.IOCrtlPropList.Synchronize;
  SetModified(True);
end;

procedure TIODesignerFrm.RTDesignerRemoveControl(Sender: TObject;
  aControl: TControl);
begin
  MainFrm.IOCrtlPropList.CurObj := FIOSettings;
  SetModified(True);
end;

procedure TIODesignerFrm.DesignPanelResize(Sender: TObject);
var
  C: Integer;
begin
  if RTDesigner = nil then Exit;
  for C := 0 to DesignPanel.ControlCount - 1 do
  if DesignPanel.Controls[C] is TIOControl then
  with TIOControl(DesignPanel.Controls[C]) do
  begin
     UpdatePostions;
     Repaint;
  end;
  if RTDesigner.ControlCount > 0 then
    RTDesigner.UpdateSelection;
  MainFrm.UpdateStatus;
end;

procedure TIODesignerFrm.RTDesignerGetPopupMenu(Sender: TObject;
  var Menu: TPopupMenu);
begin
  Menu := MainFrm.DesignMenu;
end;

procedure TIODesignerFrm.CodeEditorChange(Sender: TObject);
begin
  SetModified(True);
end;

procedure TIODesignerFrm.CodeEditorStatusChange(Sender: TObject;
  Changes: TSynStatusChanges);
begin
  if (scModified in Changes) and CodeEditor.Modified then
    SetModified(True);
   MainFrm.UpdateStatus;
end;

procedure TIODesignerFrm.RTDesignerKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_ESCAPE) and (RTDesigner.ControlCount = 1) then
    MainFrm.IOCrtlPropList.CurObj := IOSettings;
end;

procedure TIODesignerFrm.UpdateOptions;
begin
  DesignPanel.GridX := DialogUnitsToPixelsX(MainFrm.Options.IOGridDims.X, DesignPanel.AvCharSize.X);
  DesignPanel.GridY := DialogUnitsToPixelsY(MainFrm.Options.IOGridDims.Y, DesignPanel.AvCharSize.Y); //;
  DesignPanel.FGridKind := MainFrm.Options.IOGridKind;
  DesignPanel.FGridColor := MainFrm.Options.IOGridColor;
  if MainFrm.Options.IOSnapToGrid then
  begin
    DesignPanel.RTDesigner.GridX := DesignPanel.GridX;
    DesignPanel.RTDesigner.GridY := DesignPanel.GridY;
  end else
  begin
    DesignPanel.RTDesigner.GridX := DesignPanel.DialogUnit.X;
    DesignPanel.RTDesigner.GridY := DesignPanel.DialogUnit.Y;
  end;
  InvalidateRect(DesignPanel.Handle, nil, True);
end;

procedure TIODesignerFrm.FormResize(Sender: TObject);
begin
  if MainFrm.Options.ShowIODimsKind in [sdWidthHeight, sdBoth] then
    MainFrm.IOCrtlPropList.Synchronize;
end;

procedure TIODesignerFrm.ResizeTo(const X, Y: Integer);
var
  DPXY: TPoint;
begin
  ShowWindow(Handle, SW_RESTORE);
  DPXY := GetDesignPanelXY;
  ClientWidth := ClientWidth + DialogUnitsToPixelsX(X - DPXY.X, DesignPanel.FAvCharSize.X);
  ClientHeight := ClientHeight + DialogUnitsToPixelsY(Y - DPXY.Y, DesignPanel.FAvCharSize.Y);
end;

end.
