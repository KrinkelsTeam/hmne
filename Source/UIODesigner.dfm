object IODesignerFrm: TIODesignerFrm
  Left = 506
  Top = 179
  AutoScroll = False
  ClientHeight = 28
  ClientWidth = 104
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
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object Notebook: TNotebook
    Left = 0
    Top = 0
    Width = 104
    Height = 28
    Align = alClient
    TabOrder = 0
    object TPage
      Left = 0
      Top = 0
      Caption = 'Designer'
      object ParentDesignPanel: TPanel
        Left = 0
        Top = 0
        Width = 104
        Height = 28
        Align = alClient
        BevelOuter = bvNone
        BorderWidth = 7
        FullRepaint = False
        ParentColor = True
        TabOrder = 0
      end
    end
    object TPage
      Left = 0
      Top = 0
      Caption = 'Code'
      object CodeEditor: TSynMemo
        Left = 0
        Top = 0
        Width = 104
        Height = 28
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = []
        PopupMenu = MainFrm.EditPopup
        TabOrder = 0
        Gutter.Font.Charset = DEFAULT_CHARSET
        Gutter.Font.Color = clWindowText
        Gutter.Font.Height = -11
        Gutter.Font.Name = 'Terminal'
        Gutter.Font.Style = []
        Gutter.Width = 20
        RightEdge = 0
        OnChange = CodeEditorChange
        OnProcessCommand = SynEditProcessCommand
        OnStatusChange = CodeEditorStatusChange
        RemovedKeystrokes = <
          item
            Command = ecContextHelp
            ShortCut = 112
          end>
        AddedKeystrokes = <
          item
            Command = ecContextHelp
            ShortCut = 16496
          end>
      end
    end
  end
  object RTDesigner: TRTDesigner
    EditMode = True
    GrabHandleKind = gkDelphi
    GridX = 8
    GridY = 8
    KeySupportOptions.A = ksoNotActive
    KeySupportOptions.C = ksoNotActive
    KeySupportOptions.Del = ksoNotActive
    KeySupportOptions.Ins = ksoNotActive
    KeySupportOptions.N = ksoNotActive
    KeySupportOptions.V = ksoNotActive
    KeySupportOptions.X = ksoNotActive
    KeySupportOptions.Z = ksoNotActive
    Options = [rtdSnapToGrid]
    UndoLimit = 255
    Version = '2.0.11.29'
    AfterInsert = RTDesignerAfterInsert
    AfterMove = RTDesignerAfterMove
    AfterSized = RTDesignerAfterSized
    BeforeSelectControl = RTDesignerBeforeSelectControl
    OnBaseControlClick = RTDesignerBaseControlClick
    OnGetPopupMenu = RTDesignerGetPopupMenu
    OnInsertQuery = RTDesignerInsertQuery
    OnKeyDown = RTDesignerKeyDown
    OnRemoveControl = RTDesignerRemoveControl
  end
end
