object EditSimbolFrm: TEditSimbolFrm
  Left = 247
  Top = 283
  BorderStyle = bsDialog
  BorderWidth = 5
  Caption = '*'
  ClientHeight = 107
  ClientWidth = 286
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
  object Bevel1: TBevel
    Left = 0
    Top = 72
    Width = 286
    Height = 35
    Align = alBottom
    Shape = bsTopLine
  end
  object Label1: TStaticText
    Left = 0
    Top = 8
    Width = 8
    Height = 17
    Caption = '*'
    FocusControl = SimbEdt
    TabOrder = 4
  end
  object Label2: TStaticText
    Left = 0
    Top = 40
    Width = 8
    Height = 17
    Caption = '*'
    FocusControl = ValEdt
    TabOrder = 5
  end
  object SimbEdt: TEdit
    Left = 48
    Top = 8
    Width = 233
    Height = 21
    TabOrder = 0
  end
  object ValEdt: TEdit
    Left = 48
    Top = 40
    Width = 233
    Height = 21
    TabOrder = 1
  end
  object Button1: TButton
    Left = 208
    Top = 80
    Width = 75
    Height = 25
    Cancel = True
    Caption = '*'
    ModalResult = 2
    TabOrder = 2
  end
  object Button2: TButton
    Left = 120
    Top = 80
    Width = 75
    Height = 25
    Caption = '*'
    Default = True
    ModalResult = 1
    TabOrder = 3
  end
end
