object ConfigFrm: TConfigFrm
  Left = 94
  Top = -15
  BorderStyle = bsDialog
  BorderWidth = 5
  ClientHeight = 455
  ClientWidth = 487
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  ShowHint = True
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object CancelarBtn: TButton
    Left = 320
    Top = 428
    Width = 75
    Height = 25
    Cancel = True
    ModalResult = 2
    TabOrder = 2
  end
  object AceptarBtn: TButton
    Left = 232
    Top = 428
    Width = 75
    Height = 25
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 487
    Height = 419
    ActivePage = TabSheet1
    Align = alTop
    TabOrder = 0
    object TabSheet1: TTabSheet
      object GroupBox2: TNewGroupBox
        Left = 8
        Top = 224
        Width = 257
        Height = 97
        TabOrder = 1
        object Label11: TStaticText
          Left = 8
          Top = 64
          Width = 8
          Height = 17
          Caption = '*'
          TabOrder = 2
        end
        object ThemeList: TComboBox
          Left = 128
          Top = 64
          Width = 121
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 3
        end
        object SDragToolBarsChk: TCheckBox
          Left = 8
          Top = 16
          Width = 225
          Height = 17
          TabOrder = 0
        end
        object SDragPanelsChk: TCheckBox
          Left = 8
          Top = 32
          Width = 225
          Height = 17
          TabOrder = 1
        end
      end
      object GroupBox3: TNewGroupBox
        Left = 8
        Top = 8
        Width = 257
        Height = 209
        TabOrder = 0
        object Label13: TStaticText
          Left = 8
          Top = 136
          Width = 8
          Height = 17
          Caption = '*'
          TabOrder = 3
        end
        object Label12: TStaticText
          Left = 8
          Top = 168
          Width = 8
          Height = 17
          Caption = '*'
          TabOrder = 5
        end
        object WelcomeDialogChk: TCheckBox
          Left = 8
          Top = 43
          Width = 241
          Height = 17
          TabOrder = 0
        end
        object MultInstChk: TCheckBox
          Left = 8
          Top = 59
          Width = 241
          Height = 17
          TabOrder = 1
        end
        object LangList: TComboBox
          Left = 128
          Top = 136
          Width = 121
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          Sorted = True
          TabOrder = 4
          OnChange = LangListClick
        end
        object IniDesignerChk: TCheckBox
          Left = 8
          Top = 75
          Width = 241
          Height = 17
          TabOrder = 2
        end
        object BrowserHomeEdt: TEdit
          Left = 128
          Top = 168
          Width = 121
          Height = 21
          TabOrder = 6
          OnChange = BrowserHomeEdtChange
        end
        object SaveFileListChk: TCheckBox
          Left = 8
          Top = 91
          Width = 241
          Height = 17
          TabOrder = 7
        end
        object SplashChk: TCheckBox
          Left = 8
          Top = 27
          Width = 241
          Height = 17
          TabOrder = 8
        end
        object UseDefBrowserChk: TCheckBox
          Left = 8
          Top = 107
          Width = 241
          Height = 17
          TabOrder = 9
        end
      end
      object GroupBox1: TNewGroupBox
        Left = 8
        Top = 328
        Width = 465
        Height = 57
        TabOrder = 4
        object RegisterBtn: TButton
          Left = 8
          Top = 24
          Width = 449
          Height = 25
          TabOrder = 0
          OnClick = RegisterBtnClick
        end
      end
      object NewGroupBox2: TNewGroupBox
        Left = 272
        Top = 8
        Width = 201
        Height = 209
        TabOrder = 2
        object DisplayGridChk: TCheckBox
          Left = 8
          Top = 24
          Width = 185
          Height = 17
          TabOrder = 0
        end
        object StaticText1: TStaticText
          Left = 8
          Top = 72
          Width = 8
          Height = 17
          Caption = '*'
          TabOrder = 2
        end
        object GridSizeXEdt: TEdit
          Left = 112
          Top = 72
          Width = 81
          Height = 21
          TabOrder = 3
        end
        object StaticText2: TStaticText
          Left = 8
          Top = 96
          Width = 8
          Height = 17
          Caption = '*'
          TabOrder = 4
        end
        object GridSizeYEdt: TEdit
          Left = 112
          Top = 96
          Width = 81
          Height = 21
          TabOrder = 5
        end
        object SnapToGridChk: TCheckBox
          Left = 8
          Top = 40
          Width = 185
          Height = 17
          TabOrder = 1
        end
        object RightBottomChk: TRadioButton
          Left = 16
          Top = 145
          Width = 177
          Height = 17
          TabOrder = 7
        end
        object WidthHeightChk: TRadioButton
          Left = 16
          Top = 164
          Width = 177
          Height = 17
          TabOrder = 8
        end
        object BothChk: TRadioButton
          Left = 16
          Top = 184
          Width = 177
          Height = 17
          TabOrder = 9
        end
        object StaticText3: TStaticText
          Left = 8
          Top = 128
          Width = 8
          Height = 17
          Caption = '*'
          TabOrder = 6
        end
      end
      object NewGroupBox3: TNewGroupBox
        Left = 272
        Top = 224
        Width = 201
        Height = 97
        TabOrder = 3
        object StaticText4: TStaticText
          Left = 8
          Top = 24
          Width = 8
          Height = 17
          Caption = '*'
          TabOrder = 0
        end
        object RegistryChk: TRadioButton
          Left = 16
          Top = 45
          Width = 177
          Height = 17
          TabOrder = 1
        end
        object IniFileChk: TRadioButton
          Left = 16
          Top = 68
          Width = 177
          Height = 17
          TabOrder = 2
        end
      end
    end
    object TabSheet2: TTabSheet
      ImageIndex = 1
      object PageControl2: TPageControl
        Left = 0
        Top = 0
        Width = 479
        Height = 391
        ActivePage = TabSheet4
        Align = alClient
        TabOrder = 0
        object TabSheet4: TTabSheet
          object gbGutter: TNewGroupBox
            Left = 8
            Top = 8
            Width = 457
            Height = 121
            TabOrder = 0
            object Label1: TStaticText
              Left = 224
              Top = 89
              Width = 8
              Height = 17
              Caption = '*'
              TabOrder = 8
            end
            object ckGutterShowLineNumbers: TCheckBox
              Left = 9
              Top = 48
              Width = 208
              Height = 17
              Checked = True
              State = cbChecked
              TabOrder = 1
              OnClick = ckGutterShowLineNumbersClick
            end
            object ckGutterShowLeaderZeros: TCheckBox
              Left = 9
              Top = 86
              Width = 208
              Height = 17
              TabOrder = 3
            end
            object ckGutterStartAtZero: TCheckBox
              Left = 9
              Top = 67
              Width = 208
              Height = 17
              TabOrder = 2
            end
            object ckGutterVisible: TCheckBox
              Left = 9
              Top = 26
              Width = 208
              Height = 17
              Checked = True
              State = cbChecked
              TabOrder = 0
              OnClick = ckGutterVisibleClick
            end
            object cbGutterFont: TCheckBox
              Left = 216
              Top = 18
              Width = 201
              Height = 17
              TabOrder = 4
            end
            object btnGutterFont: TButton
              Left = 362
              Top = 13
              Width = 79
              Height = 25
              TabOrder = 5
              OnClick = btnGutterFontClick
            end
            object pGutterBack: TPanel
              Left = 392
              Top = 85
              Width = 48
              Height = 21
              BorderWidth = 1
              TabOrder = 7
              object pGutterColor: TPanel
                Left = 2
                Top = 2
                Width = 44
                Height = 17
                Align = alClient
                BevelOuter = bvLowered
                Color = clGray
                TabOrder = 0
                OnClick = SelectColor
              end
            end
            object pnlGutterFontDisplay: TPanel
              Left = 240
              Top = 40
              Width = 201
              Height = 33
              BevelOuter = bvNone
              TabOrder = 6
              object lblGutterFont: TStaticText
                Left = 19
                Top = 9
                Width = 10
                Height = 12
                Caption = '*'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'Terminal'
                Font.Style = []
                ParentFont = False
                TabOrder = 0
              end
            end
          end
          object gbRightEdge: TNewGroupBox
            Left = 8
            Top = 136
            Width = 225
            Height = 88
            TabOrder = 1
            object Label3: TStaticText
              Left = 9
              Top = 56
              Width = 8
              Height = 17
              Caption = '*'
              TabOrder = 2
            end
            object Label10: TStaticText
              Left = 9
              Top = 26
              Width = 8
              Height = 17
              Caption = '*'
              TabOrder = 3
            end
            object pRightEdgeBack: TPanel
              Left = 152
              Top = 54
              Width = 57
              Height = 21
              BorderWidth = 1
              TabOrder = 1
              object pRightEdgeColor: TPanel
                Left = 2
                Top = 2
                Width = 53
                Height = 17
                Align = alClient
                BevelOuter = bvLowered
                Color = clGray
                TabOrder = 0
                OnClick = SelectColor
              end
            end
            object eRightEdge: TEdit
              Left = 152
              Top = 23
              Width = 57
              Height = 21
              TabOrder = 0
            end
          end
          object gbBookmarks: TNewGroupBox
            Left = 8
            Top = 232
            Width = 225
            Height = 79
            TabOrder = 2
            object ckBookmarkKeys: TCheckBox
              Left = 9
              Top = 24
              Width = 208
              Height = 17
              TabOrder = 0
            end
            object ckBookmarkVisible: TCheckBox
              Left = 9
              Top = 48
              Width = 208
              Height = 17
              TabOrder = 1
            end
          end
          object gbEditorFont: TNewGroupBox
            Left = 240
            Top = 232
            Width = 225
            Height = 79
            TabOrder = 3
            object btnFont: TButton
              Left = 129
              Top = 47
              Width = 84
              Height = 25
              TabOrder = 0
              OnClick = btnFontClick
            end
            object Panel3: TPanel
              Left = 8
              Top = 19
              Width = 209
              Height = 27
              BevelOuter = bvNone
              TabOrder = 1
              object labFont: TStaticText
                Left = 2
                Top = 1
                Width = 12
                Height = 20
                Caption = '*'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -13
                Font.Name = 'Courier New'
                Font.Style = []
                ParentFont = False
                TabOrder = 0
              end
            end
          end
          object gbLineSpacing: TNewGroupBox
            Left = 240
            Top = 136
            Width = 225
            Height = 88
            TabOrder = 4
            object Label8: TStaticText
              Left = 9
              Top = 27
              Width = 8
              Height = 17
              Caption = '*'
              TabOrder = 2
            end
            object Label9: TStaticText
              Left = 9
              Top = 56
              Width = 8
              Height = 17
              Caption = '*'
              TabOrder = 3
            end
            object eLineSpacing: TEdit
              Left = 144
              Top = 23
              Width = 60
              Height = 21
              TabOrder = 0
            end
            object eTabWidth: TEdit
              Left = 144
              Top = 53
              Width = 60
              Height = 21
              TabOrder = 1
            end
          end
        end
        object TabSheet5: TTabSheet
          ImageIndex = 1
          object gbOptions: TNewGroupBox
            Left = 8
            Top = 2
            Width = 457
            Height = 247
            TabOrder = 0
            object ckViewUsageHints: TCheckBox
              Left = 8
              Top = 219
              Width = 220
              Height = 17
              TabOrder = 20
            end
            object ckHalfPageScroll: TCheckBox
              Left = 8
              Top = 201
              Width = 220
              Height = 17
              TabOrder = 9
            end
            object ckHideShowScrollbars: TCheckBox
              Left = 8
              Top = 182
              Width = 220
              Height = 17
              TabOrder = 8
            end
            object ckEnhanceHomeKey: TCheckBox
              Left = 8
              Top = 163
              Width = 220
              Height = 17
              TabOrder = 7
            end
            object ckRightMouseMoves: TCheckBox
              Left = 8
              Top = 144
              Width = 220
              Height = 17
              TabOrder = 6
            end
            object ckSmartTabDelete: TCheckBox
              Left = 8
              Top = 125
              Width = 220
              Height = 17
              TabOrder = 5
            end
            object ckSmartTabs: TCheckBox
              Left = 8
              Top = 106
              Width = 220
              Height = 17
              TabOrder = 4
            end
            object ckKeepCaretX: TCheckBox
              Left = 8
              Top = 87
              Width = 220
              Height = 17
              TabOrder = 3
            end
            object ckAltSetsColumnMode: TCheckBox
              Left = 8
              Top = 68
              Width = 220
              Height = 17
              TabOrder = 2
            end
            object ckDragAndDropEditing: TCheckBox
              Left = 8
              Top = 46
              Width = 220
              Height = 17
              TabOrder = 1
            end
            object ckAutoIndent: TCheckBox
              Left = 8
              Top = 27
              Width = 220
              Height = 17
              TabOrder = 0
            end
            object ckScrollByOneLess: TCheckBox
              Left = 230
              Top = 27
              Width = 220
              Height = 17
              TabOrder = 10
            end
            object ckScrollPastEOF: TCheckBox
              Left = 230
              Top = 46
              Width = 220
              Height = 17
              TabOrder = 11
            end
            object ckScrollPastEOL: TCheckBox
              Left = 230
              Top = 68
              Width = 220
              Height = 17
              TabOrder = 12
            end
            object ckShowScrollHint: TCheckBox
              Left = 230
              Top = 87
              Width = 220
              Height = 17
              TabOrder = 13
            end
            object ckTabsToSpaces: TCheckBox
              Left = 230
              Top = 125
              Width = 220
              Height = 17
              TabOrder = 15
            end
            object ckTrimTrailingSpaces: TCheckBox
              Left = 230
              Top = 144
              Width = 220
              Height = 17
              TabOrder = 16
            end
            object ckScrollHintFollows: TCheckBox
              Left = 230
              Top = 106
              Width = 220
              Height = 17
              TabOrder = 14
            end
            object ckGroupUndo: TCheckBox
              Left = 230
              Top = 163
              Width = 220
              Height = 17
              TabOrder = 17
            end
            object ckDisableScrollArrows: TCheckBox
              Left = 230
              Top = 182
              Width = 220
              Height = 17
              TabOrder = 18
            end
            object ckShowSpecialChars: TCheckBox
              Left = 230
              Top = 201
              Width = 220
              Height = 17
              TabOrder = 19
            end
            object ckUndoAfterSave: TCheckBox
              Left = 230
              Top = 219
              Width = 220
              Height = 17
              TabOrder = 21
            end
          end
          object gbCaret: TNewGroupBox
            Left = 8
            Top = 252
            Width = 457
            Height = 67
            TabOrder = 1
            object Label2: TStaticText
              Left = 16
              Top = 17
              Width = 8
              Height = 17
              Caption = '*'
              TabOrder = 2
            end
            object Label4: TStaticText
              Left = 16
              Top = 41
              Width = 8
              Height = 17
              Caption = '*'
              TabOrder = 3
            end
            object cInsertCaret: TComboBox
              Left = 224
              Top = 13
              Width = 209
              Height = 21
              Style = csDropDownList
              ItemHeight = 0
              TabOrder = 0
            end
            object cOverwriteCaret: TComboBox
              Left = 224
              Top = 37
              Width = 209
              Height = 21
              Style = csDropDownList
              ItemHeight = 0
              TabOrder = 1
            end
          end
        end
        object TabSheet6: TTabSheet
          ImageIndex = 2
          object GroupBox11: TNewGroupBox
            Left = 8
            Top = 8
            Width = 457
            Height = 345
            TabOrder = 0
            object Label7: TStaticText
              Left = 8
              Top = 32
              Width = 8
              Height = 17
              Caption = '*'
              TabOrder = 5
            end
            object HighLightChk: TCheckBox
              Left = 9
              Top = 0
              Width = 97
              Height = 17
              Caption = '*'
              TabOrder = 0
              OnClick = HighLightChkClick
            end
            object SynEdit: TSynEdit
              Left = 8
              Top = 208
              Width = 441
              Height = 129
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'Courier New'
              Font.Style = []
              TabOrder = 1
              OnMouseDown = SynEditMouseDown
              Gutter.Font.Charset = DEFAULT_CHARSET
              Gutter.Font.Color = clWindowText
              Gutter.Font.Height = -11
              Gutter.Font.Name = 'Terminal'
              Gutter.Font.Style = []
              Gutter.Width = 20
              Lines.Strings = (
                '; Syntax Highlighting'
                ''
                'SetCompressor bzip2'
                '!define MUI_PRODUCT "HM NIS Edit"'
                '!define MUI_VERSION "1.2"'
                ''
                'OutFile "NisEdit12.exe"'
                'InstallDir "$PROGRAMFILES\HMSoft\NIS Edit"'
                
                  'InstallDirRegKey  HKLM "Software\Microsoft\Windows\CurrentVersio' +
                  'n\App Paths\NISEdit.exe" ""'
                'LicenseBkColor 0x00FFFFFF'
                ''
                'Function .onInit'
                '  /*  This is a callback function with plugin '
                '       call and multiline comment.'
                '  */'
                '  Plugin::call'
                'FunctionEnd'
                ''
                'Section ""'
                '  SetOverwrite ifnewer  '
                '  File "NISEdit.exe"'
                
                  '  CreateShortCut "$DESKTOP\HM NIS Edit.lnk" "$INSTDIR\NISEdit.ex' +
                  'e"'
                'SectionEnd')
              Options = [eoAutoIndent, eoDragDropEditing, eoGroupUndo, eoNoCaret, eoNoSelection, eoScrollPastEol, eoSmartTabDelete, eoSmartTabs, eoTabsToSpaces, eoTrimTrailingSpaces]
              ReadOnly = True
              RightEdge = 0
              ScrollBars = ssVertical
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
            object GroupBox13: TNewGroupBox
              Left = 136
              Top = 40
              Width = 313
              Height = 121
              TabOrder = 2
              object Bevel1: TBevel
                Left = 8
                Top = 16
                Width = 297
                Height = 94
              end
              object Bevel2: TBevel
                Left = 139
                Top = 17
                Width = 6
                Height = 92
                Shape = bsRightLine
              end
              object Label5: TStaticText
                Left = 16
                Top = 29
                Width = 121
                Height = 13
                AutoSize = False
                Caption = '*'
                TabOrder = 5
              end
              object Label6: TStaticText
                Left = 152
                Top = 29
                Width = 145
                Height = 13
                AutoSize = False
                Caption = '*'
                TabOrder = 6
              end
              object Panel2: TPanel
                Left = 16
                Top = 45
                Width = 121
                Height = 25
                BevelOuter = bvLowered
                TabOrder = 0
                OnClick = SelectColor
              end
              object Panel4: TPanel
                Left = 16
                Top = 77
                Width = 121
                Height = 25
                BevelOuter = bvLowered
                TabOrder = 1
                OnClick = SelectColor
              end
              object CheckBox1: TCheckBox
                Left = 152
                Top = 45
                Width = 145
                Height = 17
                Caption = '*'
                TabOrder = 2
                OnClick = AttriChange
              end
              object CheckBox2: TCheckBox
                Tag = 1
                Left = 152
                Top = 61
                Width = 145
                Height = 17
                Caption = '*'
                TabOrder = 3
                OnClick = AttriChange
              end
              object CheckBox3: TCheckBox
                Tag = 2
                Left = 152
                Top = 77
                Width = 145
                Height = 17
                Caption = '*'
                TabOrder = 4
                OnClick = AttriChange
              end
            end
            object HLVarsInStrsChk: TCheckBox
              Left = 136
              Top = 168
              Width = 305
              Height = 17
              Caption = '*'
              TabOrder = 3
              OnClick = HLVarsInStrsChkClick
            end
            object ListBox: TListBox
              Left = 8
              Top = 48
              Width = 121
              Height = 153
              ItemHeight = 13
              TabOrder = 4
              OnClick = ListBoxClick
            end
          end
        end
      end
    end
    object TabSheet3: TTabSheet
      ImageIndex = 2
      object GroupBox8: TNewGroupBox
        Left = 8
        Top = 0
        Width = 465
        Height = 81
        TabOrder = 0
        object Label14: TStaticText
          Left = 8
          Top = 24
          Width = 8
          Height = 17
          Caption = '*'
          FocusControl = CopilEdt
          TabOrder = 4
        end
        object Label15: TStaticText
          Left = 8
          Top = 48
          Width = 8
          Height = 17
          Caption = '*'
          FocusControl = HTMLEdt
          TabOrder = 5
        end
        object CopilEdt: TEdit
          Left = 88
          Top = 24
          Width = 345
          Height = 21
          ParentColor = True
          ReadOnly = True
          TabOrder = 0
        end
        object ExaminarExeBtn: TButton
          Left = 436
          Top = 24
          Width = 21
          Height = 21
          Caption = '...'
          TabOrder = 1
          OnClick = ExaminarExeBtnClick
        end
        object HTMLEdt: TEdit
          Left = 88
          Top = 48
          Width = 345
          Height = 21
          ParentColor = True
          ReadOnly = True
          TabOrder = 2
        end
        object ExaminarHtmlBtn: TButton
          Left = 436
          Top = 48
          Width = 21
          Height = 21
          Caption = '...'
          TabOrder = 3
          OnClick = ExaminarHtmlBtnClick
        end
      end
      object GroupBox7: TNewGroupBox
        Left = 8
        Top = 88
        Width = 465
        Height = 73
        TabOrder = 1
        object NoConfigChk: TCheckBox
          Left = 8
          Top = 24
          Width = 449
          Height = 17
          Caption = '*'
          TabOrder = 0
        end
        object NoCDChk: TCheckBox
          Left = 8
          Top = 48
          Width = 449
          Height = 17
          Caption = '*'
          TabOrder = 1
        end
      end
      object GroupBox9: TNewGroupBox
        Left = 8
        Top = 168
        Width = 465
        Height = 209
        TabOrder = 2
        object SimbLst: TListView
          Left = 8
          Top = 19
          Width = 353
          Height = 182
          Columns = <
            item
              Width = 190
            end
            item
              Width = 140
            end>
          ColumnClick = False
          ReadOnly = True
          RowSelect = True
          TabOrder = 0
          ViewStyle = vsReport
          OnDblClick = SimbLstDblClick
          OnKeyDown = SimbLstKeyDown
        end
        object AgregarBtn: TButton
          Left = 368
          Top = 16
          Width = 89
          Height = 25
          Caption = '*'
          TabOrder = 1
          OnClick = AgregarBtnClick
        end
        object EditarBtn: TButton
          Left = 368
          Top = 48
          Width = 89
          Height = 25
          Caption = '*'
          TabOrder = 2
          OnClick = EditarBtnClick
        end
        object EliminarBtn: TButton
          Left = 368
          Top = 80
          Width = 89
          Height = 25
          Caption = '*'
          TabOrder = 3
          OnClick = EliminarBtnClick
        end
      end
    end
    object TabSheet7: TTabSheet
      ImageIndex = 3
      object NewGroupBox1: TNewGroupBox
        Left = 8
        Top = 8
        Width = 465
        Height = 369
        TabOrder = 0
        object PluginsList: TListBox
          Left = 8
          Top = 16
          Width = 369
          Height = 321
          ItemHeight = 13
          TabOrder = 0
          OnClick = PluginsListClick
          OnDblClick = PluginsListDblClick
        end
        object ConfigPluginBtn: TButton
          Left = 384
          Top = 16
          Width = 75
          Height = 25
          TabOrder = 1
          OnClick = ConfigPluginBtnClick
        end
        object AboutPluginBtn: TButton
          Left = 384
          Top = 48
          Width = 75
          Height = 25
          TabOrder = 2
          OnClick = AboutPluginBtnClick
        end
        object PluginFileNameLbl: TStaticText
          Left = 8
          Top = 344
          Width = 449
          Height = 17
          AutoSize = False
          Caption = '*'
          TabOrder = 3
        end
      end
    end
  end
  object ApplyBtn: TButton
    Left = 408
    Top = 428
    Width = 75
    Height = 25
    TabOrder = 3
    OnClick = ApplyBtnClick
  end
  object ColorDlg: TColorDialog
    Ctl3D = True
    Left = 132
    Top = 392
  end
  object FontDlg: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    MinFontSize = 0
    MaxFontSize = 0
    Left = 164
    Top = 392
  end
  object AbrirDlg: TOpenDialog
    Options = [ofHideReadOnly, ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Left = 100
    Top = 392
  end
end
