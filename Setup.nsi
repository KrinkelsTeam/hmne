/*
  HM NIS Edit (c) 2003 H�ctor Mauricio Rodr�guez Segura <ranametal@users.sourceforge.net>
  For conditions of distribution and use, see license.txt

  Installation script

*/


; Helper defines
!define APP_NAME "HM NIS Edit"
!define APP_VERSION "2.0b5"
!define APP_HOME_PAGE "http://hmne.sourceforge.net/"

!include "MUI.nsh"

SetCompressor lzma

 ########## MUI Settings ##########
!define MUI_ABORTWARNING
!define MUI_ICON "${NSISDIR}\Contrib\Graphics\Icons\classic-install.ico"
!define MUI_UNICON "${NSISDIR}\Contrib\Graphics\Icons\classic-uninstall.ico"
!define MUI_HEADERIMAGE
!define MUI_HEADERIMAGE_BITMAP "header.bmp"

 ########## Pages ##########
!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_LICENSE "License.txt"
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
!define MUI_FINISHPAGE_RUN "$INSTDIR\nisedit.exe"
!insertmacro MUI_PAGE_FINISH

!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES

 ########## Languages ##########
!insertmacro MUI_LANGUAGE "Spanish"
!insertmacro MUI_LANGUAGE "English"
!insertmacro MUI_LANGUAGE "Polish"
!insertmacro MUI_LANGUAGE "French"
!insertmacro MUI_LANGUAGE "Czech"
!insertmacro MUI_LANGUAGE "Italian"
!insertmacro MUI_LANGUAGE "Russian"
!insertmacro MUI_LANGUAGE "German"
!insertmacro MUI_LANGUAGE "Greek"
!insertmacro MUI_LANGUAGE "TradChinese"
!insertmacro MUI_LANGUAGE "SimpChinese"
!insertmacro MUI_LANGUAGE "Ukrainian"
!insertmacro MUI_LANGUAGE "PortugueseBR"
!insertmacro MUI_LANGUAGE "Korean"
!insertmacro MUI_LANGUAGE "Hungarian"

;-------------------------------------------------------------------------
; Undef this if you dont have UPX upx.sourceforge.net
!define HAVE_UPX

!ifdef HAVE_UPX
  !packhdr tmpexe.tmp "UPX -9 -q --compress-icons=0 tmpexe.tmp"
!endif

Name "${APP_NAME} ${APP_VERSION}"
OutFile "..\nisedit${APP_VERSION}.exe"
InstallDir "$PROGRAMFILES\HMSoft\NIS Edit"
InstallDirRegKey  HKLM "Software\Microsoft\Windows\CurrentVersion\App Paths\NISEdit.exe" ""
ShowInstDetails show
ShowUnInstDetails show

; Languaje files
LangString LANGFILE ${LANG_SPANISH} "Espa�ol"
LangString LANGFILE ${LANG_ENGLISH} "English"
LangString LANGFILE ${LANG_POLISH} "Polski"
LangString LANGFILE ${LANG_FRENCH} "French"
LangString LANGFILE ${LANG_CZECH} "Czech"
LangString LANGFILE ${LANG_ITALIAN} "Italiano"
LangString LANGFILE ${LANG_RUSSIAN} "Russian"
LangString LANGFILE ${LANG_GERMAN} "German"
LangString LANGFILE ${LANG_GREEK} "Greek"
LangString LANGFILE ${LANG_TRADCHINESE} "Chinese_Traditional"
LangString LANGFILE ${LANG_SIMPCHINESE} "Chinese_Simplified"
LangString LANGFILE ${LANG_UKRAINIAN} "Ukrainian"
LangString LANGFILE ${LANG_PORTUGUESEBR} "Portuguese_Brazil"
LangString LANGFILE ${LANG_KOREAN} "Korean"
LangString LANGFILE ${LANG_HUNGARIAN} "Hungarian"

;--------------------------------------------------------------


Function .onInit
  !insertmacro MUI_LANGDLL_DISPLAY
FunctionEnd

!define MAX_MRU_ITEMS 9
var C
Function _AddToMRU
  Pop $R1 ; File to add to the MRU
  StrCpy $C 0 ; Clear variable
  loopbegin:
    IntOp $C $C + 1
    ifFileExists "$INSTDIR\nisedit.ini" 0 +3
    ReadIniStr $R0 "$INSTDIR\nisedit.ini" "Recent" "MRU$C"
    Goto +2
    ReadRegStr $R0 HKCU "Software\HM Software\Nis Edit\Recent" "MRU$C"
    StrCmp $R0 "" loopend
    StrCmp $R0 $R1 end ; File aready in the MRU
    Goto loopbegin
  loopend:
  IntCmp $C ${MAX_MRU_ITEMS} 0 0 end ; MRU full
  ifFileExists "$INSTDIR\nisedit.ini" 0 +3
  WriteIniStr "$INSTDIR\nisedit.ini" "Recent" "MRU$C" "$R1"
  Goto end
  WriteRegStr HKCU "Software\HM Software\Nis Edit\Recent" "MRU$C" "$R1"
  end:
FunctionEnd

!macro AddToMRU FILE_NAME
  Push "${FILE_NAME}"
  Call _AddToMRU
!macroend

Section "-" SEC01
  ; Si se instala sobre la versi�n anterior se hacen las modificaciones respectivas
  Delete $INSTDIR\Default.lng
  Delete $INSTDIR\English.lng
  Delete $INSTDIR\Ejemplo\Lic.txt
  Delete $INSTDIR\Ejemplo\App.hlp
  Delete $INSTDIR\Ejemplo\App.exe
  RmDir  $INSTDIR\Ejemplo
  
  Delete "$INSTDIR\CmpParsing.ini"
  Delete "$INSTDIR\CmpParsing-French.ini"
  Delete "$INSTDIR\HelpIndex.ini"
  Delete "$INSTDIR\NSIS.syn"

  SetOverwrite try
  SetOutPath "$INSTDIR"
  File "NISEdit.exe"
  CreateShortCut "$DESKTOP\HM NIS Edit.lnk" "$INSTDIR\NISEdit.exe"
  File "Setup.nsi"
  File "License.txt"
  File "Header.bmp"
  File "TIPS.txt"
  SetOverWrite off
  File "Templates.dat"

  ; Language files
  SetOverwrite on
  SetOutPath "$INSTDIR\Lang"
  File "Lang\Espa�ol.lng"
  File "Lang\English.lng"
  File "Lang\Polski.lng"
  File "Lang\French.lng"
  File "Lang\Czech.lng"
  File "Lang\Italiano.lng"
  File "Lang\Russian.lng"
  File "Lang\German.lng"
  File "Lang\Greek.lng"
  File "Lang\Chinese_Traditional.lng"
  File "Lang\Chinese_Simplified.lng"
  File "Lang\Ukrainian.lng"
  File "Lang\Portuguese_Brazil.lng"
  File "Lang\Korean.lng"
  File "Lang\Hungarian.lng"

  ; Configuration files
  SetOutPath "$INSTDIR\Config"
  File "Config\Syntax.ini"
  File "Config\IOCtrlFlags.ini"
  File "Config\HelpIndex.ini"
  File "Config\CmpParsing.ini"
  File "Config\CmpParsing-French.ini" ; <-- Para que amigos de Francia est�n contentos :)
  
  ; Plugins
  SetOutPath "$INSTDIR\Plugins"
  ; << Install some plugins >>
  SetOutPath "$INSTDIR\Plugins\ExDll\Delphi"
  File "Plugins\ExDll\Delphi\hmne_sample.dpr"
  File "Plugins\ExDll\Delphi\hmne_sample.dof"
  File "Source\PluginsInt.pas"
  SetOutPath "$INSTDIR\Plugins\ExDll\C"
  File "Plugins\ExDll\C\hmne_sample.dev"
  File "Plugins\ExDll\C\hmne_sample.c"
  File "Plugins\ExDll\C\PluginsInt.h"

  ifFileExists "$INSTDIR\nisedit.ini" 0 +4
  WriteIniStr "$INSTDIR\nisedit.ini" "Options" "Language" "$(LANGFILE)"
  WriteIniStr "$INSTDIR\nisedit.ini" "Options" "IntallLanguage" "$LANGUAGE"
  Goto +3
  WriteRegStr HKCU "Software\HM Software\Nis Edit\Options" "Language" "$(LANGFILE)"
  WriteRegStr HKCU "Software\HM Software\Nis Edit\Options" "IntallLanguage" "$LANGUAGE"
  !insertmacro AddToMRU "$INSTDIR\Setup.nsi"
  !insertmacro AddToMRU "$INSTDIR\TIPS.txt"
SectionEnd

Section -Post
  WriteUninstaller "$INSTDIR\uninst.exe"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\App Paths\NISEdit.exe" "" "$INSTDIR\NISEdit.exe"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\HM NIS Edit" "DisplayName" "$(^Name)"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\HM NIS Edit" "UninstallString" "$INSTDIR\uninst.exe"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\HM NIS Edit" "DisplayIcon" "$INSTDIR\NISEdit.exe"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\HM NIS Edit" "DisplayVersion" "${APP_VERSION}"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\HM NIS Edit" "URLUpdateInfo" "${APP_HOME_PAGE}"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\HM NIS Edit" "URLInfoAbout" "${APP_HOME_PAGE}"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\HM NIS Edit" "InstallLocation" "$INSTDIR"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\HM NIS Edit" "InstallSource" "$EXEDIR"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\HM NIS Edit" "Publisher" "Hector Maurcio Rodriguez Segura"
  WriteRegDWord HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\HM NIS Edit" "NoModifiy" 1
  WriteRegDWord HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\HM NIS Edit" "NoRepair" 1
  
  WriteRegStr HKCR "NSISFile\shell\HMNISEdit" "" "Edit with HM NIS Edit"
  WriteRegStr HKCR "NSISFile\shell\HMNISEdit\command" "" '$INSTDIR\NISEdit.exe "%1"'
  WriteRegStr HKCR "NSHFile\shell\HMNISEdit" "" "Edit with HM NIS Edit"
  WriteRegStr HKCR "NSHFile\shell\HMNISEdit\command" "" '$INSTDIR\NISEdit.exe "%1"'
SectionEnd

############################################################################################
;                                 Desinstalador                                            ;
############################################################################################


Function un.onInit
  FindWindow $R0 "THMNISEdit2_MainWindowClass"
  IsWindow $R0 0 +3
  MessageBox MB_ICONEXCLAMATION|MB_OK "Before uninstall HM NIS Edit you must close it."
  Abort

  ifFileExists "$INSTDIR\nisedit.ini" 0 +3
  ReadIniStr $LANGUAGE "$INSTDIR\nisedit.ini" "Options" "IntallLanguage"
  Goto +2
  ReadRegStr $LANGUAGE HKCU "Software\HM Software\Nis Edit\Options" "IntallLanguage"
FunctionEnd

Section Uninstall
  Delete "$INSTDIR\NISEdit.exe"
  Delete "$INSTDIR\License.txt"
  Delete "$INSTDIR\Setup.nsi"
  Delete "$INSTDIR\uninst.exe"
  Delete "$INSTDIR\Header.bmp"
  Delete "$INSTDIR\Templates.dat"
  Delete "$INSTDIR\TIPS.txt"
  Delete "$INSTDIR\nisedit.ini"

  Delete "$INSTDIR\Config\HelpIndex.ini"
  Delete "$INSTDIR\Config\Syntax.ini"
  Delete "$INSTDIR\Config\CmpParsing.ini"
  Delete "$INSTDIR\Config\CmpParsing-French.ini"
  Delete "$INSTDIR\Config\IOCtrlFlags.ini"

  Delete "$INSTDIR\Lang\Espa�ol.lng"
  Delete "$INSTDIR\Lang\English.lng"
  Delete "$INSTDIR\Lang\Polski.lng"
  Delete "$INSTDIR\Lang\French.lng"
  Delete "$INSTDIR\Lang\Czech.lng"
  Delete "$INSTDIR\Lang\Italiano.lng"
  Delete "$INSTDIR\Lang\Russian.lng"
  Delete "$INSTDIR\Lang\German.lng"
  Delete "$INSTDIR\Lang\Greek.lng"
  Delete "$INSTDIR\Lang\Chinese_Traditional.lng"
  Delete "$INSTDIR\Lang\Chinese_Simplified.lng"
  Delete "$INSTDIR\Lang\Ukrainian.lng"
  Delete "$INSTDIR\Lang\Portuguese_Brazil.lng"
  Delete "$INSTDIR\Lang\Korean.lng"
  Delete "$INSTDIR\Lang\Hungarian.lng"

  Delete "$INSTDIR\Plugins\ExDll\Delphi\hmne_sample.dpr"
  Delete "$INSTDIR\Plugins\ExDll\Delphi\hmne_sample.dof"
  Delete "$INSTDIR\Plugins\ExDll\Delphi\PluginsInt.pas"
  Delete "$INSTDIR\Plugins\ExDll\C\hmne_sample.dev"
  Delete "$INSTDIR\Plugins\ExDll\C\hmne_sample.c"
  Delete "$INSTDIR\Plugins\ExDll\C\PluginsInt.h"

  Delete "$DESKTOP\HM NIS Edit.lnk"

  RMDir "$INSTDIR\Plugins\ExDll\Delphi"
  RMDir "$INSTDIR\Plugins\ExDll\C"
  RMDir "$INSTDIR\Plugins\ExDll"
  RMDir "$INSTDIR\Plugins"
  RMDir "$INSTDIR\Config"
  RMDir "$INSTDIR\Lang"
  RMDir "$INSTDIR"

  DeleteRegKey HKCU "Software\HM Software\Nis Edit"
  DeleteRegKey /ifempty HKCU "Software\HM Software"
  
  DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\HM NIS Edit"
  DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\App Paths\NISEdit.exe"
  DeleteRegKey HKCR "NSISFile\shell\HMNISEdit"
  DeleteRegKey HKCR "NSHFile\shell\HMNISEdit"
  
  SetAutoClose false
SectionEnd
