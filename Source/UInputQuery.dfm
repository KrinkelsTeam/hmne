object InputQueryFrm: TInputQueryFrm
  Left = 174
  Top = 146
  BorderStyle = bsDialog
  Caption = '*'
  ClientHeight = 89
  ClientWidth = 261
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TStaticText
    Left = 16
    Top = 8
    Width = 233
    Height = 13
    AutoSize = False
    Caption = '*'
    FocusControl = Edit1
    TabOrder = 3
  end
  object Edit1: TEdit
    Left = 16
    Top = 24
    Width = 233
    Height = 21
    TabOrder = 0
  end
  object Button1: TButton
    Left = 176
    Top = 56
    Width = 75
    Height = 25
    Cancel = True
    Caption = '*'
    ModalResult = 2
    TabOrder = 1
  end
  object Button2: TButton
    Left = 96
    Top = 56
    Width = 75
    Height = 25
    Caption = '*'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
end
