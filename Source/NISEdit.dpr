{

  HM NIS Edit (c) 2003 Héctor Mauricio Rodríguez Segura <ranametal@users.sourceforge.net>

  To compile this project you need to install the next components:
    ToolBar2000 2.1.2 - http://www.jrsoftware.org/
    TBX 2.0 - http://www.g32.org
    ScrollingCredits 1.2 - http://web.eject.co.za/raoulsnyman/zips/credits.zip
    RTDesigner 2.0.11.29 - http://welcome.to/towebo
    ZPropList 1.2 - http://unicorn.micex.ru/users/gena
    SynEdit 1.1 - http://synedit.sourceforge.net/
    SynNSISSyn - SynHighlighterNSIS.pas in the project directory.
    TNewGroupBox - NewGroupBox.pas in the project directory.
    TMySynEditorOptionsContainer - MySynEditorOptionsContainer.pas in this project.

  The compiled exe is compressed with UPX http://upx.sourceforge.net/

  NOTE I use Delphi 5.0 and I don't have test this code to compile with other Delphi versions.


  ==============================================================================
  Copyright (C) 2003 Héctor Mauricio Rodríguez Segura <ranametal@users.sourceforge.net>

  This software is provided 'as-is', without any express or implied warranty.
  In no event will the authors be held liable for any damages arising from the
  use of this software.

  Permission is granted to anyone to use this software for any purpose,
  including commercial applications, and to alter it and redistribute it freely,
  subject to the following restrictions:

  1. The origin of this software must not be misrepresented; you must not claim
     that you wrote the original software. If you use this software in a product,
     an acknowledgment in the product documentation would be appreciated but is n
     ot required.

  2. Altered source versions must be plainly marked as such, and must not be
     misrepresented as being the original software.

  3. This notice may not be removed or altered from any source distribution.

  ==============================================================================

}
program NISEdit;

{%File '..\TODO.txt'}

uses
  XPTheme,
  Forms,
  Utils in 'Utils.pas',
  UMain in 'UMain.pas' {MainFrm},
  UEdit in 'UEdit.pas' {EditFrm},
  UEditSimbol in 'UEditSimbol.pas' {EditSimbolFrm},
  UAcerca in 'UAcerca.pas' {AboutFrm},
  UInputQuery in 'UInputQuery.pas' {InputQueryFrm},
  UStartup in 'UStartup.pas' {StartupFrm},
  UCodeTemplate in 'UCodeTemplate.pas' {CodeTemplateFrm},
  IOControls in 'IOControls.pas',
  UIODesigner in 'UIODesigner.pas' {IODesignerFrm},
  UCustomMDIChild in 'UCustomMDIChild.pas' {CustomMDIChild},
  UEditString in 'UEditString.pas' {EditStringsFrm},
  PropEditors in 'PropEditors.pas',
  USearch in 'USearch.pas' {SearchFrm},
  UReplace in 'UReplace.pas' {ReplaceFrm},
  UConfig in 'UConfig.pas' {ConfigFrm},
  MySynEditorOptionsContainer in 'MySynEditorOptionsContainer.pas',
  USplash in 'USplash.pas' {SplashFrm},
  UFilter in 'UFilter.pas' {FilterFrm},
  PluginsInt in 'PluginsInt.pas',
  PluginControls in 'PluginControls.pas',
  PluginsManger in 'PluginsManger.pas',
  UWizard in 'UWizard.pas' {WizardFrm},
  UEditLink in 'UEditLink.pas' {EditLinkFrm},
  UEditFile in 'UEditFile.pas' {EditFileFrm},
  ScriptGen in 'ScriptGen.pas',
  UIOTabOrder in 'UIOTabOrder.pas' {IOTabOrderFrm};

{$R *.RES}
{$R icons.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainFrm, MainFrm);
  Application.Run;
end.
