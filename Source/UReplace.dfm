inherited ReplaceFrm: TReplaceFrm
  Left = 90
  Top = 147
  ClientHeight = 256
  ClientWidth = 323
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited BuscarBtn: TButton
    Left = 40
    Top = 230
    TabOrder = 4
  end
  inherited CancelarBtn: TButton
    Top = 230
    TabOrder = 6
  end
  inherited SearchOptionsBox: TNewGroupBox
    Top = 109
    TabOrder = 2
  end
  inherited DirectionRG: TNewGroupBox
    Top = 109
    TabOrder = 3
  end
  object GroupBox2: TNewGroupBox
    Left = 0
    Top = 56
    Width = 321
    Height = 49
    TabOrder = 1
    object ReplaceEdt: TComboBox
      Left = 8
      Top = 16
      Width = 305
      Height = 21
      ItemHeight = 13
      TabOrder = 0
    end
  end
  object ReplaceAllBtn: TButton
    Left = 136
    Top = 230
    Width = 91
    Height = 25
    Cancel = True
    ModalResult = 10
    TabOrder = 5
  end
end
