object EditFrm: TEditFrm
  Left = 435
  Top = 181
  Width = 175
  Height = 208
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  OnActivate = FormActivate
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 0
    Top = 76
    Width = 167
    Height = 3
    Cursor = crVSplit
    Align = alBottom
    AutoSnap = False
    MinSize = 1
    ResizeStyle = rsUpdate
  end
  object Edit: TSynMemo
    Left = 0
    Top = 0
    Width = 167
    Height = 76
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    ParentShowHint = False
    PopupMenu = MainFrm.EditPopup
    ShowHint = False
    TabOrder = 0
    OnDblClick = EditDblClick
    OnKeyDown = EditKeyDown
    OnKeyPress = EditKeyPress
    OnKeyUp = EditKeyUp
    OnMouseDown = EditMouseDown
    OnMouseMove = EditMouseMove
    Gutter.Font.Charset = DEFAULT_CHARSET
    Gutter.Font.Color = clWindowText
    Gutter.Font.Height = -11
    Gutter.Font.Name = 'Terminal'
    Gutter.Font.Style = []
    Gutter.Width = 20
    RightEdge = 0
    ScrollHintFormat = shfTopToBottom
    TabWidth = 2
    WantTabs = True
    OnChange = EditChange
    OnContextHelp = EditContextHelp
    OnProcessCommand = SynEditProcessCommand
    OnSpecialLineColors = EditSpecialLineColors
    OnStatusChange = EditStatusChange
    RemovedKeystrokes = <>
    AddedKeystrokes = <
      item
        Command = ecContextHelp
        ShortCut = 8304
      end>
  end
  object LogBox: TRichEdit
    Left = 0
    Top = 79
    Width = 167
    Height = 102
    Align = alBottom
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    ParentColor = True
    ParentFont = False
    PopupMenu = MainFrm.EditPopup
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 1
    WordWrap = False
    OnKeyDown = LogBoxKeyDown
  end
end
