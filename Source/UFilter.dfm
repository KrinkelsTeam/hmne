object FilterFrm: TFilterFrm
  Left = 127
  Top = 77
  ActiveControl = DescriptionEdt
  BorderStyle = bsDialog
  BorderWidth = 5
  ClientHeight = 216
  ClientWidth = 429
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TStaticText
    Left = 0
    Top = 168
    Width = 8
    Height = 17
    Caption = '*'
    TabOrder = 7
  end
  object Label2: TStaticText
    Left = 0
    Top = 192
    Width = 8
    Height = 17
    Caption = '*'
    TabOrder = 8
  end
  object FilterList: TListView
    Left = 0
    Top = 0
    Width = 345
    Height = 158
    Columns = <
      item
        Width = 200
      end
      item
        Width = 110
      end>
    ColumnClick = False
    HideSelection = False
    ReadOnly = True
    RowSelect = True
    TabOrder = 0
    ViewStyle = vsReport
    OnSelectItem = FilterListSelectItem
  end
  object AceptarBtn: TButton
    Left = 352
    Top = 0
    Width = 75
    Height = 25
    Default = True
    ModalResult = 1
    TabOrder = 3
  end
  object CancelarBtn: TButton
    Left = 352
    Top = 32
    Width = 75
    Height = 25
    Cancel = True
    ModalResult = 2
    TabOrder = 4
  end
  object DescriptionEdt: TEdit
    Left = 104
    Top = 168
    Width = 241
    Height = 21
    TabOrder = 1
  end
  object FilterEdt: TEdit
    Left = 104
    Top = 192
    Width = 241
    Height = 21
    TabOrder = 2
  end
  object AddBtn: TButton
    Left = 352
    Top = 96
    Width = 75
    Height = 25
    TabOrder = 5
    OnClick = AddBtnClick
  end
  object RemoveBtn: TButton
    Left = 352
    Top = 128
    Width = 75
    Height = 25
    TabOrder = 6
    OnClick = RemoveBtnClick
  end
end
