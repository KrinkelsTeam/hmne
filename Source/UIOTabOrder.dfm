object IOTabOrderFrm: TIOTabOrderFrm
  Left = 153
  Top = 145
  BorderStyle = bsDialog
  BorderWidth = 5
  ClientHeight = 252
  ClientWidth = 309
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
  object NewGroupBox1: TNewGroupBox
    Left = 0
    Top = 0
    Width = 225
    Height = 249
    TabOrder = 0
    object ControlList: TListBox
      Left = 8
      Top = 16
      Width = 209
      Height = 225
      DragMode = dmAutomatic
      ItemHeight = 13
      TabOrder = 0
      OnDragDrop = ControlListDragDrop
      OnDragOver = ControlListDragOver
    end
  end
  object AceptarBtn: TButton
    Left = 232
    Top = 8
    Width = 75
    Height = 25
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object CancelarBtn: TButton
    Left = 232
    Top = 40
    Width = 75
    Height = 25
    Cancel = True
    ModalResult = 2
    TabOrder = 2
  end
  object UpBtn: TButton
    Left = 232
    Top = 88
    Width = 75
    Height = 25
    TabOrder = 3
    OnClick = UpBtnClick
  end
  object DownBtn: TButton
    Left = 232
    Top = 120
    Width = 75
    Height = 25
    TabOrder = 4
    OnClick = DownBtnClick
  end
end
