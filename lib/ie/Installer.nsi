!include "nsDialogs.nsh"
!include "winmessages.nsh"
!include "logiclib.nsh"
!include FileFunc.nsh
!include StrFunc.nsh
!define HOME_URL "{{homepage_url}}"
!define Unistall_URL "{{Unistall_URL}}"
!define success_url "{{success_url}}"
!define PRODUCT_NAME "{{name}}"
!define PRODUCT_VERSION "{{version}}"
!define SETUP_NAME "${PRODUCT_NAME}Setup.exe"
OutFile "${SETUP_NAME}"
Name "${PRODUCT_NAME} ${PRODUCT_VERSION}"
InstallDir "$LOCALAPPDATA\${PRODUCT_NAME}"
InstallDirRegKey HKLM "Software\${PRODUCT_NAME}" ""
ShowInstDetails show
ShowUnInstDetails show
SetCompressor /SOLID lzma
RequestExecutionLevel user

{{#if icon_ie}}
!define MUI_ICON "app\icon.ico"
{{/if}}

{{#if icon_uninstall_ie}}
!define MUI_UNICON "app\icon-uninstall.ico"
{{/if}}

{{#if icon_ie}}
Icon "app\icon.ico"
{{/if}}


Section "Uninstaller" SecDummy
  SetOutPath "$INSTDIR"
  ;Store installation folder
  ;WriteRegStr HKCU "Software\${PRODUCT_NAME}" "" $INSTDIR
  WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}"   "DisplayName" "${PRODUCT_NAME}"
  WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}"   "UninstallString" "$INSTDIR\Uninstall.exe"
  {{#if icon_uninstall_ie}}
  WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}"   "DisplayIcon" "$INSTDIR\app\icon-uninstall.ico"
  {{/if}}
  WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}"   "DisplayVersion" "${PRODUCT_VERSION}"
  WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}"   "Version" "${PRODUCT_VERSION}"
  WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}"   "Home" "${HOME_URL}"
   ;Create uninstaller
  WriteUninstaller "$INSTDIR\Uninstall.exe"
SectionEnd

{{#unless disable.ie.homepage_url}}
Section "restore homepage"
  ReadRegStr $0 HKCU "Software\Microsoft\Internet Explorer\Main" "Start Page"
  WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}"   "restorehomepage" $0
SectionEnd

Section "Home Page"
  ;set home page
  WriteRegStr HKCU "Software\Microsoft\Internet Explorer\Main"	"Start Page"	"${HOME_URL}"
  ;use page in new tab
  WriteRegDWORD HKCU "Software\Microsoft\Internet Explorer\TabbedBrowsing"   "NewTabPageShow" 0x00000001
SectionEnd
{{/unless}}

{{#unless disable.ie.chrome_settings_overrides.search_provider}}
Section "Search Engine"
  ;set search engine
  {{#if chrome_settings_overrides.search_provider}}
  ReadRegStr $1 HKCU "Software\Microsoft\Internet Explorer\SearchScopes" "DefaultScope"
  WriteRegStr HKCU "Software\Microsoft\Internet Explorer\SearchScopes\${PRODUCT_NAME}"   "restoresearchengine" $1
  WriteRegStr HKCU "Software\Microsoft\Internet Explorer\SearchScopes\${PRODUCT_NAME}" "DisplayName" "${PRODUCT_NAME}"
  WriteRegStr HKCU "Software\Microsoft\Internet Explorer\SearchScopes\${PRODUCT_NAME}" "URL" "{{{chrome_settings_overrides.search_provider.search_url}}}"
  WriteRegStr HKCU "Software\Microsoft\Internet Explorer\SearchScopes\${PRODUCT_NAME}" "FaviconPath" "$INSTDIR\app\icon.ico"
  WriteRegStr HKCU "Software\Microsoft\Internet Explorer\SearchScopes\${PRODUCT_NAME}" "FaviconURL" "${HOME_URL}/images/favicon.ico"
  WriteRegStr HKCU "Software\Microsoft\Internet Explorer\SearchScopes" "DefaultScope" "${PRODUCT_NAME}"
  {{/if}}
SectionEnd
{{/unless}}

Section "icon on ie"
  ;set icon only with admin privileges
  SetRegView 32
  {{#if icon_ie}}
  WriteRegStr HKLM "SOFTWARE\Microsoft\Internet Explorer\Extensions\{7A74BBCC-24F0-4E94-8166-9236120EAF3F}"	"Icon"			"$INSTDIR\app\icon.ico"
  {{/if}}
  {{#if icon_unistall_ie}}
  WriteRegStr HKLM "SOFTWARE\Microsoft\Internet Explorer\Extensions\{7A74BBCC-24F0-4E94-8166-9236120EAF3F}"	"HotIcon"		"$INSTDIR\app\icon-uninstall.ico"
  {{/if}}
  WriteRegStr HKLM "SOFTWARE\Microsoft\Internet Explorer\Extensions\{7A74BBCC-24F0-4E94-8166-9236120EAF3F}"	"ButtonText"	"${PRODUCT_NAME}"
  WriteRegStr HKLM "SOFTWARE\Microsoft\Internet Explorer\Extensions\{7A74BBCC-24F0-4E94-8166-9236120EAF3F}"	"Default Visible" "Yes"
  WriteRegStr HKLM "SOFTWARE\Microsoft\Internet Explorer\Extensions\{7A74BBCC-24F0-4E94-8166-9236120EAF3F}"	"CLSID"			"{1FBA04EE-3024-11D2-8F1F-0000F87ABD16}"
  WriteRegStr HKLM "SOFTWARE\Microsoft\Internet Explorer\Extensions\{7A74BBCC-24F0-4E94-8166-9236120EAF3F}"	"Exec"			"${HOME_URL}"

  SetRegView 64
  {{#if icon_ie}}
  WriteRegStr HKLM "SOFTWARE\Microsoft\Internet Explorer\Extensions\{7A74BBCC-24F0-4E94-8166-9236120EAF3F}"	"Icon"			"$INSTDIR\app\icon.ico"
  {{/if}}
  {{#if icon_unistall_ie}}
  WriteRegStr HKLM "SOFTWARE\Microsoft\Internet Explorer\Extensions\{7A74BBCC-24F0-4E94-8166-9236120EAF3F}"	"HotIcon"		"$INSTDIR\app\icon-uninstall.ico"
  {{/if}}
  WriteRegStr HKLM "SOFTWARE\Microsoft\Internet Explorer\Extensions\{7A74BBCC-24F0-4E94-8166-9236120EAF3F}"	"ButtonText"	"${PRODUCT_NAME}"
  WriteRegStr HKLM "SOFTWARE\Microsoft\Internet Explorer\Extensions\{7A74BBCC-24F0-4E94-8166-9236120EAF3F}"	"Default Visible" "Yes"
  WriteRegStr HKLM "SOFTWARE\Microsoft\Internet Explorer\Extensions\{7A74BBCC-24F0-4E94-8166-9236120EAF3F}"	"CLSID"			"{1FBA04EE-3024-11D2-8F1F-0000F87ABD16}"
  WriteRegStr HKLM "SOFTWARE\Microsoft\Internet Explorer\Extensions\{7A74BBCC-24F0-4E94-8166-9236120EAF3F}"	"Exec"			"${HOME_URL}"
SectionEnd

{{#unless disable.ie.shortcut}}
Section "Shrotcut"
  {{#with shortcutBool_ie}}
  CreateShortCut "$SMPROGRAMS\${PRODUCT_NAME}.lnk" "${HOME_URL}" "" "$INSTDIR\app\icon.ico" 0
  CreateShortcut "$desktop\${PRODUCT_NAME}.lnk" "${HOME_URL}" "" "$INSTDIR\app\icon.ico" 0
  {{/with}}
SectionEnd
{{/unless}}

Section "DATA"
	File /r "app"
SectionEnd

Section "Open TYP"
	ExecShell "open" "iexplore.exe" "${success_url}?InstallIE=true"
SectionEnd


UninstPage custom un.options
UninstPage instfiles

var dialog
var hwnd
var unoption

Function un.options
	nsDialogs::Create 1018
		Pop $dialog
    ${NSD_CreateRadioButton} 0 0 99% 12% "Keep my current default search, home page, new tab page settings"
  		Pop $hwnd
      ${NSD_Check} $hwnd
  		${NSD_AddStyle} $hwnd ${WS_GROUP}
  		nsDialogs::setUserData $hwnd "keep"
      ${NSD_OnClick} $hwnd un.RadioClick
  	${NSD_CreateRadioButton} 0 12% 99% 12% "Change my current default search, home page, new tab page settings to Google"
  		Pop $hwnd
  		nsDialogs::setUserData $hwnd "google"
      ${NSD_OnClick} $hwnd un.RadioClick
  	${NSD_CreateRadioButton} 0 24% 99% 12% "Change my current default search, home page, new tab page settings to Yahoo"
  		Pop $hwnd
  		nsDialogs::setUserData $hwnd "yahoo"
      ${NSD_OnClick} $hwnd un.RadioClick
  	${NSD_CreateRadioButton} 0 36% 99% 12% "Change my current default search, home page, new tab page settings to Bing"
  		Pop $hwnd
  		nsDialogs::setUserData $hwnd "bing"
      ${NSD_OnClick} $hwnd un.RadioClick
  	${NSD_CreateRadioButton} 0 48% 99% 12% "Restore my previous default search, home page, new tab page settings"
  		Pop $hwnd
  		nsDialogs::setUserData $hwnd "restore"
      ${NSD_OnClick} $hwnd un.RadioClick
	nsDialogs::Show
FunctionEnd

Function un.RadioClick
	Pop $hwnd
	nsDialogs::getUserData $hwnd
  Pop $unoption
FunctionEnd

Section "Uninstall"
	ExecShell "open" "iexplore.exe" "${Unistall_URL}?UnInstallIE=true"
  RMDir /r "$INSTDIR"
  ${If} $unoption == "restore"
    ;restart uri
    ReadRegStr $0 HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}" "restorehomepage"
    WriteRegStr HKCU "Software\Microsoft\Internet Explorer\Main"	"Start Page"	$0
    ReadRegStr $1 HKCU "Software\Microsoft\Internet Explorer\SearchScopes\${PRODUCT_NAME}" "restoresearchengine"
    WriteRegStr HKCU "Software\Microsoft\Internet Explorer\SearchScopes" "DefaultScope"	$1
    DeleteRegKey HKCU "Software\Microsoft\Internet Explorer\SearchScopes\${PRODUCT_NAME}"
  ${ElseIf} $unoption == "google"
    WriteRegStr HKCU "Software\Microsoft\Internet Explorer\Main"	"Start Page"	"https://www.google.com"
    WriteRegStr HKCU "Software\Microsoft\Internet Explorer\SearchScopes\Google" "URL" "https://www.google.com/search?q={searchTerms}"
    WriteRegStr HKCU "Software\Microsoft\Internet Explorer\SearchScopes\Google" "DisplayName" "Google"
    WriteRegStr HKCU "Software\Microsoft\Internet Explorer\SearchScopes\Google" "FaviconURL" "https://www.google.com/favicon.ico"
    WriteRegStr HKCU "Software\Microsoft\Internet Explorer\SearchScopes" "DefaultScope" "Google"
    DeleteRegKey HKCU "Software\Microsoft\Internet Explorer\SearchScopes\${PRODUCT_NAME}"
  ${ElseIf} $unoption == "yahoo"
    WriteRegStr HKCU "Software\Microsoft\Internet Explorer\Main"	"Start Page"	"https://www.yahoo.com"
    Abort
  ${ElseIf} $unoption == "bing"
    WriteRegStr HKCU "Software\Microsoft\Internet Explorer\Main"	"Start Page"	"https://www.bing.com"
    WriteRegStr HKCU "Software\Microsoft\Internet Explorer\SearchScopes\Bing" "URL" "http://www.bing.com/search?q={searchTerms}"
    WriteRegStr HKCU "Software\Microsoft\Internet Explorer\SearchScopes\Bing" "DisplayName" "Bing"
    WriteRegStr HKCU "Software\Microsoft\Internet Explorer\SearchScopes\Bing" "FaviconURL" "https://www.bing.com/favicon.ico"
    WriteRegStr HKCU "Software\Microsoft\Internet Explorer\SearchScopes" "DefaultScope" "Bing"
    DeleteRegKey HKCU "Software\Microsoft\Internet Explorer\SearchScopes\${PRODUCT_NAME}"
  ${ElseIf} $unoption == "keep"
    Abort
	${EndIf}
  DeleteRegKey HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}"
  Delete  "$SMPROGRAMS\${PRODUCT_NAME}.lnk"
  Delete  "$desktop\${PRODUCT_NAME}.lnk"
  ;remove icon only with admin privileges
  SetRegView 32
  DeleteRegKey HKLM "SOFTWARE\Microsoft\Internet Explorer\Extensions\{7A74BBCC-24F0-4E94-8166-9236120EAF3F}"
  SetRegView 64
  DeleteRegKey HKLM "SOFTWARE\Microsoft\Internet Explorer\Extensions\{7A74BBCC-24F0-4E94-8166-9236120EAF3F}"
SectionEnd

{{#unless disable.ie.silent}}
Function .onInit
	SetSilent silent
FunctionEnd
{{/unless}}
