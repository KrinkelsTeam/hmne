object EditLinkFrm: TEditLinkFrm
  Left = 176
  Top = 233
  BorderStyle = bsDialog
  BorderWidth = 5
  Caption = '*'
  ClientHeight = 110
  ClientWidth = 336
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TStaticText
    Left = 0
    Top = 8
    Width = 8
    Height = 17
    Caption = '*'
    FocusControl = LinkEdt
    TabOrder = 4
  end
  object Label2: TStaticText
    Left = 0
    Top = 40
    Width = 8
    Height = 17
    Caption = '*'
    FocusControl = DestinoEdt
    TabOrder = 5
  end
  object LinkEdt: TComboBox
    Left = 80
    Top = 8
    Width = 249
    Height = 21
    ItemHeight = 13
    TabOrder = 0
    OnChange = LinkEdtChange
  end
  object DestinoEdt: TComboBox
    Left = 80
    Top = 40
    Width = 249
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 1
    OnChange = DestinoEdtChange
  end
  object Button1: TButton
    Left = 256
    Top = 83
    Width = 75
    Height = 25
    Cancel = True
    ModalResult = 2
    TabOrder = 3
  end
  object Button2: TButton
    Left = 176
    Top = 83
    Width = 75
    Height = 25
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
end
