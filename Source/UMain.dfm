object MainFrm: TMainFrm
  Left = 0
  Top = 0
  Width = 640
  Height = 480
  Color = clAppWorkSpace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIForm
  KeyPreview = True
  OldCreateOrder = False
  ShowHint = True
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object TopDock: TTBXDock
    Left = 0
    Top = 0
    Width = 632
    Height = 62
    object tbMenu: TTBXToolbar
      Left = 0
      Top = 0
      Caption = '*'
      CloseButton = False
      FullSize = True
      Images = MainImages
      MenuBar = True
      ProcessShortCuts = True
      ShrinkMode = tbsmWrap
      TabOrder = 0
      object FileMenu: TTBXSubmenuItem
        OnClick = FileMenuClick
        object fmNewScriptItem: TTBXItem
          Action = NewScriptCmd
        end
        object fmWizardItem: TTBXItem
          Action = WizardCmd
        end
        object fmNewTemplateItem: TTBXItem
          Action = NewTemplateCmd
        end
        object fmNewIOItem: TTBXItem
          Action = NewIOCmd
        end
        object fmSeparator1: TTBXSeparatorItem
        end
        object fmOpenItem: TTBXItem
          Action = OpenFileCmd
        end
        object fmReopenItem: TTBXSubmenuItem
          object TBMRUListItem3: TTBXMRUListItem
            MRUList = MRU
          end
        end
        object fmSeparator2: TTBXSeparatorItem
        end
        object fmSaveItem: TTBXItem
          Action = SaveFileCmd
        end
        object fmSaveAsItem: TTBXItem
          Action = SaveFileAsCmd
        end
        object fmSeparator3: TTBXSeparatorItem
        end
        object fmPrintItem: TTBXItem
          Action = PrintCmd
        end
        object fmConfigPrintItem: TTBXItem
          Action = ConfigPrintCmd
        end
        object fmSeparator4: TTBXSeparatorItem
        end
        object fmExitItem: TTBXItem
          Action = ExitCmd
        end
      end
      object EditMenu: TTBXSubmenuItem
        object emUndoItem: TTBXItem
          Action = UndoCmd
        end
        object emRedoItem: TTBXItem
          Action = RedoCmd
        end
        object emSeparator1: TTBXSeparatorItem
        end
        object emCutItem: TTBXItem
          Action = CutCmd
        end
        object emCopyItem: TTBXItem
          Action = CopyCmd
        end
        object emCopyHTMLItem: TTBXItem
          Action = CopyAsHTMLCmd
        end
        object emPasteItem: TTBXItem
          Action = PasteCmd
        end
        object emSeparator2: TTBXSeparatorItem
        end
        object emSelectAllItem: TTBXItem
          Action = SelectAllCmd
        end
      end
      object SearchMenu: TTBXSubmenuItem
        OnPopup = SearchMenuPopup
        object smFindItem: TTBXItem
          Action = FindCmd
        end
        object smFindNextItem: TTBXItem
          Action = FindNextCmd
        end
        object smReplaceItem: TTBXItem
          Action = ReplaceCmd
        end
        object smSeparator1: TTBXSeparatorItem
        end
        object smGotoLineItem: TTBXItem
          Action = GotoLineCmd
        end
        object smSeparator2: TTBXSeparatorItem
        end
        object smToggleBookmarkItem: TTBXSubmenuItem
          OnPopup = smToggleBookmarkItemPopup
        end
        object smGotoBookmarkItem: TTBXSubmenuItem
          OnPopup = smGotoBookmarkItemPopup
        end
      end
      object ViewMenu: TTBXSubmenuItem
        object vmToolBarsItem: TTBXSubmenuItem
          object vmVisibilityToggleStandarItem: TTBXVisibilityToggleItem
          end
          object vmVisibilityToggleEditItem: TTBXVisibilityToggleItem
          end
          object vmVisibilityToggleSearchItem: TTBXVisibilityToggleItem
          end
          object vmVisibilityToggleViewItem: TTBXVisibilityToggleItem
          end
          object vmVisibilityToggleFormatItem: TTBXVisibilityToggleItem
          end
          object vmVisibilityToggleNSISItem: TTBXVisibilityToggleItem
          end
          object vmVisibilityToggleWindowItem: TTBXVisibilityToggleItem
          end
        end
        object vmSeparator1: TTBXSeparatorItem
        end
        object vmVisibilityToggleBrowserItem: TTBXVisibilityToggleItem
          Control = BrowserPanel
        end
        object vmVisibilityToggleWinListItem: TTBXVisibilityToggleItem
          Control = WinListPanel
        end
        object vmIOPanelItem: TTBXItem
          Action = ViewIOPanelCmd
        end
        object vmVisibilityToggleStatusBarItem: TTBXVisibilityToggleItem
          Control = EstBar
          OnClick = vmVisibilityToggleStatusBarItemClick
        end
        object vmLogBoxItem: TTBXItem
          Action = LogBoxCmd
        end
        object vmSeparator2: TTBXSeparatorItem
        end
        object vmSpecialCharsItem: TTBXItem
          Action = ViewSpecialCharsCmd
        end
        object vmToggleDesignModeItem: TTBXItem
          Action = ToggleDesingModeCmd
        end
        object vmSeparator3: TTBXSeparatorItem
        end
        object vmOptionsItem: TTBXItem
          Action = ShowOptionsCmd
        end
      end
      object FormatMenu: TTBXSubmenuItem
        object fmIndentItem: TTBXItem
          Action = IdentTextCmd
        end
        object fmUnindentItem: TTBXItem
          Action = UnIdentTextCmd
        end
        object fmSeparator5: TTBXSeparatorItem
        end
        object fmUpperCaseItem: TTBXItem
          Action = UpperCaseCmd
        end
        object fmLowerCaseItem: TTBXItem
          Action = LowerCaseCmd
        end
        object fmToggleCaseItem: TTBXItem
          Action = ToggleCaseCmd
        end
        object fmQuoteItem: TTBXItem
          Action = CoteCmd
        end
      end
      object ToolsMenu: TTBXSubmenuItem
        OnPopup = ToolsMenuPopup
        object tmInsertColorItem: TTBXItem
          Action = InsertColorCmd
        end
        object tmInsertFileNameItem: TTBXItem
          Action = InsertFileNameCmd
        end
        object tmSeparator1: TTBXSeparatorItem
        end
        object tmTemplateItem: TTBXSubmenuItem
        end
        object tmEditTemplatesItem: TTBXItem
          Action = EditCodeTemplatesCmd
        end
      end
      object NSISMenu: TTBXSubmenuItem
        object nmCompItem: TTBXItem
          Action = CompScriptCmd
        end
        object nmCompRunItem: TTBXItem
          Action = CompRunCmd
        end
        object nmRunItem: TTBXItem
          Action = RunInstallerCmd
        end
        object nmSeparator1: TTBXSeparatorItem
        end
        object nmConfigItem: TTBXItem
          Action = ConfigCmd
        end
      end
      object WindowMenu: TTBXSubmenuItem
        object wmCacadeItem: TTBXItem
          Action = CascadeCmd
        end
        object wmTileHorItem: TTBXItem
          Action = TileHorCmd
        end
        object wmTileVerItem: TTBXItem
          Action = TileVerCmd
        end
        object wmArrangeItem: TTBXItem
          Action = ArrangleCmd
        end
        object wmSeparator1: TTBXSeparatorItem
        end
        object wmPriorItem: TTBXItem
          Action = PriorWindowCmd
        end
        object wmNextItem: TTBXItem
          Action = NextWindowCmd
        end
        object wmSMUItem: TTBXItem
          Action = CMRWindowCmd
        end
        object wmSeparator2: TTBXSeparatorItem
        end
        object wmCloseItem: TTBXItem
          Action = CloseWinCmd
        end
        object wmSeparator3Item: TTBXSeparatorItem
        end
        object wmListItem: TTBXMDIWindowItem
        end
      end
      object HelpMenu: TTBXSubmenuItem
        object hmNSISHelp: TTBXItem
          Action = NSISHelpCmd
        end
        object hmSeparator1: TTBXSeparatorItem
        end
        object hmURLGroupItem: TTBGroupItem
        end
        object hmSeparator2: TTBXSeparatorItem
        end
        object hmAboutItem: TTBXItem
          Action = AboutCmd
        end
      end
    end
    object tbStandard: TTBXToolbar
      Left = 0
      Top = 10
      DockPos = 0
      DockRow = 1
      Images = MainImages
      TabOrder = 1
      object stbNewScriptItem: TTBXItem
        Action = NewScriptCmd
      end
      object stbWizardItem: TTBXItem
        Action = WizardCmd
      end
      object stbNewIOItem: TTBXItem
        Action = NewIOCmd
      end
      object stbOpenItem: TTBXSubmenuItem
        Action = OpenFileCmd
        DropdownCombo = True
        OnPopup = stbOpenItemPopup
        object TBMRUListItem2: TTBXMRUListItem
          MRUList = MRU
        end
      end
      object stbSeparator1: TTBXSeparatorItem
      end
      object stbSaveItem: TTBXItem
        Action = SaveFileCmd
      end
      object stbSeparator2: TTBXSeparatorItem
      end
      object stbPrintItem: TTBXItem
        Action = PrintCmd
      end
    end
    object tbEdit: TTBXToolbar
      Left = 171
      Top = 10
      DockPos = 146
      DockRow = 1
      Images = MainImages
      TabOrder = 2
      object etbUndoItem: TTBXItem
        Action = UndoCmd
      end
      object etbRedoItem: TTBXItem
        Action = RedoCmd
      end
      object etbSeparator1: TTBXSeparatorItem
      end
      object etbCutItem: TTBXItem
        Action = CutCmd
      end
      object etbCopyItem: TTBXItem
        Action = CopyCmd
      end
      object etbPasteItem: TTBXItem
        Action = PasteCmd
      end
    end
    object tbNSIS: TTBXToolbar
      Left = 0
      Top = 36
      Caption = '*'
      DockPos = -3
      DockRow = 2
      Images = MainImages
      TabOrder = 3
      object ntbCompItem: TTBXItem
        Action = CompScriptCmd
      end
      object ntbCompRunItem: TTBXItem
        Action = CompRunCmd
      end
      object ntbRunItem: TTBXItem
        Action = RunInstallerCmd
      end
    end
    object tbFormat: TTBXToolbar
      Left = 466
      Top = 10
      DockPos = 440
      DockRow = 1
      Images = MainImages
      TabOrder = 4
      object ftbIndentItem: TTBXItem
        Action = IdentTextCmd
      end
      object ftbUnIndentItem: TTBXItem
        Action = UnIdentTextCmd
      end
      object ftbSeparator1: TTBXSeparatorItem
      end
      object ftbUpperCaseItem: TTBXItem
        Action = UpperCaseCmd
      end
      object ftbLowerCaseItem: TTBXItem
        Action = LowerCaseCmd
      end
      object ftbToggleCaseItem: TTBXItem
        Action = ToggleCaseCmd
      end
      object ftbQuoteItem: TTBXItem
        Action = CoteCmd
      end
    end
    object tbSearch: TTBXToolbar
      Left = 302
      Top = 10
      DockPos = 276
      DockRow = 1
      Images = MainImages
      TabOrder = 5
      object stbFindItem: TTBXItem
        Action = FindCmd
      end
      object stbFindNextItem: TTBXItem
        Action = FindNextCmd
      end
      object stbReplaceItem: TTBXItem
        Action = ReplaceCmd
      end
      object stbSeparator3: TTBXSeparatorItem
      end
      object stbGotoLineItem: TTBXItem
        Action = GotoLineCmd
      end
    end
    object tbView: TTBXToolbar
      Left = 410
      Top = 10
      DockPos = 384
      DockRow = 1
      Images = MainImages
      TabOrder = 6
      object vtbSpecialCharsItem: TTBXItem
        Action = ViewSpecialCharsCmd
      end
      object vtbToggleDsgModeItem: TTBXItem
        Action = ToggleDesingModeCmd
      end
    end
    object tbWindow: TTBXToolbar
      Left = 80
      Top = 36
      DockPos = 80
      DockRow = 2
      Images = MainImages
      TabOrder = 7
      object wtbCascadeItem: TTBXItem
        Action = CascadeCmd
      end
      object wtbTileHorItem: TTBXItem
        Action = TileHorCmd
      end
      object wtbTileVerItem: TTBXItem
        Action = TileVerCmd
      end
      object wtbSeparator1: TTBXSeparatorItem
      end
      object wtbPriorItem: TTBXItem
        Action = PriorWindowCmd
      end
      object wtbNextItem: TTBXItem
        Action = NextWindowCmd
      end
      object wtbSeparator2: TTBXSeparatorItem
      end
      object wtbListItem: TTBXSubmenuItem
        object TBXMDIWindowItem1: TTBXMDIWindowItem
        end
      end
    end
  end
  object LeftDock: TTBXDock
    Left = 144
    Top = 62
    Width = 9
    Height = 169
    Position = dpLeft
  end
  object RightMultiDock: TTBXMultiDock
    Left = 457
    Top = 62
    Width = 175
    Height = 169
    BoundLines = [blRight]
    Position = dpRight
    object IOPanel: TTBXDockablePanel
      Left = 0
      Top = 0
      BorderSize = 3
      Color = clBtnFace
      DockedWidth = 170
      DockPos = 8
      SplitHeight = 52
      SupportedDocks = [dkMultiDock]
      TabOrder = 0
      Visible = False
      OnClose = IOPanelClose
      OnDockChanged = IOPanelDockChanged
      OnVisibleChanged = IOPanelDockChanged
      object Bevel1: TBevel
        Left = 3
        Top = 25
        Width = 164
        Height = 3
        Align = alTop
        Shape = bsSpacer
      end
      object IOCrtlPropList: TZPropList
        Left = 3
        Top = 28
        Width = 164
        Height = 102
        Middle = 74
        OnChange = IOCrtlPropListChange
        Align = alClient
        TabOrder = 0
      end
      object tbIOCtrls: TTBXToolbar
        Left = 3
        Top = 3
        Width = 164
        Height = 22
        Align = alTop
        DockMode = dmCannotFloatOrChangeDocks
        DragHandleStyle = dhNone
        FullSize = True
        Images = ControlsImages
        ShrinkMode = tbsmWrap
        TabOrder = 1
      end
    end
  end
  object LeftMultiDock: TTBXMultiDock
    Left = 0
    Top = 62
    Width = 144
    Height = 169
    Position = dpLeft
    object WinListPanel: TTBXDockablePanel
      Left = 0
      Top = 0
      BorderSize = 3
      Color = clBtnFace
      DockedWidth = 140
      DockPos = 0
      SupportedDocks = [dkMultiDock]
      TabOrder = 0
      OnDockChanged = IOPanelDockChanged
      OnVisibleChanged = IOPanelDockChanged
      object WinList: TTreeView
        Left = 3
        Top = 3
        Width = 134
        Height = 127
        Align = alClient
        HideSelection = False
        HotTrack = True
        Images = SystemImageList
        Indent = 19
        PopupMenu = WinListPopup
        ReadOnly = True
        RightClickSelect = True
        ShowButtons = False
        ShowLines = False
        TabOrder = 0
        OnChange = WinListChange
      end
    end
  end
  object RightDock: TTBXDock
    Left = 448
    Top = 62
    Width = 9
    Height = 169
    Position = dpRight
  end
  object BottomDock: TTBXDock
    Left = 0
    Top = 231
    Width = 632
    Height = 200
    Position = dpBottom
    object BrowserPanel: TTBXDockablePanel
      Left = 0
      Top = 0
      CaptionRotation = dpcrAlwaysHorz
      Color = clBtnFace
      DockedWidth = 170
      DockedHeight = 196
      DockPos = 0
      SupportedDocks = [dkStandardDock, dkMultiDock]
      TabOrder = 0
      Visible = False
      OnDockChanged = IOPanelDockChanged
      OnVisibleChanged = BrowserPanelVisibleChanged
      object tbBrowser: TTBXToolbar
        Left = 0
        Top = 0
        Width = 628
        Height = 22
        Align = alTop
        Images = MainImages
        TabOrder = 0
        object btbBackItem: TTBXItem
          ImageIndex = 36
          OnClick = btbBackItemClick
        end
        object btbForwardItem: TTBXItem
          ImageIndex = 37
          OnClick = btbForwardItemClick
        end
        object btbStopItem: TTBXItem
          ImageIndex = 38
          OnClick = btbStopItemClick
        end
        object btbRefreshItem: TTBXItem
          ImageIndex = 39
          OnClick = btbRefreshItemClick
        end
        object btbHomeItem: TTBXItem
          ImageIndex = 41
          OnClick = btbHomeItemClick
        end
        object btbSeparator1: TTBXSeparatorItem
        end
        object vtbEditURLItem: TTBControlItem
          Control = URLField
        end
        object btbGoItem: TTBXItem
          ImageIndex = 40
          OnClick = btbGoItemClick
        end
        object URLField: TEdit
          Left = 121
          Top = 0
          Width = 240
          Height = 21
          TabOrder = 0
          OnKeyDown = URLFieldKeyDown
        end
      end
      object BrowserStatusBar: TTBXStatusBar
        Left = 0
        Top = 158
        Width = 628
        Panels = <
          item
            StretchPriority = 75
            Tag = 0
            TextTruncation = twEndEllipsis
          end
          item
            Control = BrowserProgressBar
            Size = 100
            Tag = 0
          end
          item
            Framed = False
            StretchPriority = 100
            Tag = 0
          end>
        UseSystemFont = False
        object BrowserProgressBar: TProgressBar
          Left = 479
          Top = 3
          Width = 96
          Height = 18
          Min = 0
          Max = 100
          Smooth = True
          TabOrder = 0
          Visible = False
        end
      end
    end
  end
  object EstBar: TTBXStatusBar
    Left = 0
    Top = 431
    Width = 632
    Panels = <
      item
        Alignment = taCenter
        Size = 100
        Tag = 0
      end
      item
        Alignment = taCenter
        Size = 80
        Tag = 0
      end
      item
        Alignment = taCenter
        Size = 80
        Tag = 0
      end
      item
        StretchPriority = 100
        Tag = 0
        TextTruncation = twEndEllipsis
      end>
    UseSystemFont = False
  end
  object Actions: TActionList
    Images = MainImages
    Left = 192
    Top = 72
    object NewScriptCmd: TAction
      Category = 'File'
      ImageIndex = 0
      ShortCut = 16462
      OnExecute = NewScriptCmdExecute
    end
    object CloseWindowCmd: TAction
      Category = 'WinList'
      OnExecute = CloseWindowCmdExecute
    end
    object OpenFileCmd: TAction
      Category = 'File'
      ImageIndex = 2
      ShortCut = 16463
      OnExecute = OpenFileCmdExecute
    end
    object SaveFileCmd: TAction
      Category = 'File'
      ImageIndex = 1
      ShortCut = 16467
      OnExecute = SaveFileCmdExecute
      OnUpdate = SaveFileCmdUpdate
    end
    object SaveFileAsCmd: TAction
      Category = 'File'
      OnExecute = SaveFileAsCmdExecute
      OnUpdate = SaveFileAsCmdUpdate
    end
    object ArrangleCmd: TWindowArrange
      Category = 'Window'
    end
    object CascadeCmd: TWindowCascade
      Category = 'Window'
      ImageIndex = 4
    end
    object TileHorCmd: TWindowTileHorizontal
      Category = 'Window'
      ImageIndex = 5
    end
    object TileVerCmd: TWindowTileVertical
      Category = 'Window'
      ImageIndex = 6
    end
    object PrintCmd: TAction
      Category = 'File'
      ImageIndex = 7
      ShortCut = 16464
      OnExecute = PrintCmdExecute
      OnUpdate = CheckEditNil
    end
    object ConfigPrintCmd: TAction
      Category = 'File'
      OnExecute = ConfigPrintCmdExecute
    end
    object RedoCmd: TAction
      Category = 'Edit'
      ImageIndex = 13
      ShortCut = 24666
      OnExecute = RedoCmdExecute
      OnUpdate = RedoCmdUpdate
    end
    object FindCmd: TAction
      Category = 'Search'
      ImageIndex = 15
      ShortCut = 16454
      OnExecute = FindCmdExecute
      OnUpdate = CheckEditNil
    end
    object FindNextCmd: TAction
      Category = 'Search'
      ImageIndex = 16
      ShortCut = 114
      OnExecute = FindNextCmdExecute
      OnUpdate = CheckEditNil
    end
    object ReplaceCmd: TAction
      Category = 'Search'
      ImageIndex = 14
      OnExecute = RemplasarDlgReplace
      OnUpdate = CheckEditNil
    end
    object LogBoxCmd: TAction
      Category = 'View'
      OnExecute = LogBoxCmdExecute
      OnUpdate = LogBoxCmdUpdate
    end
    object CompScriptCmd: TAction
      Category = 'NSIS'
      ImageIndex = 17
      ShortCut = 16504
      OnExecute = CompScriptCmdExecute
      OnUpdate = CompScriptCmdUpdate
    end
    object RunInstallerCmd: TAction
      Category = 'NSIS'
      ImageIndex = 18
      ShortCut = 120
      OnExecute = RunInstallerCmdExecute
      OnUpdate = RunInstallerCmdUpdate
    end
    object CompRunCmd: TAction
      Category = 'NSIS'
      ImageIndex = 42
      OnExecute = CompScriptCmdExecute
      OnUpdate = CompScriptCmdUpdate
    end
    object ConfigCmd: TAction
      Category = 'NSIS'
      ShortCut = 117
      OnExecute = ConfigCmdExecute
    end
    object InsertColorCmd: TAction
      Category = 'Tools'
      ImageIndex = 21
      OnExecute = InsertColorCmdExecute
      OnUpdate = CheckEditNil
    end
    object InsertFileNameCmd: TAction
      Category = 'Tools'
      OnExecute = InsertFileNameCmdExecute
      OnUpdate = CheckEditNil
    end
    object NSISHelpCmd: TAction
      Category = 'Help'
      OnExecute = NSISHelpCmdExecute
    end
    object AboutCmd: TAction
      Category = 'Help'
      OnExecute = AboutCmdExecute
    end
    object ExitCmd: TAction
      Category = 'File'
      ImageIndex = 3
      ShortCut = 32883
      OnExecute = ExitCmdExecute
    end
    object NewTemplateCmd: TAction
      Category = 'File'
      ImageIndex = 22
      ShortCut = 16453
      OnExecute = NewTemplateCmdExecute
    end
    object EditCodeTemplatesCmd: TAction
      Category = 'Tools'
      OnExecute = EditCodeTemplatesCmdExecute
    end
    object IdentTextCmd: TAction
      Category = 'Format'
      ImageIndex = 29
      ShortCut = 24649
      OnExecute = IdentTextCmdExecute
      OnUpdate = CheckEditSel
    end
    object UnIdentTextCmd: TAction
      Category = 'Format'
      ImageIndex = 28
      ShortCut = 24661
      OnExecute = UnIdentTextCmdExecute
      OnUpdate = CheckEditSel
    end
    object UpperCaseCmd: TAction
      Category = 'Format'
      ImageIndex = 27
      ShortCut = 16469
      OnExecute = UpperCaseCmdExecute
      OnUpdate = CheckEditNil
    end
    object LowerCaseCmd: TAction
      Category = 'Format'
      ImageIndex = 25
      ShortCut = 16460
      OnExecute = LowerCaseCmdExecute
      OnUpdate = CheckEditNil
    end
    object ToggleCaseCmd: TAction
      Category = 'Format'
      ImageIndex = 24
      OnExecute = ToggleCaseCmdExecute
      OnUpdate = CheckEditNil
    end
    object CoteCmd: TAction
      Category = 'Format'
      ImageIndex = 32
      ShortCut = 16465
      OnExecute = CoteCmdExecute
      OnUpdate = CheckEditNil
    end
    object NewIOCmd: TAction
      Category = 'File'
      ImageIndex = 23
      ShortCut = 16457
      OnExecute = NewIOCmdExecute
    end
    object CopyAsHTMLCmd: TAction
      Category = 'Edit'
      OnExecute = CopyAsHTMLCmdExecute
      OnUpdate = CopyAsHTMLCmdUpdate
    end
    object SendToBackCmd: TAction
      Category = 'IODesign'
      ImageIndex = 30
      OnExecute = ExecuteDesingAction
      OnUpdate = UpdateDesignAction
    end
    object BringToFrontCmd: TAction
      Category = 'IODesign'
      ImageIndex = 31
      OnExecute = ExecuteDesingAction
      OnUpdate = UpdateDesignAction
    end
    object DeleteControlCmd: TAction
      Category = 'IODesign'
      ImageIndex = 10
      OnExecute = ExecuteDesingAction
      OnUpdate = UpdateDesignAction
    end
    object ViewIOPanelCmd: TAction
      Category = 'View'
      OnExecute = ViewIOPanelCmdExecute
    end
    object CopyCmd: TEditCopy
      Category = 'Edit'
      Hint = 'Copy'
      ImageIndex = 8
      ShortCut = 16451
    end
    object CutCmd: TEditCut
      Category = 'Edit'
      Hint = 'Cut'
      ImageIndex = 9
      ShortCut = 16472
    end
    object PasteCmd: TEditPaste
      Category = 'Edit'
      Hint = 'Paste'
      ImageIndex = 11
      ShortCut = 16470
    end
    object SelectAllCmd: TEditSelectAll
      Category = 'Edit'
      ShortCut = 16449
    end
    object UndoCmd: TEditUndo
      Category = 'Edit'
      ImageIndex = 12
    end
    object ToggleDesingModeCmd: TAction
      Category = 'IODesign'
      ImageIndex = 35
      ShortCut = 123
      OnExecute = ToggleDesingModeCmdExecute
      OnUpdate = ToggleDesingModeCmdUpdate
    end
    object GotoLineCmd: TAction
      Category = 'Search'
      ImageIndex = 33
      OnExecute = GotoLineCmdExecute
      OnUpdate = CheckEditNil
    end
    object ViewSpecialCharsCmd: TAction
      Category = 'View'
      ImageIndex = 34
      OnExecute = ViewSpecialCharsCmdExecute
      OnUpdate = ViewSpecialCharsCmdUpdate
    end
    object ShowOptionsCmd: TAction
      Category = 'View'
      OnExecute = ConfigCmdExecute
    end
    object NextWindowCmd: TAction
      Category = 'Window'
      ImageIndex = 37
      OnExecute = ExecuteWindowCmd
      OnUpdate = UpdateWindowCmd
    end
    object PriorWindowCmd: TAction
      Category = 'Window'
      ImageIndex = 36
      OnExecute = ExecuteWindowCmd
      OnUpdate = UpdateWindowCmd
    end
    object ShowWindowCmd: TAction
      Category = 'WinList'
      OnExecute = ShowWindowCmdExecute
    end
    object CompWinCmd: TAction
      Category = 'WinList'
      ImageIndex = 17
      OnExecute = CompWinCmdExecute
      OnUpdate = CompWinCmdUpdate
    end
    object CompRunWinCmd: TAction
      Category = 'WinList'
      ImageIndex = 42
      OnExecute = CompWinCmdExecute
      OnUpdate = CompWinCmdUpdate
    end
    object RunWinCmd: TAction
      Category = 'WinList'
      ImageIndex = 18
      OnExecute = RunWinCmdExecute
      OnUpdate = RunWinCmdUpdate
    end
    object SaveWinCmd: TAction
      Category = 'WinList'
      ImageIndex = 1
      OnExecute = SaveWinCmdExecute
      OnUpdate = SaveWinCmdUpdate
    end
    object SaveAsWinCmd: TAction
      Category = 'WinList'
      OnExecute = SaveAsWinCmdExecute
    end
    object CloseWinCmd: TWindowClose
      Category = 'Window'
    end
    object WizardCmd: TAction
      Category = 'File'
      ImageIndex = 20
      ShortCut = 16471
      OnExecute = WizardCmdExecute
    end
    object SetTabOrderCmd: TAction
      Category = 'IODesign'
      ImageIndex = 44
      OnExecute = SetTabOrderCmdExecute
      OnUpdate = SetTabOrderCmdUpdate
    end
    object CMRWindowCmd: TAction
      Category = 'Window'
      OnExecute = CMRWindowCmdExecute
      OnUpdate = CMRWindowCmdUpdate
    end
  end
  object OpenDlg: TOpenDialog
    Options = [ofHideReadOnly, ofAllowMultiSelect, ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Left = 160
    Top = 104
  end
  object SaveDlg: TSaveDialog
    Options = [ofOverwritePrompt, ofHideReadOnly, ofPathMustExist, ofEnableSizing]
    OnTypeChange = SaveDlgTypeChange
    Left = 192
    Top = 104
  end
  object TBMDIHandler1: TTBXMDIHandler
    Toolbar = tbMenu
    Left = 160
    Top = 72
  end
  object MRU: TTBXMRUList
    HidePathExtension = False
    MaxItems = 9
    OnClick = MRUClick
    Prefix = 'MRU'
    Left = 160
    Top = 168
  end
  object SynNSIS: TSynNSISSyn
    DefaultFilter = ' '
    HighlightVarsInsideStrings = True
    Left = 224
    Top = 136
  end
  object SynIni: TSynIniSyn
    DefaultFilter = ' '
    Left = 192
    Top = 136
  end
  object LogBoxPopup: TTBXPopupMenu
    Left = 224
    Top = 104
    object Copiaraportapeles1: TTBXItem
      Action = CopyCmd
    end
    object MenuItem1: TTBXItem
      Action = SelectAllCmd
    end
  end
  object EditPopup: TTBXPopupMenu
    Images = MainImages
    OnPopup = EditPopupPopup
    Left = 160
    Top = 136
    object puInsertColorItem: TTBXItem
      Action = InsertColorCmd
    end
    object puInsertFileNameItem: TTBXItem
      Action = InsertFileNameCmd
    end
    object puSeparator1: TTBXSeparatorItem
    end
    object puTemplateItem: TTBXSubmenuItem
      LinkSubitems = tmTemplateItem
    end
    object puSeparator2: TTBXSeparatorItem
    end
    object puUndoItem: TTBXItem
      Action = UndoCmd
    end
    object puRedoItem: TTBXItem
      Action = RedoCmd
    end
    object puSeparator3: TTBXSeparatorItem
    end
    object puCutItem: TTBXItem
      Action = CutCmd
    end
    object puCopyItem: TTBXItem
      Action = CopyCmd
    end
    object puCopyHTMLItem: TTBXItem
      Action = CopyAsHTMLCmd
    end
    object puPasteItem: TTBXItem
      Action = PasteCmd
    end
    object puSelectAllItem: TTBXItem
      Action = SelectAllCmd
    end
    object puSeparator4: TTBXSeparatorItem
    end
    object puFindItem: TTBXItem
      Action = FindCmd
    end
    object puFindNextItem: TTBXItem
      Action = FindNextCmd
    end
    object puReplaceItem: TTBXItem
      Action = ReplaceCmd
    end
    object puSeparator5: TTBXSeparatorItem
    end
    object puToggleBookmarkItem: TTBXSubmenuItem
      LinkSubitems = smToggleBookmarkItem
    end
    object puGotoBookmarkItem: TTBXSubmenuItem
      LinkSubitems = smGotoBookmarkItem
    end
  end
  object IOCtrlFlagsPopup: TTBXPopupMenu
    Left = 192
    Top = 168
  end
  object DesignMenu: TTBXPopupMenu
    Images = MainImages
    OnPopup = DesignMenuPopup
    Left = 224
    Top = 168
    object TBXItem2: TTBXItem
      Action = BringToFrontCmd
    end
    object TBXItem3: TTBXItem
      Action = SendToBackCmd
    end
    object TBXItem1: TTBXItem
      Action = SetTabOrderCmd
    end
    object TBXSeparatorItem2: TTBXSeparatorItem
    end
    object TBXItem9: TTBXItem
      Action = UndoCmd
    end
    object TBXSeparatorItem5: TTBXSeparatorItem
    end
    object TBXItem5: TTBXItem
      Action = CutCmd
    end
    object TBXItem4: TTBXItem
      Action = CopyCmd
    end
    object TBXItem6: TTBXItem
      Action = PasteCmd
    end
    object TBXItem8: TTBXItem
      Action = SelectAllCmd
    end
    object TBXSeparatorItem3: TTBXSeparatorItem
    end
    object TBXItem7: TTBXItem
      Action = DeleteControlCmd
    end
    object TBXSeparatorItem1: TTBXSeparatorItem
    end
    object iopResizeItem: TTBXSubmenuItem
    end
  end
  object EditorOptions: TMySynEditorOptionsContainer
    Options = [eoAltSetsColumnMode, eoAutoIndent, eoDragDropEditing, eoDropFiles, eoKeepCaretX, eoShowScrollHint, eoSmartTabs, eoTabsToSpaces, eoTrimTrailingSpaces]
    Color = clWindow
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    ExtraLineSpacing = 0
    Gutter.Font.Charset = DEFAULT_CHARSET
    Gutter.Font.Color = clWindowText
    Gutter.Font.Height = -11
    Gutter.Font.Name = 'Terminal'
    Gutter.Font.Style = []
    Gutter.Width = 20
    RightEdge = 0
    RightEdgeColor = clSilver
    WantTabs = True
    InsertCaret = ctVerticalLine
    OverwriteCaret = ctBlock
    HideSelection = False
    MaxUndo = 1024
    TabWidth = 8
    Left = 192
    Top = 200
  end
  object MainImages: TImageList
    Left = 224
    Top = 72
    Bitmap = {
      494C01012E003100040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D7600
      000000000000760000002800000040000000D00000000100040000000000001A
      0000000000000000000000000000000000000000000000008000008000000080
      800080000000800080008080000080808000C0C0C0000000FF0000FF000000FF
      FF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFDDDDDDDDDDDDDDDDDDDDDDDDFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEEEEEEEEFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFF77777777777777770000000000000000000000000000
      0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000070000000000000000000000
      0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000F8B8B8B8B000000CCCCC00
      0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FB8B000B80002220CCCCCC
      0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000700F8B8B0B8B002AAA20ECC22
      0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000F0FB8B808B8002FAA20EE222
      2000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000F0F8B800B8B02FFA22EE2A22
      2000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0700F0FB8FFFFFF02FA2EEEE2FA2
      2200FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00F0F0FFF0000007C22EEEEEE2FA
      2200FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00F0FB000B8B8000CFEEEEEEEC2F
      2200FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00F0FB8FFFFFF000CFE2CEEEECC2
      A200FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00F0FFF000000700022A2CEEEECC
      2000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00F80008B8B0000002FFA2EEEECC
      C000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FB8FFFFFF00000002FFA222ECC
      0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFF0000007000000022FFA22CC
      0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000002222C00
      0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000200000000000007888333088
      8000000000000000000000000000000000000026000000000000007F8F3B308F
      800000000000000000000000000000000000002A000000000000007FF83BB0F8
      800000000000000000000000FFF0FF000000002A000000000000007F8F38B08F
      800000007000700000000000FFF0FF0000000028000000000000007FF83330F8
      800000700EEE0700000000000FFF0FF00000002F6000002000000008FF8F8F8F
      80000706EEEEE07000000000FFFFF0FF0000000286000062000003808FF8F8F8
      0B00700EEEEEEE00000000000FFFF0FF00000002F8A226662000003808FF8F80
      B0000A00EE700000000000000FF00F00000000002FF8AAAA62000003808FF80B
      000000A00E7FFF700000000000FF0FF000000000022FFF8AA0000000380880B0
      90000A0A00777770000000000000000000000000000222F80000000003800B01
      900000A0AEEEE070000000000000000000000000000002F0000000000038B001
      90007A0AFEEE0700000000000000000000000000000002000000000000030001
      100000AF66007000007000000000000000000000000002000000000000000000
      00000A7000700000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000001111110000007888888888880000000000000000000000000000000
      0000001999999911100007FF8F828F8F80000000000000000000000000000000
      0000019999999999110007F8F822F8F880000000000000000000000000000000
      0000019999999999910007FF8222228F800000000E00000000000000000000C0
      0000179999999999911007F8F822F66880000000EE00000000000000000000EC
      000017B99FF99FF9991007FF8F828F6F8000000EEEEEEEEEE00000CEEEEEEEEE
      C00017B999FFFF99991007F868F8F868800000CFFFFFFFFFE00000CFFFFFFFF8
      E00017B9999FF999991007FF6F828F8F8000000CFF0CCCCCC00000CCCCCCCCFE
      000017B999FFFF99991007F866F228F880000000CF0000000000000000000CE0
      000017B99FF99FF9991007FF8222228F800000000C0000000000000000000C00
      0000017B99999999990007FFFFF228F880000000000000000000000000000C00
      0000017BB9999999910007FFFFF28F0000000000000000000000000000000000
      000000177BB99999900007FFFFF8F87F00000000000000000000000000000000
      0000000117777790000007FFFFFFFF7000000000000000000000000000000000
      0000000001111110000007777777777000000000000000000000000000000000
      0000000000000000000000000070000000000000000000000000000070000000
      000000000000000000000000007888888880000000000000000000007FFFFFFF
      FFF000000004004000000000007FFFFFFF80000000700700000000007F777777
      77F000000004004000000000007FFFFFFF80000007000070000040007FFFFFFF
      FFF000000004004000000000007FFFFFFF80000000080770000044007F777777
      77F000000004004000000000007FFFFFFF80000000000000000044407BBBBBBB
      BBB000000444004000007000007FFFFFFF80000007070000000044407BBBBBBB
      BBB000004444004000007F88887FFFFFFF80000008007800000044007BBBBBBB
      BBB000044444004000007F88887FFFFF0000000000700000000040007F777777
      77F000044444004000007F88887FFFFF7F00000000070000000000007FFFFFFF
      FFF000044444004000007F88887FFFFF7000000000000000000000007F7777FF
      FFF000004444004000007F88887777777000000000000000000000007FFFFFFF
      000000000444444440007FFFFFFFFF000000000000000000000000007FFFFFFF
      0F0000000000000000007000000000000000000000000000000000007FFFFFFF
      0000000000000000000074444444440000000000000000000000000077777777
      0000000000000000000077777777770000000000000000000000000000000000
      0000000700000000000000000000000000000000000000000000000000000000
      00000007F8F8F8F0000000999900000000000000000000000000000000000000
      000000078F8F8F80000000099900000000000000000000000000000000000000
      00007007F8F8F8F0000000999907000000000000000000000000000000000000
      00007FE78F8F8F80000009990907FEFEFEF00000000000000000000000000000
      00007EF7F8F8F8F0000009000007E00000E00000000000000000000000000000
      00007FE78F8F0000000009007007FEFEFEF00040000000000000004000000000
      00007EF7F8F80800000000007F87E00000E00440000000000000004400000000
      00007FE78F8F00000000000078F7FEFEFEF04444400000000000444440000000
      00007EF777777000009000007F87EFEF00000440000000000000004400000000
      00007FEFE0F000000090000078F7FEFE08000040000000000000004000000000
      00007EFEF0000090999000007F87EFEF00000000000000000000000000000000
      00007777770000999900000078F7777770000000000000000000000000000000
      0000000000000099900000007F8F80F000000000000000000000000000000000
      00000000000000999900000078F8F00000000000000000000000000000000000
      0000000000000000000000007777770000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000077777007
      0000000000000000000000000000000000000000000006666066000070000070
      0000000000000000007000070000000070000070000066006660000000000070
      0000007000000700700700007000000070000007000067000660000000000070
      0000000700000700700700000000000070000000000066000660000070000070
      0000000000000700700700000070000070000000070006666660000000000070
      0000000007000700700700000007000070000000007007000660000000000070
      0000000000700700000000000000700070000000000766000660000000000070
      0000000000070700700000000000070070000000000006666600000070000070
      0000000000000700700000000000007070000000000007000000000000000200
      0000000000000000700000000000000070000000000000000000000000000000
      0000000000000000000000000000000070000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000077000772000000000000000000000000000000000000000000000
      0000000000003300878707888888888880000070000070000000000000000000
      0000000000788888A78707FFFFFFFFFF8000071700071700000000AAA0EEE000
      0000000019177777777007FFFFF030FF8000007000007000000000AAA0EEE000
      0000000119177777770107FF0083B30F8000000000000000000000AAA0EEE000
      0000000111070778700107FFFF3B0B3F80000000070000000000000000000000
      0000001100070008711007FF0083B30F80000700717000000000007770FFF000
      0000001000078888700007FFFFF838FF80007170070000000000007770FFF000
      0000000000007777000007FF000000FF80000700000000000000007770FFF000
      0000888888000000000007FFFFFFFFFF80000000000000000000000000000000
      0000887778000000000007FF000F00FF80000007000000000000009990BBB0CC
      C000887778000000000007FFFFFFFFFF80000071700000000000009990BBB0CC
      C000887778000000000007FFFFFFFFFF80000007000B00000000009990BBB0CC
      C000887778000000000007F0F0F0F0F0F000000000B000000000000000000000
      00008877870000000000000F7F7F7F7F00000000070000000000000000000000
      000080008700000000000000F0F0F0F000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000A000000000000000000FFFFFFFF00000000000000000000000000000
      000000000A000000000000000000FF0F00F00000000000000000000000000000
      00000000A0A000000000E00BFBFB0FFFFFF00000000000000000000000000000
      000000000A0A00000000E0BFBF000FFFF0F00000000000000000000070007000
      00000000A0A0A0000000E0FBFBFBF0F00FF0000007000700000000700EEE0700
      000000000A0A0A000000E0BFBF00000B0FF000000000000000000706EEEEE070
      00000000A0A0A0A00000E0FBFBFBFBF0FFF0000000000000000070FEEEEEEE00
      000000000A0A0A000000E0BF0000000FFFF000000000000000000F6EEE700000
      00000000A0A0A0000000000BFB00B0FF00F00000000000000000066EEE7FFF70
      000000000A0A000000000000000B0FFFFFF0000000070000000006FEEE777770
      00000000A0A000000000000000B0FFFF000000000000000000000F66EEEEE070
      000000000A000000000000000B0FF00F0FF000000000000000007066FEEE0700
      00000000A000000000000000B00FFFFF0F000000000000000000070F66007000
      007000000000000000000009000FFFFF00000000000000000000007000700000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000F000000000F00000000000000000000000000000000
      000000000000000000000F000000000F00000000000000000000000470000000
      0000000000000000000000000000000000000000000000004000007400000444
      4400000000000000000000F000000F0000000044444000004000004000000044
      4400000000000000000000F000000F0000000044440000000400004000000004
      4400000000000000000000F000000F0000000044400000000400004000000040
      4400000000700070000000000000000000000044040000000400007400004400
      04000000000000000000000F00000F0000000040004400004000000744440000
      0000000000000000000000000000000000000000000044440000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000F00000F000000000000000000000000000000000
      0000000000007000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000004400000
      0000000000000000000000000044444444440000000444444444000040040044
      000000000000000000000000004FFFFFFFF400000004FFFFFFF4000040040400
      400000000000000000000737374F000000F400000004F00000F4000040040400
      400000000000000000000373734FFFFFFFF400000004FFFFFFF4000004440400
      400000000000000000000737374F000F444400FFFFF4F00000F4000000040444
      000000000000000000000373734FFFFF4F4000F00004FFFFFFF4000000040400
      000000000000000000000737374FFFFF440000FFFFF4F00F4444000000000000
      00000000000000000000037373444444400000F00004FFFF4F40000000000000
      00000000000000000000073737373737300000FFFFF4FFFF4400000000000000
      00000000000000000000037000000007700000F00F0444444000000000000000
      00000000000000000000077000000007300000FFFF0F00000000000000000000
      0000000000000000000003730B00B073700000FFFF0000000000000000000000
      00000000000000000000000000BB000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000004444444444000000000000
      0000000000000000000000000000000000000000004FFFFFFFF4044444444444
      4400044444444444440000000000000000000000004FFFFFFFF404FFFFFFFFFF
      F40004FFFFF4FFFFF40000888888888080000000004FFFFFFFF404FFFFFFFFFF
      F40004FFFFF4FFFFF4000000000000000800000444444444444404FFFFFFFFFF
      F40004FFFFF4FFFFF4000888888BBB8800000004FF44444444F4044444444444
      440004FFFFF4FFFFF40008888887778808000004FF4444444444044444444444
      F40004FFFFF4FFFFF40000000000000008800004FFFFFFFF4000044444444444
      440004FFFFF4FFFFF4000888888888808080044444444444400004FFFFFFFFFF
      F40004FFFFF4FFFFF400000000000008080004F44444444F400004FFFFFFFFFF
      F40004FFFFF4FFFFF400000FFFFFFFF0808004F444444444400004FFFFFFFFFF
      F40004FFFFF4FFFFF4000000F00000F0000004FFFFFFFF400000044444444444
      440004444444444444000000FFFFFFFF00000444444444400000044444444444
      F400044444F44444F40000000F00000F0000044444444F400000044444444444
      4400044444444444440000000FFFFFFFF0000444444444400000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000003300000088
      0300000000000000000000033000000000000000FFFFFFFFF000003300000088
      0300003333333330000033333033333300000000FFFFFFFFF000003300000088
      03000B03333333330000333330BBB00000000000FFFFFFFFF000003300000000
      03000FB0333333333000333330BBB00C00000000FFFFFFFFF000003333333333
      33000BFB033333333300333330BBB0CC00000000FFFFFFFFF000003300000000
      33000FBFB00000000000333F30BBBCCC00000000FFFFFFFFF000003088888888
      03000BFBFBFBFB000000333330BBCCCCCCC00000FFFFFFFFF000003088888888
      03000FBFBFBFBF0000003333300CCCCCCCC00000FFFFFFFFF000003088888888
      03000BFB00000000000033333000CCCCCCC00000FFFFFF000000003088888888
      03000000000000000000333330FF0CCC00000000FFFFFF0F0000003088888888
      00000000000000000000333330FFF0CC00000000FFFFFF000000003088888888
      08000000000000000000333330FFF00C00000000000000000000000000000000
      0000000000000000000003333033330000000000000000000000000000000000
      000000000000000000000003330000000000424D3E000000000000003E000000
      2800000040000000D00000000100010000000000800600000000000000000000
      000000000000000000000000FFFFFF000FF80000700003B00FF8000020000030
      0FF83FFC77FCFB800FF83FFC77FCFB800FF80000780013F00FF8000050001070
      0FF8300C7800FB800FF8300C7800FB800FF80FF07FC003FE0FF800002A8000FE
      0FF820047FC0FB000FF820047FC0FB000FF80FF07FC001FE0FF80000554001FE
      0FF820047FC0F8000FF820047FC0F800FFFFFFFF700000FEF800F83F200000FE
      F800E00F7000F800F800C0077000F800E000800300000370E000800300000370
      E00000010000FB00800000010000FB0080000001000003B080030001000003B0
      800300010000FB80800380030000FB80800F800300000390800FC00700000390
      800FE00F0000FB80C7FFF83F0000FB80FFFFFFFFEDB6FFFFF1FFC003EAAAFFFF
      E3FFC003EAAAFFFFC7FFC003EDB6F13FC7FFC003FFFFE01FC7BFC003F07FE01F
      C79FC003C03FC00FC38F8001801FC007E0078001001FC007E003C0032019C00F
      F001E0035010C00FF803F0032819C00FFE07F8035019E00FFF8FFC232039FFFF
      FF9FFE63C061FFFFFFBFFFFF81FFFFFFFFFFFFFFF81F8003FFFFFFFFE0078003
      FFFFFFFFC0038003FDFFFFBF80018003F9FFFF9F80018003F1FFFF8F00008003
      E003C00700008003C003C00300008003C003C00300008003E003C00700008003
      F1FFFF8F00008003F9FFFF9F80018003FDFFFFBF80018003FFFFFFFFC0038007
      FFFFFFFFE007800FFFFFFFFFF81F801FFFFFFFFFFFFFFC00FFFFF000FFFFEC00
      FFFFF000FEDFDC00FC3FF000FEDFDC00F81F7000FEDF8C00F89F3000FEDFDC00
      F9FF1000F8DF0000F8FF1000F0DF0000F81F3000E0DF000024127000E0DF0001
      2612F000E0DF000327F2F000F0DF0007FFFFF000F807001EFFFFF001FFFF001A
      FFFFF003FFFF0011FFFFF007FFFF001BFFFFFFFFE00FFFFFFEFFFEFFE00FC3FF
      FFFFFFFFE00FE3FFC27FC27F000FC200FFFFFFFF000F8A00C200C200000FBE00
      FFFFFFFF000FB000DE07DE07001FF0009E07CE07003FF00007FF07FF007DF000
      9E00CE0000FDF001DE00DE0001D1F003FFFFFFFF03C3F007C200C200FFC7F00F
      FFFFFFFFFFC3F01FFEFFFEFFFFFFF03FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFF04FFFFF07C30E04E71F0E09CFE79F31EF9F9F24E7E7CF39EF9FCF24F007
      E039E79FE024F9E7F301F01FF324FCE7F939FF9FF921FE67FC39EF9FFC27FF27
      FE03E79FFE27FF87FF3FF03FFF07FFC7FFFFFFFFFFFFFFE7FFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE30C007FFFFFFFFFE008003
      DF7F8003F00080038E3F803BF0008003DF7F803BE0028003FFFC803BC2008003
      FBF88003CE018003B1F18003CE0780031BE3800301078003BFC7800301FF8003
      FF8F800301FF8003EF1F800301FF8003C63F800301FF8003EC7F800301FF8003
      F8FF800301FFC007F9FFFFFF73FFE00FFE49EDB6F3FFFC00FE49EAAAF5FFFC00
      FFFFEAAAFAFF2000FFFFEDB6F57F0000C7C7FFFFFABF0000D7D7F07FF55F0000
      C387C03FFAAF0000C007801FF55F0000D087001FFABF0000D0870019F57F0000
      C0070010FAFFE000C0070019F5FFF800F39F0019FBFFF000F39F0039F7FFE001
      F39F8061FFFFC403FFFFC1FFFFFFEC07FFFFFFFFDB73FFFFFFFFFFFFDBB507C1
      FFFFFFFFC21307C1FFFFFFFFDBB507C1FFFFE7FFE7730101FFF7CF83FFFF0001
      C1F7DFC3E3E30201C3FBDFE3EBEB0201C7FBDFD3E1C38003CBFBCF3BE003C107
      DCF7E0FFE843C107FF0FFFFFE843E38FFFFFFFFFE003E38FFFFFFFFFE003E38F
      FFFFFFFFF9CFFFFFFFFFFFFFF9CFFFFFFFFFFFFFFFFFFFFFFFFFF9FFFFFFFC00
      FE00F6CFEFFD8000FE00F6B7C7FF0000FE00F6B7C3FB00008000F8B7E3F70000
      8000FE8FF1E700018000FE3FF8CF00038000FF7FFC1F00038001FE3FFE3F0003
      8003FEBFFC1F00038007FC9FF8CF0FC3807FFDDFE1E7000380FFFDDFC3F38007
      81FFFDDFC7FDF87FFFFFFFFFFFFFFFFFFC00FFFFFFFFFFFFFC0080038003C007
      FC00800380038003FC00800380030001E000800380030001E000800380030001
      E000800380030000E0078003800300008007800380038000800780038003C000
      800780038003E001801F80038003E007801F80038003F007801F80038003F003
      801FFFFFFFFFF803FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC001FFFFE3FF
      E0038001001F83FFE0038001000F000FE00380010007003FE00380010003002F
      E00380010001000FE00380010000000FE0038001001F0001E0038001001F0201
      E0038001001F0301E00380018FF1008FE0078001FFF9000FE00F8001FF75002F
      E01F8001FF8F803FFFFFFFFFFFFFE3FF00000000000000000000000000000000
      000000000000}
  end
  object ControlsImages: TImageList
    Height = 25
    Width = 25
    Left = 160
    Top = 200
    Bitmap = {
      494C010110001300040019001900FFFFFFFFFF10FFFFFFFFFFFFFFFF424D7600
      0000000000007600000028000000640000007D00000001000400000000006419
      0000000000000000000000000000000000000000000000008000008000000080
      800080000000800080008080000080808000C0C0C0000000FF0000FF000000FF
      FF00FF000000FF00FF00FFFF0000FFFFFF00536555D7FFFFFBFBA9BAAAEBF6F7
      B17DCCDDDDF93B73513FFE6EFFEC9DB8A88E6EA6666EC6DDDDCF37DBBBBEEBEE
      FEEEDB7DDD5798999B993B35B614CC4CCCFEBDBBFB9B7FB7777DD6DEFECD97FB
      BBBFEBEFF7E4436755F7FFFFFBFBA9BBAAFBF67F3939889999B93FFF77FFD6EF
      EFED93DFFFFFEFFFF7F6616777F7DFFFFB73103333FBE7F7F73BBABBBBDD7B79
      FA366E6EEEFEBDBFFF9B3FBF77FD214777F5DFFFFFFFFCEFFFBAE77B7D3BBABB
      BBBD7BFFFEB77F7FFFFABDFDFDCEA6EEEEEF5EFEFEEF939FFFFBAFFFF7F76147
      77F5DCDDDDD57BBBBAAEEEEEEEEEBDDDDDDFF73777775EEEEEEFF7DBBBBFEFFF
      F7FFBBEDDDD7FFFFFF777576666BF7F3F55DDCDDDDDDBBBFFFFFDCDCCDCD5557
      77766666666662233333BBB3BB3331111199D5DDDD5DDCCCCCC46222220444CC
      CCEEB999998AAAA6667FFFFFFFFFFFFFFFFFFFFFFFFFF7F7777FFFFFFFFFFBFB
      BBBFFFFFFFFFFDFCDDCEEEEEEEEFFEFEEFEF777777777777777777777777BBBB
      BBBFFBFDFBBFFFFFFFFFFDFFFFDFFFFFFFFFFEFFFEEFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFF7FFF73BBBBBBBBFFFFFFFFFFEEEEEEFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFF7FFF77FFFFFFFFFFBFDD99DDDDDDDDDDDDD
      DDDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF777777FFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBBBBBBBBBBB9999DDDDDDDDDDDDC
      CCCEEEEEEEEEEEEEEEEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBF
      FFFFFFFFFFFF2210004550101111988999BBB9999999DDDDDDDDCC55DDDDFFFF
      FEEEEEEAEEEEF7FFFFFFFFFDFFBFFFBBBBBB3BBABB9BBB9999DDDDDDFEDDDCD5
      DDDDFFFFFEFFFFFBFF3ABB6AABAEEEFCEF9DCCADC4CFF7EEFECFEEDEE3667367
      7777FEEFF9BBB9BBBBBBEFEFFDDDBB7ABCBBEFCDFE9CDDBDD6DDF7D6777F7557
      F3FFFBFBBBA7B9237B7755D57DDB5539163BBAF3BFDDBB9D9A9CCCE8CA3E995A
      9C9B62D667E6337333A7BBE3B4FE7D3FE7A3FFFBF0FD9C94C86166F46A54CECA
      EC38995ABDAAEFCDFEBECCADD6DDF756F77F75D773F75579D4FD9C95D8E966B4
      6A76CE8AEC38BF5AB1B7EFAD7E7EFBAFF6FFF7F6774E63D666E7337773A7BBE3
      BD67793BF6B3777BF4B9D57EFDEEFFECEFBFE6BDDEFF77F677DF7756C9DD5375
      5D45FFE7E8EA293880E2DD59F4B9DC908C752AE4725CEE88CE7EDD7ABD6EFFCE
      E3D7727675F7BAE7F9FBB93BBBFBDCFBF5FDCC15DDFDEEF57BFFFF5BFFEEF77E
      FDFFFFEDFFBFF7BDDEFF77FEFFDF77DEEBDFDDFBF6FFFEB7FFFDFFFDFAEEEECA
      EE6EFF2ABDFFFEEDFFBFFF9DC6FFF7EEFFDFFFDFF3FFFBFFFFF7BAE7F9FFFD7F
      FFFBCDEBF5FF0000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000DDFF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000070620000FFFFFFFFFFFFFFFFFFF0000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      D15D0007777777777777777777F0000000000000000000000000000000000000
      0000000000000000000000000000000000000000C4DD0007F888888888888888
      87F0000000000000000000000000000000000000000000000000000000000000
      000000000000000006060007F88888888888888887F000000000000000000000
      0000000000000000000000000000000000000000000000000000000062770007
      F88888888888888887F000000000000000000000000000000000000000000000
      000000000000000000000FF00000000033BB0007F88888888888888887F00000
      0000000000000000000000007F77777777777777777000000000000000000FF0
      000000008FAC0007F88888888888888887F00000000000000000000000000000
      7F8888888888888888700000000000000000FF0000000000EEEE0007F8888888
      8888888887F00000CCCCC0C0C000C0C000C000007F8888800880808888700000
      000000000000FF0000000000AAEE0007F88888888888888887F00000C00000C0
      C000C0C00C0000007F888808808080888870000000000000F00FF00000000000
      1D1C0007F88888888888888887F00000C00000C0C000C0C0C00000007F888808
      808080888870000000000000FFFFF0000000000000800007F888888888888888
      87F00000C00000C0C000C0CC000000007F888808808008888870000000000000
      FFFFF00000000000A88A0007F88888888888888887F00000C00000C0CC00C0C0
      C00000007F888808808080888870000000000000FFFFFFF000000000C4680007
      F88888888888888887F00000C00000C0C0CC00C00C0000007F88888008808088
      8870000000000000FFFFFF0000000000BE660007F88888888888888887F00000
      C0000000000000C0000000007F888888888888888870000000000000FFFFF000
      0000000052FF0007F88888888888888887F00000C0000000000000C000000000
      7FFFFFFFFFFFFFFFFFF0000000000000FFFF00000000000010990007F8888888
      8888888887F00000C00000C0000000C000000000077777777777777777700000
      00000000FFF0000000000000C1AA0007F88080880888888887F0000000000000
      000000000000000000000000000000000000000000000000FF00000000000000
      64EF0007FF00000000FFFFFFF7F0000000000000000000000000000000000000
      000000000000000000000000F0000000000000004D9900077700000000777777
      7700000000000000000000000000000000000000000000000000000000000000
      000000000000000081A800000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000011000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000087890000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000009CEA0000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000F2EE000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000002100000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      9019000000000000000000000000000000000000000000000000000000000000
      0000000000000000077777777777777777777000969800000000000000000000
      0000000000000000000000000000000000000000000000000000000007888888
      8888888888887000FE1000000000000000000000000000000000000000000000
      00000000000000007777777000000000078888888888888888887000193B0000
      000000000000000000000000000000000000000000000000000000078FFFFF87
      00000000078888888898888988887000AC99FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFF000000007FFFFFFFFF700000000788888988811188
      8988700032227888888888888888888888888788888888888888888888888800
      000007FFFF8C8FFFF7000000078888888988118988887000711970FFFFFFFFFF
      F00000000000870FFFFFFFFFFF00000000000800000078FFFF8C8FFFF8700000
      078888888888188888887000737770FFFFFFFFFFF87777777770870FFFFFFFFF
      FF8777777777080000007FFFFFFFFFFFFF700000078888888888188888887000
      F4FD700FF0F00F0008F888888870870000FF0F0FFF8F88888887080000007FFF
      FF8C8FFFFF7000000788888888881888888870003577700FF0F0FF0FF8F88888
      88708700FF0F0F0FFF8F88888887080000007FFFFFCCCFFFFF70000007888888
      8888288888887000EBFF7000F0F0FF00F8F8080808708700FF0F0F00FF8F8080
      8087080000007FFFFFCCCFFFFF70000007888888882222282888700075DD700F
      F0F0FF0FF8F8888888708700FF0FFFFFFF8F88888887080000007FFFFFCCCFFF
      FF700000078888882229292228887000BBBB7000F0F0FF0008F8888888708700
      00FF0FFFFF8F888888870800000078FFFFCCCFFFF87000000788888822222292
      8288700099DD70FFFFFFFFFFF8FFFFFFFF70870FFFFFFFFFFF8FFFFFFFF70800
      000007FFFF8C8FFFF7000000078888222922222222887000FFFF70FFFFFFFFFF
      F88888888880870FFFFFFFFFFF888888888808000000007FFFFFFFFF70000000
      078888822222222922887000FFFF700000000000000000000000870000000000
      0000000000000800000000078FFFFF8700000000078888822228292228887000
      FFFF777777777777777777777777777777777777777777777777770000000000
      7777777000000000078888888222222222887000FFFF00000000000000000000
      0000000000000000000000000000000000000000000000000000000007888888
      8882288888887000EFFE00000000000000000000000000000000000000000000
      00000000000000000000000000000000078888888888888888887000FF770000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000078888888888888888887000CCCE0000000000000000000000000000
      0000000000000000000000000000000000000000000000000788888888888888
      88887000FFFF0000000000000000000000000000000000000000000000000000
      000000000000000000000000077777777777777777777000333B000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000CCDE000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FFFF000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000007A1500000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000669900000000000000000000000000007000000000000000
      0000000000000000000000000000000000000000000000000000000089660000
      0000000000000000000000007FFFFFFFFFFFFF08888000000000000000000000
      0000000000000000000000000000000010450000000000000000000000000000
      7FF44444444FFF0F778000000000000000000000000000000000000000000000
      000000008D8AFFFFFFFFFFFFFFFFFFFFFFFFF0007FFFFFFFFFFFFF0F00800000
      00000FFFFFFFFFFFFF0000000000000000FFFF000000000089A2788888888888
      88888888888880007FF444444444FF0FFF80000000000788888888888F000000
      00000000FF8888FF00000000C3DC70FFFFFFFFFFF0000000000080007FFFFFFF
      FFFFFF00000000000000070FFFFFFFFF8F0000000000000788FFFF88F0000000
      EF8870FFFFFFFFFFF8777777777080007FF44444444FFF0F8F8000000000070F
      FF0FFFFF8F000000000000070FFFFFF8F0000000400070FFFFFFFFFFF8F88888
      887080007444444444444408F8F000000000070FF000FFFF8F00000000000070
      FFF00FFF8F00000008CC70FFFFFFFFFFF8F8880888708000744FFFFFFFFF440F
      8F8000000000070F00000FFF8F00000000000070FF0000FF8F000000041570FF
      FFFFFFFFF8F88000887080007444444444444408F8F000000000070F00F000FF
      8F00000000000070FF0000FF8F000000255070FFFFFFFFFFF8F8000008708000
      7FF44444444FFF0F8F8000000000070F0FFF000F8F00000000000070FFF00FFF
      8F000000A8DD70FFFFFFFFFFF8F88888887080007FFFFFFFFFFFFF08F8F00000
      0000070FFFFFF00F8F000000000000070FFFFFF8F0000000255070FFFFFFFFFF
      F8FFFFFFFF7080007FF444444444FF0F8F8000000000070FFFFFFF0F8F000000
      0000000700FFFF00F0000000DC6670FFFFFFFFFFF8888888888080007FFFFFFF
      FFFFFF00000000000000070FFFFFFFFF8F000000000000007700007700000000
      040070000000000000000000000080007FF44444444FFF088880000000000700
      000000008F000000000000000077770000000000902277777777777777777777
      777770007FFFFFFFFFFFFF0F0080000000000777777777777F00000000000000
      0000000000000000C25300000000000000000000000000007FF444444444FF0F
      77800000000000000000000000000000000000000000000000000000F9D50000
      0000000000000000000000007FFFFFFFFFFFFF0FFF8000000000000000000000
      0000000000000000000000000000000066220000000000000000000000000000
      7777777777777700000000000000000000000000000000000000000000000000
      00000000FBFF0000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FFFF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000FFFF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      EFEF000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000888800000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000022220000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000022220000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000003333000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFF000
      000000000000000000000000000000000000000000000000DEEE000000000000
      000000000000000788888888888888888888F00FFFFFFFFFFFFFFFFFFFFFF00F
      FFFFFFFFFFFFFFFFFFFFFFFFE20200000000000000000000000000070FFFFFFF
      FFFFFFFFFFF8F00788888888888888888888F007888888888888888888888888
      222200000000000000000000000000070FF4444F4444FF7F7FF8F0070FFFFFFF
      FFFFFFFFFFF8F0070FFFFFFFFFFF000000000008222200000000000000000000
      000000070F44F44F44F44FF7FFF8F0070FFFFFFFFFFFFF7F7FF8F0070F4444F4
      444F877777777708222200000000000000000000000000070FF4444F44F44FF7
      FFF8F0070FFFFFFFFFFFFFF7FFF8F007044F44F44F448F888888870822220000
      0000000000000000000000070FFFF44F44F44FF7FFF8F0070FFCFCFFFFCFCFF7
      FFF8F0070F4444F44F448F888088870833330000000000000000000000000007
      0FF444FF4444FFF7FFF8F0070FFFCFFFFFFCFFF7FFF8F0070FFF44F44F448F88
      00088708CCCC00000000000000000000000000070FFFFFFF44FFFFF7FFF8F007
      0FCCCCCFFCCCCCF7FFF8F0070F444FF4444F8F80000087080000000000000000
      00000000000000070FFFFFFF44FFFFF7FFF8F0070FFFCFFFFFFCFFF7FFF8F007
      0FFFFFF44FFF8F8888888708000000000000000000000000000000070FFFFFF4
      44FFFF7F7FF8F0070FFFFFFFFFFFFFF7FFF8F0070FFFFFF44FFF8FFFFFFFF708
      000000000000000000000000000000070FFFFFFFFFFFFFFFFFF8F0070FFFFFFF
      FFFFFF7F7FF8F0070FFFFF444FFF888888888808000000000000000000000000
      0000000700000000000000000008F0070FFFFFFFFFFFFFFFFFF8F00700000000
      0000000000000008000000000000000000000000000000077777777777777777
      7777F00700000000000000000008F00777777777777777777777777700000000
      0000000000000000000000000000000000000000000000077777777777777777
      7777F00000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000424D3E00000000000000
      3E00000028000000640000007D0000000100010000000000D007000000000000
      00000000000000000000000000000000FFFFFF00FEF7FF000A02FFFFFFF610FE
      F7FF0000D7E42180129AFFFFFFF610FEF7FF0000FEF7FF7FCADAC42711E4926F
      E7FF0000FEF4217FC007C42711F7FFFEF7FF0000FEF4217FCFE0C42711F4927E
      F7FF0000EFE124FF9FF1C42711F4927EF7FF0000FEF7FF404FFCEB5AFBE6126F
      E7FF0000FEF12440429BEB5AFBF7FFFEF7FF0000FEF124404ADAEB5AFBF6127E
      F7FF0000EFE424FB915BEB5AFBF6127EF7FF0000FEF7FF404FE0EC5A1BE7926F
      E7FF00007EF424404EF1EC5A1BF7FFFEF7FF00007EF424404A02EC5A1BF7927E
      F6BD0000EFE724F19C3FEC5A1BF7927EF6BD0000FEF7FF404FFBEF5ADBE630EF
      E7FF0000FEF724404007EF5ADBF7FFFEF7FF0000FEF724404FDFEF5ADBF630FE
      F77E0000EFE461E09FFFEF5ADBF630FEF77E0000FEF7FF404800ECC73BE7F3EF
      E7FF00003EF4614040BFECC73BF7FFFEF7FF00003EF461404000ECC73BF7F3FE
      F4180000EFE7E7FF95C7ECC73BF7F3FEF4180000FEF7FF404FE0EFDFFBE7F3EF
      E7FF0000FEF7E7404FC0EFDFFBF7FFFEF7FF0000FEF7E7404FFFEFDFFBF7F3FE
      F77E0000FFFFFFFFFFFFFFFFFFFFFFFFF77E0000FFFFFFFFFFFFFFFFFFFFFFFF
      F7FF0000F00001FFFFFFFFFFFFFFFFFFF7FF0000E00001FFFFFFFFFFFFFFFFFF
      F7FF0000E00001FFFFFFFFFFFFFFFFFFF7FF0000E00001FFFFFFFFFFFFFFFF9F
      F7FF0000E00001FFFFFFF80001FFFF0FF7FF0000E00001FFFFFFF00000FFFF0F
      F7FF0000E00001FFFFFFF00000FFEE1FF7FF0000E00001F0575DF00000FFE61F
      F7FF0000E00001F7D75BF00000FFE03FF7FF0000E00001F7D757F00000FFE03F
      F7FF0000E00001F7D74FF00000FFE007F7FF0000E00001F7D357F00000FFE00F
      F0000000E00001F7D4DBF00000FFE01FF0000000E00001F7FFDFF00000FFE03F
      F0000000E00001F7FFDFF00000FFE07FF0000000E00001F7DFDFF80001FFE0FF
      F0000000E00001FFFFFFFFFFFFFFE1FFF0000000E29401FFFFFFFFFFFFFFE3FF
      F0000000E24403FFFFFFFFFFFFFFE7FFF0000000FEB7FFFFFFFFFFFFFFFFFFFF
      F0000000FFFFFFFFFFFFFFFFFFFFFFFFF0000000FFFFFFFFFFFFFFFFFFFFFFFF
      F6200000FFFFFFFFFFFFFFFFFFFFFFFFFE000000FFFFFFFFFFFFFFFFFFFFFFFF
      FFCA0000FFFFFFFFFFFFFFFFFFFFFFFFF00A0000FFFFFFFFFFFFFFFFFFF80000
      700A0000FFFFFFFFFFFFFFFFFFF8000071DE0000FFFFFFFFFFFFFFF01FF80000
      7FD40000FFFFFFFFFFFFFFE00FF8000071D400000000000000003FC007F80000
      71D400000000000000003F8003F800007FDE00000000000000003F0001F80000
      7FCA00000000000000003F0001F800007FCA00000000000000003F0001F80000
      7FCA00000000000000003F0001F8000070DE00000000000000003F0001F80000
      7FD400000000000000003F0001F8000070D400000000000000003F0001F80000
      70D400000000000000003F8003F800007FC000000000000000003FC007F80000
      7FC000000000000000003FE00FF800007FC000000000000000003FF01FF80000
      7FC00000FFFFFFFFFFFFFFFFFFF8000071DE0000FFFFFFFFFFFFFFFFFFF80000
      7FC00000FFFFFFFFFFFFFFFFFFF8000071C00000FFFFFFFFFFFFFFFFFFF80000
      71C00000FFFFFFFFFFFFFFFFFFF800007FD20000FFFFFFFFFFFFFFFFFFFFFFFF
      FFD00000FFFFFFFFFFFFFFFFFFFFFFFFFFD00000FFFFFFFFFFFFFFFFFFFFFFFF
      FFD00000FFFFFFFFFFFFFFFFFFFFFFFFF0D20000FFFFFFF00000FFFFFFFFFFFF
      FFDC0000FFFFFFF00000FFFFFFFFFFFFF0DC0000FFFFFFF00000FFFFFFFFFFFF
      F0DC0000000000700000FF8003FFFC3FFFDE0000000000700000FF8003FFF00F
      FFDC0000000000700000FF8003FFE007FFDC0000000000700000FF8003FFE007
      FFDC0000000000700000FF8003FFC003F0000000000000700000FF8003FFC003
      FFC00000000000700000FF8003FFC003FFC00000000000700000FF8003FFC003
      FFC00000000000700000FF8003FFE007F0000000000000700000FF8003FFE007
      F0000000000000700000FF8003FFF00FF0000000000000700000FF8003FFFC3F
      F0000000000000700000FF8003FFFFFFF0000000FFFFFFF00000FFFFFFFFFFFF
      F0000000FFFFFFF00000FFFFFFFFFFFFF0000000FFFFFFF00000FFFFFFFFFFFF
      F0000000FFFFFFFFFFFFFFFFFFFFFFFFF0000000FFFFFFFFFFFFFFFFFFFFFFFF
      F0000000FFFFFFFFFFFFFFFFFFFFFFFFF0000000FFFFFFFFFFFFFFFFFFFFFFFF
      F0000000FFFFFFFFFFFFFFFFFFFFFFFFF0000000FFFFFFFFFFFFFFFFFFFFFFFF
      F0000000FFFFFFFFFFFFFFFFFFFFFFFFF0000000FFFFFFFFFFFFFFFFFFFFFFFF
      F0000000FFFFFFE000007FFFFFFFFFFFF0000000FFFFFFE00000600000600000
      00000000FFFFFFE0000060000060000000000000FFFFFFE00000600000600000
      00000000C42711E0000060000060000000000000EB5AFBE00000600000600000
      00000000EC5A1BE0000060000060000000000000EF5ADBE00000600000600000
      00000000ECC73BE0000060000060000000000000EFDFFBE00000600000600000
      00000000EFDFFBE0000060000060000000000000CF9FF3E00000600000600000
      00000000FFFFFFE0000060000060000000000000FFFFFFE00000600000600000
      00000000FFFFFFFFFFFFE000007FFFFFF0000000FFFFFFFFFFFFFFFFFFFFFFFF
      F0000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFF
      FFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFF
      FFFF000000000000000000000000000000000000000000000000}
  end
  object WinListPopup: TTBXPopupMenu
    Images = MainImages
    OnPopup = WinListPopupPopup
    Left = 224
    Top = 200
    object wpuShowItem: TTBXItem
      Action = ShowWindowCmd
      Options = [tboDefault]
    end
    object wpuCloseItem: TTBXItem
      Action = CloseWindowCmd
    end
    object wpuSeparator1: TTBXSeparatorItem
    end
    object wpuSaveItem: TTBXItem
      Action = SaveWinCmd
    end
    object wpuSaveAsItem: TTBXItem
      Action = SaveAsWinCmd
    end
    object wpuSeparator2: TTBXSeparatorItem
    end
    object wpuTileHorItem: TTBXItem
      Action = TileHorCmd
    end
    object wpuTileVerItem: TTBXItem
      Action = TileVerCmd
    end
    object wpuSeparator3: TTBXSeparatorItem
    end
    object wpuCompItem: TTBXItem
      Action = CompWinCmd
    end
    object wpuCompRunItem: TTBXItem
      Action = CompRunWinCmd
    end
    object wpuRunItem: TTBXItem
      Action = RunWinCmd
    end
  end
  object SystemImageList: TImageList
    BlendColor = clHighlight
    ShareImages = True
    Left = 256
    Top = 72
  end
  object PluginItemsImages: TImageList
    Left = 256
    Top = 104
  end
  object SynEditSearchEngine: TSynEditSearch
    Left = 256
    Top = 136
  end
end
