object StartupFrm: TStartupFrm
  Left = 135
  Top = 72
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = '*'
  ClientHeight = 327
  ClientWidth = 361
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object StartupChk: TCheckBox
    Left = 8
    Top = 300
    Width = 201
    Height = 17
    TabStop = False
    Caption = '*'
    TabOrder = 2
  end
  object AceptarBtn: TButton
    Left = 204
    Top = 297
    Width = 73
    Height = 23
    Caption = '*'
    Default = True
    ModalResult = 1
    TabOrder = 3
  end
  object CancelarBtn: TButton
    Left = 284
    Top = 297
    Width = 73
    Height = 23
    Cancel = True
    Caption = '*'
    ModalResult = 2
    TabOrder = 4
  end
  object GroupBox1: TNewGroupBox
    Left = 8
    Top = 8
    Width = 345
    Height = 61
    TabOrder = 0
    object NewImage: TImage
      Left = 12
      Top = 19
      Width = 16
      Height = 16
      AutoSize = True
      Picture.Data = {
        07544269746D6170F6000000424DF60000000000000076000000280000001000
        0000100000000100040000000000800000000000000000000000100000001000
        000000000000000080000080000000808000800000008000800080800000C0C0
        C000808080000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFF
        FF007777777777777777777777777777777777700000000000777770FFFFFFFF
        F0777770FFFFFFFFF0777770FFFFFFFFF0777770FFFFFFFFF0777770FFFFFFFF
        F0777770FFFFFFFFF0777770FFFFFFFFF0777770FFFFFFFFF0777770FFFFFF00
        00777770FFFFFF0F07777770FFFFFF0077777770000000077777777777777777
        7777}
      Transparent = True
    end
    object EmptyChk: TRadioButton
      Left = 40
      Top = 16
      Width = 297
      Height = 17
      Caption = '*'
      TabOrder = 0
      OnClick = RadioButtonClick
      OnDblClick = DblClickChk
    end
    object WizardChk: TRadioButton
      Left = 40
      Top = 36
      Width = 297
      Height = 17
      Caption = '*'
      TabOrder = 1
      OnClick = RadioButtonClick
      OnDblClick = DblClickChk
    end
  end
  object GroupBox2: TNewGroupBox
    Left = 8
    Top = 76
    Width = 345
    Height = 213
    TabOrder = 1
    object OpenImage: TImage
      Left = 12
      Top = 19
      Width = 18
      Height = 18
      AutoSize = True
      Picture.Data = {
        07544269746D61704E010000424D4E0100000000000076000000280000001200
        0000120000000100040000000000D80000000000000000000000100000001000
        0000000000000000800000800000008080008000000080008000808000008080
        8000C0C0C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFF
        FF00888888888888888888000000888888888888888888000000888888888888
        88888800000080000000000088888800000080033333333308888800000080B0
        3333333330888800000080FB0333333333088800000080BFB033333333308800
        000080FBFB00000000000800000080BFBFBFBFB088888800000080FBFBFBFBF0
        88888800000080BFB00000008888880000008800088888888000880000008888
        8888888888008800000088888888808880808800000088888888880008888800
        0000888888888888888888000000888888888888888888000000}
      Transparent = True
    end
    object OpenChk: TRadioButton
      Left = 40
      Top = 20
      Width = 273
      Height = 17
      Caption = '*'
      TabOrder = 0
      OnClick = RadioButtonClick
      OnDblClick = DblClickChk
    end
    object FilesLst: TListBox
      Left = 44
      Top = 44
      Width = 293
      Height = 157
      ItemHeight = 13
      MultiSelect = True
      TabOrder = 1
      OnClick = FilesLstClick
      OnDblClick = DblClickChk
    end
  end
end
