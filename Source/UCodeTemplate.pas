{
  HM NIS Edit (c) 2003 Héctor Mauricio Rodríguez Segura <ranametal@users.sourceforge.net>
  For conditions of distribution and use, see license.txt

  Code templates form

}
unit UCodeTemplate;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  TB2Item, TB2Dock, TB2Toolbar, StdCtrls, SynEdit, ActnList, ComCtrls, Menus,
  TBX, TBXExtItems, NewGroupBox;

type
  TCodeTemplateFrm = class(TForm)
    CancelarBtn: TButton;
    AceptarBtn: TButton;
    GroupBox1: TNewGroupBox;
    ListBox: TListBox;
    TBToolbar1: TTBXToolbar;
    TBItem2: TTBXItem;
    TBItem1: TTBXItem;
    TBItem3: TTBXItem;
    GroupBox2: TNewGroupBox;
    Edit: TSynEdit;
    ActionList1: TActionList;
    NewTemplateCmd: TAction;
    EditTemplateCmd: TAction;
    DeleteTemplateCmd: TAction;
    GroupBox3: TNewGroupBox;
    HotKey: THotKey;
    procedure FormCreate(Sender: TObject);
    procedure ListBoxClick(Sender: TObject);
    procedure EditChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure CheckIndex(Sender: TObject);
    procedure NewTemplateCmdExecute(Sender: TObject);
    procedure EditTemplateCmdExecute(Sender: TObject);
    procedure DeleteTemplateCmdExecute(Sender: TObject);
    procedure ListBoxDblClick(Sender: TObject);
    procedure EditEnter(Sender: TObject);
    procedure EditExit(Sender: TObject);
  private
    procedure HotKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure HotKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  public
    { Public declarations }
  end;

{var
  CodeTemplateFrm: TCodeTemplateFrm;}

implementation

uses Utils, UMain;

{$R *.DFM}

type
  TAccessHotKey = class(THotKey);

procedure TCodeTemplateFrm.FormCreate(Sender: TObject);
var
  C: Integer;
begin
  InitFont(Font);
  Caption := LangStr('CodeTemplateCaption');
  GroupBox1.Caption := LangStr('TemplateNames');
  GroupBox2.Caption := LangStr('TemplateCode');
  AceptarBtn.Caption := LangStr('OK');
  CancelarBtn.Caption := LangStr('Cancel');
  GroupBox3.Caption := LangStr('AutoCompleteShortCut');

  MainFrm.SynAutoComplete.GetTokenList(ListBox.Items);
  Edit.Highlighter := MainFrm.SynNSIS;

  for C := 0 to ListBox.Items.Count - 1 do
  begin
    ListBox.Items.Objects[C] := TStringList.Create;
    TStringList(ListBox.Items.Objects[C]).Text :=
      MainFrm.SynAutoComplete.GetTokenValue(ListBox.Items[C]);
  end;

  HotKey.HotKey := MainFrm.SynAutoComplete.ShortCut;
  TAccessHotKey(HotKey).OnKeyDown := HotKeyDown;
  TAccessHotKey(HotKey).OnKeyUp := HotKeyUp;

  if ListBox.Items.Count > 0 then
    ListBox.ItemIndex := 0;
  ListBoxClick(ListBox);
end;


procedure TCodeTemplateFrm.ListBoxClick(Sender: TObject);
begin
  if ListBox.ItemIndex >= 0 then
    Edit.Lines.Assign(TStringList(ListBox.Items.Objects[ListBox.ItemIndex]))
  else
    Edit.Lines.Clear;

  Edit.Color := clWindow;
  Edit.Enabled := ListBox.Items.Count > 0;
  Edit.ParentColor := not Edit.Enabled;
end;

procedure TCodeTemplateFrm.EditChange(Sender: TObject);
begin
  TStringList(ListBox.Items.Objects[ListBox.ItemIndex]).Text := Edit.Lines.Text;
end;

procedure TCodeTemplateFrm.FormDestroy(Sender: TObject);
var
  C, I: Integer;
begin
  if ModalResult = mrOK then
  begin
    with MainFrm.SynAutoComplete do
    begin
      ShortCut := HotKey.HotKey;
      AutoCompleteList.Clear;
      for C := 0 to ListBox.Items.Count - 1 do
      begin
        AutoCompleteList.Add(ListBox.Items[C]);
        for I := 0 to TStringList(ListBox.Items.Objects[C]).Count - 1 do
          AutoCompleteList.Add('=' + TStringList(ListBox.Items.Objects[C])[I]);
      end;
    end;
  end;

  for C := 0 to ListBox.Items.Count - 1 do
    ListBox.Items.Objects[C].Free;
end;

procedure TCodeTemplateFrm.CheckIndex(Sender: TObject);
begin
  TAction(Sender).Enabled := ListBox.ItemIndex >= 0;
end;

procedure TCodeTemplateFrm.NewTemplateCmdExecute(Sender: TObject);
var
  S: String;
begin
  if InputQuery(LangStr('NewTemplate'), LangStr('EdittemplatePrompt'), S) then
  begin
    if (ListBox.Items.IndexOf(S) < 0) and (S <> '') then
    begin
      ListBox.ItemIndex := ListBox.Items.AddObject(S, TStringList.Create);
      ListBoxClick(ListBox);
      Edit.SetFocus;
    end else
      WarningDlg(LangStrFormat('DuplicateTemplateName', [S]));
  end;
end;

procedure TCodeTemplateFrm.EditTemplateCmdExecute(Sender: TObject);
var
  S: String;
  I: Integer;
begin
  S := ListBox.Items[ListBox.ItemIndex];
  if InputQuery(LangStr('EditTemplate'), LangStr('EditTemplatePrompt'), S) then
  begin
    I := ListBox.Items.IndexOf(S);
    if ((I < 0) or (I = ListBox.ItemIndex)) and (S <> '') then
       ListBox.Items[ListBox.ItemIndex] := S
     else
       WarningDlg(LangStrFormat('DuplicateTemplateName', [S]));
  end;
end;

procedure TCodeTemplateFrm.DeleteTemplateCmdExecute(Sender: TObject);
var
  I: Integer;
begin
  I := ListBox.ItemIndex;
  ListBox.Items.Objects[I].Free;
  ListBox.Items.Delete(I);
  if I < ListBox.Items.Count then
    ListBox.ItemIndex := I
  else
    ListBox.ItemIndex := ListBox.Items.Count - 1;
  ListBoxClick(ListBox);
end;

procedure TCodeTemplateFrm.ListBoxDblClick(Sender: TObject);
begin
  EditTemplateCmd.Execute;
end;

procedure TCodeTemplateFrm.EditEnter(Sender: TObject);
begin
  AceptarBtn.Default := False;
end;

procedure TCodeTemplateFrm.EditExit(Sender: TObject);
begin
  AceptarBtn.Default := True;
end;

var SaveHotKey: TShortCut;

procedure TCodeTemplateFrm.HotKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  SaveHotKey := ShortCut(Key, Shift);
  Abort;
end;

procedure TCodeTemplateFrm.HotKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  HotKey.HotKey := SaveHotKey;
end;

end.
