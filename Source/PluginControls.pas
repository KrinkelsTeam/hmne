{
  HM NIS Edit (c) 2003 Héctor Mauricio Rodríguez Segura <ranametal@users.sourceforge.net>
  For conditions of distribution and use, see license.txt

  Control classes for use with plugins

}
unit PluginControls;

interface
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Menus, TB2Item, TB2Dock,
  TBX, ActnList, ImgList, PluginsInt;

type
  TTBXPluginToolbar = class(TTBXToolBar)
  private
    FVisibilityItem: TTBXVisibilityToggleItem;
    procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;
  public
    constructor CreateTB(const aName, aCaption: String);
    procedure UpdateDockedPos;
  end;

  TTBXPluginItem = class(TTBXItem)
  private
    FData: TTBItemData;
    function GetImageList: TImageList;
    procedure SetData(const Data: TTBItemData);
    procedure SetState(const Value: Integer);
    function GetState: Integer;
    procedure NotificationProc(Sender: TTBCustomItem; Relayed: Boolean;
    Action: TTBItemChangedAction; Index: Integer; Item: TTBCustomItem);
  public
    constructor CreateItem(Data: PTBItemData);
    destructor Destroy; override;

    procedure Click; override;
    procedure InitiateAction; override;

    property Data: TTBItemData read FData write SetData;
    property State: Integer read GetState write SetState;
  end;

function GetTBItemState(Item: TTBCustomItem): Integer;
implementation
uses
  UMain, Utils;

function GetTBItemState(Item: TTBCustomItem): Integer;
begin
  Result := 0;
  if not (Item is TTBXPluginItem) then
    Item.InitiateAction;
  if Item.Checked then Result := Result or TBITEM_STATE_CHECKED;
  if Item.Enabled then Result := Result or TBITEM_STATE_ENABLED;
  if Item.Visible then Result := Result or TBITEM_STATE_VISIBLE;
end;

{ TTBXPluginItem }

var
  ImageListList: TList = nil;

procedure TTBXPluginItem.Click;
begin
  if Assigned(FData.OnClick) then
    FData.OnClick(PChar(Name));
end;

constructor TTBXPluginItem.CreateItem(Data: PTBItemData);
begin
  inherited Create(MainFrm);
  RegisterNotification(NotificationProc);
  SetData(Data^);
end;

destructor TTBXPluginItem.Destroy;
begin
  UnregisterNotification(NotificationProc);
  inherited Destroy;
end;

function TTBXPluginItem.GetImageList: TImageList;
var
  C: Integer;
begin
  Result := nil;

  if FData.ImgeListHandle = 0 then
    Exit;

  if ImageListList = nil then
  begin
    ImageListList := TList.Create;
    ImageListList.Add(MainFrm.MainImages);
  end;

  for C := 0 to ImageListList.Count - 1 do
  begin
    Result := TImageList(ImageListList[C]);
    if Result.HandleAllocated and (Result.Handle = FData.ImgeListHandle) then
      Exit;
  end;

  Result := TImageList.Create(Self);
  Result.Handle := FData.ImgeListHandle;
  Result.ShareImages := True;
  ImageListList.Add(Result);
end;

function TTBXPluginItem.GetState: Integer;
begin
  Result := GetTBItemState(Self);
end;

procedure TTBXPluginItem.InitiateAction;
begin
  if Assigned(FData.OnUpdate) then
    FData.OnUpdate(PChar(Name));
end;

procedure TTBXPluginItem.NotificationProc(Sender: TTBCustomItem;
  Relayed: Boolean; Action: TTBItemChangedAction; Index: Integer;
  Item: TTBCustomItem);
begin
  if not Relayed then
  case Action of
    tbicInserted: ItemStyle := ItemStyle + [tbisSubMenu, tbisSubitemsEditable];
    tbicDeleting: if Count = 1 then
                    ItemStyle := ItemStyle - [tbisSubMenu, tbisSubitemsEditable];
  end;
end;

procedure TTBXPluginItem.SetData(const Data: TTBItemData);
begin
  CopyMemory(@FData, @Data, SizeOf(TTBItemData));
  Name := FData.Name;
  Caption := FData.Caption;
  ShortCut := TextToShortCut(FData.ShortCut);
  Hint := Caption + '|' + FData.Hint;
  Images := GetImageList;
  if Images <> nil then
    ImageIndex := FData.ImageIndex
  else
    ImageIndex := -1;
end;

procedure TTBXPluginItem.SetState(const Value: Integer);
begin
  Checked := Value and TBITEM_STATE_CHECKED = TBITEM_STATE_CHECKED;
  Enabled := Value and TBITEM_STATE_ENABLED = TBITEM_STATE_ENABLED;
  Visible := Value and TBITEM_STATE_VISIBLE = TBITEM_STATE_VISIBLE;
end;

{ TTBXPluginToolbar }

procedure TTBXPluginToolbar.CMTextChanged(var Message: TMessage);
begin
  FVisibilityItem.Control := nil;
  FVisibilityItem.Caption := '';
  FVisibilityItem.Control := Self;
end;

constructor TTBXPluginToolbar.CreateTB(const aName, aCaption: String);
begin
  inherited Create(MainFrm);
  FVisibilityItem := TTBXVisibilityToggleItem.Create(Self);
  Name := aName;
  MainFrm.vmToolBarsItem.Add(FVisibilityItem);
  SmoothDrag := MainFrm.Options.SmoothToolBar;
  ChevronHint := LangStr('MoreButtons');
  Caption := aCaption;
  UpdateDockedPos;
end;

procedure TTBXPluginToolbar.UpdateDockedPos;
var
  LastToolBar: TTBCustomDockableWindow;
begin
  if MainFrm.TopDock.ToolbarCount > 0 then
  begin
    LastToolBar :=  MainFrm.TopDock.Toolbars[ MainFrm.TopDock.ToolbarCount - 1];
    DockPos := LastToolbar.Width + LastToolbar.DockPos;
    DockRow := LastToolbar.DockRow;
    if DockPos + Width > MainFrm.TopDock.Width then
    begin
      DockPos := 0;
      DockRow := DockRow + 1;
    end;
    CurrentDock := MainFrm.TopDock;
  end;
end;

initialization
finalization
  ImageListList.Free;
end.
