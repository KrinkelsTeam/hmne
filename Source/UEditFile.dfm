object EditFileFrm: TEditFileFrm
  Left = 117
  Top = 111
  BorderStyle = bsDialog
  BorderWidth = 5
  ClientHeight = 198
  ClientWidth = 340
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
    Left = 0
    Top = 0
    Width = 8
    Height = 17
    Caption = '*'
    TabOrder = 6
  end
  object Label2: TStaticText
    Left = 0
    Top = 48
    Width = 8
    Height = 17
    Caption = '*'
    TabOrder = 7
  end
  object OrigenEdt: TEdit
    Left = 0
    Top = 16
    Width = 307
    Height = 21
    TabOrder = 0
  end
  object Button1: TButton
    Left = 312
    Top = 16
    Width = 25
    Height = 21
    Caption = '...'
    TabOrder = 1
    OnClick = Button1Click
  end
  object DestinoEdt: TComboBox
    Left = 0
    Top = 64
    Width = 337
    Height = 21
    ItemHeight = 13
    TabOrder = 2
  end
  object Button2: TButton
    Left = 264
    Top = 168
    Width = 75
    Height = 25
    Cancel = True
    Caption = '*'
    ModalResult = 2
    TabOrder = 3
  end
  object Button3: TButton
    Left = 184
    Top = 168
    Width = 75
    Height = 25
    Caption = '*'
    Default = True
    ModalResult = 1
    TabOrder = 4
  end
  object NewGroupBox1: TNewGroupBox
    Left = 0
    Top = 96
    Width = 337
    Height = 57
    TabOrder = 5
    object OverwriteChk: TComboBox
      Left = 16
      Top = 24
      Width = 305
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 0
    end
  end
  object AbrirDlg: TOpenDialog
    Options = [ofHideReadOnly, ofAllowMultiSelect, ofEnableSizing]
    Left = 104
    Top = 168
  end
end
