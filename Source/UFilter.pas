{
  HM NIS Edit (c) 2003 Héctor Mauricio Rodríguez Segura <ranametal@users.sourceforge.net>
  For conditions of distribution and use, see license.txt

  File filter editor form
}
unit UFilter;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls;

type
  TFilterFrm = class(TForm)
    FilterList: TListView;
    AceptarBtn: TButton;
    CancelarBtn: TButton;
    Label1: TStaticText;
    DescriptionEdt: TEdit;
    Label2: TStaticText;
    FilterEdt: TEdit;
    AddBtn: TButton;
    RemoveBtn: TButton;
    procedure FilterListSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure AddBtnClick(Sender: TObject);
    procedure RemoveBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    procedure InitItems(FilterString: String);
    function GetFilterString: String;
  end;

{var
  FilterFrm: TFilterFrm;}

function EditFilter(var Filter: String): Boolean;
implementation

uses Utils;

{$R *.DFM}

function EditFilter(var Filter: String): Boolean;
begin
  with TFilterFrm.Create(Application) do
  try
    InitItems(Filter);
    Result := ShowModal = mrOk;
    if Result then
      Filter := GetFilterString;
  finally
    Free;
  end;
end;

procedure TFilterFrm.FilterListSelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
begin
  if Item <> nil then
  if Selected then
  begin
    DescriptionEdt.Text := Item.Caption;
    FilterEdt.Text := Item.SubItems[0];
  end else
  begin
    Item.Caption := DescriptionEdt.Text;
    Item.SubItems[0] := FilterEdt.Text;
  end;
end;

function TFilterFrm.GetFilterString: String;
var
  C: Integer;
begin
  Result := '';
  // This update the item if it was modified
  FilterListSelectItem(FilterList, FilterList.Selected, False);
  for C := 0 to FilterList.Items.Count - 1 do
  with FilterList.Items[C] do
    Result := Result + Caption + '|' + SubItems[0] + '|';
  if (Result <> '') and (AnsiLastChar(Result)^ = '|') then
    SetLength(Result, Length(Result) - 1);  
end;

procedure TFilterFrm.InitItems(FilterString: String);
var
  Item: TListItem;
begin
  FilterList.Items.BeginUpdate;
  try
    FilterList.Items.Clear;
    while FilterString <> '' do
    with FilterList.Items.Add do
    begin
      Caption := ExtractStr(FilterString, '|');
      SubItems.Add(ExtractStr(FilterString, '|'));
    end;
    // add default item
    if FilterList.Items.Count = 0 then
    begin
      Item := FilterList.Items.Add;
      Item.SubItems.Add('');
      FilterList.Selected := Item;
    end;
    FilterList.Selected := FilterList.Items[0];
  finally
    FilterList.Items.EndUpdate;
  end;
end;

procedure TFilterFrm.AddBtnClick(Sender: TObject);
var
  Item: TListItem;
begin
  Item := FilterList.Items.Add;
  Item.SubItems.Add('');
  FilterList.Selected := Item;
  DescriptionEdt.SetFocus;
end;

procedure TFilterFrm.RemoveBtnClick(Sender: TObject);
var
  I: Integer;
begin
  if FilterList.Selected <> nil then
  begin
    I := FilterList.Selected.Index;
    FilterList.Selected.Delete;
    if I >= FilterList.Items.Count then Dec(I);
    if I in [0..FilterList.Items.Count-1] then
      FilterList.Selected := FilterList.Items[I]
    else begin
      DescriptionEdt.Text := '';
      FilterEdt.Text := '';
    end;
  end;
end;

procedure TFilterFrm.FormCreate(Sender: TObject);
begin
  InitFont(Font);
  Caption := LangStr('EditFilterCaption');
  AceptarBtn.Caption := LangStr('OK');
  CancelarBtn.Caption := LangStr('Cancel');
  FilterList.Columns[0].Caption := LangStr('FilterDescription');
  FilterList.Columns[1].Caption := LangStr('Filter');
  AddBtn.Caption := LangStr('AddFilter');
  RemoveBtn.Caption := LangStr('RemoveFilter');
  Label1.Caption := LangStr('FilterDescription');
  Label2.Caption := LangStr('Filter');
end;

end.
