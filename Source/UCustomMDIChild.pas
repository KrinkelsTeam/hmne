{
  HM NIS Edit (c) 2003 Héctor Mauricio Rodríguez Segura <ranametal@users.sourceforge.net>
  For conditions of distribution and use, see license.txt

  Base class for MDI child windows

}
unit UCustomMDIChild;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  SynEdit, SynEditKeyCmds, ComCtrls;

type
  TCustomMDIChild = class(TForm)
    procedure SynEditProcessCommand(Sender: TObject;
      var Command: TSynEditorCommand; var AChar: Char; Data: Pointer);
  private
    FFileName: String;
    FModified: Boolean;
    FReadOnly: Boolean;
    FUseHighLighter: Boolean;
    FFileTime: Integer;
    FNode: TTreeNode;
    FPromting: Boolean;
    FIsClonsing: Boolean;
    procedure SetUseHighLighter(const Value: Boolean);
    procedure WMLangSet(var Msg: TMessage); message WM_USER + $1003;
    procedure WMMDIActivate(var Message: TWMMDIActivate); message WM_MDIACTIVATE;
  protected
    FDefExt: String;
    procedure DoClose(var Action: TCloseAction); override;
    function GetSynEdit: TSynEdit; virtual;
    procedure ChangeCurDir;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function CloseQuery: Boolean; override;
    procedure Activate; override;
    function FileModifiedExternal: Boolean;
    procedure UpdateEditor; virtual;
    procedure SaveFile(AFileName: String); virtual;
    procedure LoadFile(AFileName: String); virtual;
    function GetIconIndex: Integer;
    procedure ReloadFile;
    procedure InitValues;

    property UseHighLighter: Boolean read FUseHighLighter write SetUseHighLighter;
    property FileName: string read FFileName write FFileName;
    property SynEdit: TSynEdit read GetSynEdit;
    property Modified: Boolean read FModified write FModified;
    property ReadOnly: Boolean read FReadOnly write FReadOnly;
    property FileTime: Integer read FFileTime write FFileTime;
    property Node: TTreeNode read FNode write FNode;
  end;

var
  SinTituloCount: Integer = 0;

implementation

uses ShellAPI, UMain, Utils;

{$R *.DFM}

{ TCustomMDIChild }

procedure TCustomMDIChild.Activate;
begin
  if FileModifiedExternal then
    ReloadFile;
  MainFrm.WinList.Selected := FNode;
  MainFrm.UpdateStatus;
  ChangeCurDir;
  inherited Activate;
end;

procedure TCustomMDIChild.ChangeCurDir;
begin
  if DirExists(ExtractFileDir(FileName)) then
    try ChDir(ExtractFileDir(FileName)); except end;
end;

function TCustomMDIChild.CloseQuery: Boolean;

  function GetFileName: String;
  begin
    Result := FFileName;
    if Result = '' then Result := Caption;
  end;

begin
  Result := inherited CloseQuery;
  if Result and FModified then
  begin
    Show;
    case QuestionDlg(LangStrFormat('SaveChanges', [GetFileName]), mbQuestionCancel) of
      mrYes: MainFrm.SaveMDIChild(Self);
      mrNo: { NADA };
      mrCancel: Result := False;
    end;
  end;
end;

constructor TCustomMDIChild.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  InitFont(Font);
  FUseHighLighter := MainFrm.UseHighLighter;
  FNode := MainFrm.WinList.Items.Add(nil, '');
  FNode.Data := Self;

  if (MainFrm.MaximizeFirst) and (MainFrm.MDIChildCount = 1) and
   (MainFrm.FirstEdit = nil) then  WindowState := wsMaximized;
end;

destructor TCustomMDIChild.Destroy;
begin
  FNode.Free;
  if MainFrm.LastUsedWindow = Self then
    MainFrm.LastUsedWindow := nil;
  inherited Destroy;
end;

procedure TCustomMDIChild.DoClose(var Action: TCloseAction);
begin
  Action := caFree;
  inherited DoClose(Action);
  if Action <> caNone then
    FIsClonsing := True;
end;

function TCustomMDIChild.FileModifiedExternal: Boolean;
begin
  Result := False;
  if FPromting then Exit;
  FPromting := True;
  try
    Result := (FFileName <> '') and FileExists(FFileName) and (FileAge(FFileName) <> FFileTime) and
      (QuestionDlg(LangStrFormat('FileModified', [FileName])) = mrYes);
    FFileTime := FileAge(FFileName);
  finally
    FPromting := False;
  end;
end;

function TCustomMDIChild.GetIconIndex: Integer;
begin
  if FFileName = '' then
    Result := ShellIconIndex('foo' + FDefExt)
  else
    Result := ShellIconIndex(FFileName);
end;

function TCustomMDIChild.GetSynEdit: TSynEdit;
begin
  Result := nil;
end;

procedure TCustomMDIChild.InitValues;
begin
  if FileName <> '' then
  begin
    Caption := ExtractFileName(FileName);
    MainFrm.SystemImageList.GetIcon(ShellIconIndex(FileName), Icon);
    FileTime := FileAge(FileName);
  end else
  begin
    Inc(SinTituloCount);
    Caption := LangStrFormat('Untitled', [SinTituloCount]);
  end;
  FReadOnly := (FileName <> '') and FileExists(FileName) and
      ((FileGetAttr(FileName) and faReadOnly) = faReadOnly);
  UpdateEditor;
end;

procedure TCustomMDIChild.LoadFile(AFileName: String);
begin
  FFileName := AFileName;
end;

procedure TCustomMDIChild.ReloadFile;
var
  SynEdit: TSynEdit;
  CaretPos: TPoint;
  TopLine, LeftChar: Integer;
begin
  TopLine := 0;
  LeftChar := 0;
  SynEdit := GetSynEdit;
  if SynEdit <> nil then
  begin
    CaretPos := SynEdit.CaretXY;
    TopLine := SynEdit.TopLine;
    LeftChar := SynEdit.LeftChar;
  end;
  LoadFile(FFileName);
  if SynEdit <> nil then
  begin
    SynEdit.CaretXY := CaretPos;
    SynEdit.LeftChar := LeftChar;
    SynEdit.TopLine := TopLine;
  end;
end;

procedure TCustomMDIChild.SaveFile(AFileName: String);
begin
  FFileName := AFileName;
end;

procedure TCustomMDIChild.SetUseHighLighter(const Value: Boolean);
begin
  if Value <> FUseHighLighter then
  begin
    FUseHighLighter := Value;
    UpdateEditor;
  end;
end;

procedure TCustomMDIChild.UpdateEditor;
begin
  FNode.ImageIndex := GetIconIndex;
  FNode.SelectedIndex := FNode.ImageIndex;
  FNode.Text := Caption;
  if GetSynEdit <> nil then
  with GetSynEdit do
  begin
    ReadOnly := FReadOnly;
    if SearchEngine = nil then
      SearchEngine := MainFrm.SynEditSearchEngine;
  end;
  ChangeCurDir;
end;

procedure TCustomMDIChild.WMLangSet(var Msg: TMessage);
begin
  InitFont(Font);
end;

procedure TCustomMDIChild.SynEditProcessCommand(Sender: TObject;
  var Command: TSynEditorCommand; var AChar: Char; Data: Pointer);
begin
  if (Command = ecChar) and TSynEdit(Sender).ReadOnly and  (AChar >= #32) and (AChar <> #127) then
    Beep;
end;

procedure TCustomMDIChild.WMMDIActivate(var Message: TWMMDIActivate);
begin
  if (Message.DeactiveWnd = Handle) and not FIsClonsing then
    MainFrm.LastUsedWindow := Self;
  inherited;
end;

end.
