object SearchFrm: TSearchFrm
  Left = 132
  Top = 160
  BorderStyle = bsDialog
  BorderWidth = 5
  ClientHeight = 201
  ClientWidth = 324
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object BuscarBtn: TButton
    Left = 136
    Top = 174
    Width = 91
    Height = 25
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object CancelarBtn: TButton
    Left = 232
    Top = 174
    Width = 91
    Height = 25
    Cancel = True
    ModalResult = 2
    TabOrder = 3
  end
  object SearchOptionsBox: TNewGroupBox
    Left = 0
    Top = 53
    Width = 177
    Height = 110
    TabOrder = 1
    object CaseSensitiveChk: TCheckBox
      Left = 6
      Top = 27
      Width = 168
      Height = 17
      TabOrder = 0
    end
    object WholeWordChk: TCheckBox
      Left = 6
      Top = 47
      Width = 168
      Height = 17
      TabOrder = 1
    end
    object SearchFromCursorChk: TCheckBox
      Left = 6
      Top = 67
      Width = 168
      Height = 17
      TabOrder = 2
      OnClick = SearchFromCursorChkClick
    end
    object SearchSelectedOnlyChk: TCheckBox
      Left = 6
      Top = 87
      Width = 168
      Height = 17
      TabOrder = 3
    end
  end
  object GroupBox1: TNewGroupBox
    Left = 0
    Top = 0
    Width = 321
    Height = 49
    TabOrder = 0
    object BuscarEdt: TComboBox
      Left = 8
      Top = 16
      Width = 305
      Height = 21
      ItemHeight = 13
      TabOrder = 0
    end
  end
  object DirectionRG: TNewGroupBox
    Left = 184
    Top = 56
    Width = 137
    Height = 73
    TabOrder = 4
    object DirectionRG1: TRadioButton
      Left = 8
      Top = 23
      Width = 121
      Height = 17
      Checked = True
      TabOrder = 0
      TabStop = True
    end
    object DirectionRG2: TRadioButton
      Left = 8
      Top = 44
      Width = 121
      Height = 17
      TabOrder = 1
    end
  end
end
