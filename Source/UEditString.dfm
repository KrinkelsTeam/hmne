object EditStringsFrm: TEditStringsFrm
  Left = 47
  Top = 34
  BorderStyle = bsDialog
  BorderWidth = 5
  ClientHeight = 256
  ClientWidth = 399
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
  object Edit: TMemo
    Left = 0
    Top = 0
    Width = 399
    Height = 217
    Align = alTop
    ScrollBars = ssBoth
    TabOrder = 0
    WordWrap = False
  end
  object AceptarBtn: TButton
    Left = 244
    Top = 226
    Width = 75
    Height = 25
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object CancelarBtn: TButton
    Left = 324
    Top = 226
    Width = 75
    Height = 25
    Cancel = True
    ModalResult = 2
    TabOrder = 2
  end
end
