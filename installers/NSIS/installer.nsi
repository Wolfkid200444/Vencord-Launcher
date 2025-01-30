;NSIS Modern User Interface
;Welcome/Finish Page Example Script
;Written by Joost Verburg

;--------------------------------
;Imports
	

	!include "MUI2.nsh"
	!include "FileFunc.nsh"
	!include "headers.nsh"


;--------------------------------
;General

	;Name and file
	Name "${PRODUCT_NAME} ${PRODUCT_VERSION}"
	OutFile "Vencord Installer.exe"
	Icon "${ASSETS_ROOT}\icon.ico"
	Unicode True

	;Default installation folder
	InstallDir "$LOCALAPPDATA\VencordLauncher"

	;Get installation folder from registry if available
	InstallDirRegKey HKCU "Software\Vencord Launcher" ""

	ShowInstDetails show
	ShowUnInstDetails show

	;Request application privileges for Windows Vista
	RequestExecutionLevel user

;--------------------------------
;Interface Settings

	!define MUI_ABORTWARNING
	
	!define MUI_ICON "${ASSETS_ROOT}\icon.ico"
	!define MUI_UNICON "${ASSETS_ROOT}\icon.ico"
	!define MUI_UI_HEADERIMAGE_RIGHT "${ASSETS_ROOT}\icon.bmp"

	!define MUI_WELCOMEFINISHPAGE_BITMAP "${ASSETS_ROOT}\welcome.bmp"
	!define MUI_WELCOMEPAGE_TEXT "Welcome to the Vencord Installer.$\n\
	$\n\
	On the next screen, you will be able to pick which versions of Vencord for Discord you would like to install."

	!define MUI_COMPONENTSPAGE_SMALLDESC

	!define MUI_FINISHPAGE_NOAUTOCLOSE
	!define MUI_UNFINISHPAGE_NOAUTOCLOSE

;--------------------------------
;Pages

	 !insertmacro MUI_PAGE_WELCOME
;	 !insertmacro MUI_PAGE_LICENSE "${NSISDIR}\Docs\Modern UI\License.txt"
	!insertmacro MUI_PAGE_COMPONENTS
	!insertmacro MUI_PAGE_DIRECTORY
	!insertmacro MUI_PAGE_INSTFILES
	!insertmacro MUI_PAGE_FINISH

	!insertmacro MUI_UNPAGE_WELCOME
	!insertmacro MUI_UNPAGE_COMPONENTS
	!insertmacro MUI_UNPAGE_CONFIRM
	!insertmacro MUI_UNPAGE_INSTFILES
	!insertmacro MUI_UNPAGE_FINISH

;--------------------------------
;Languages

	!insertmacro MUI_LANGUAGE "English"

;--------------------------------
;Installer Attributes

	VIProductVersion "${PRODUCT_VERSION}"
	VIAddVersionKey /LANG=${LANG_ENGLISH} "ProductName" "${PRODUCT_NAME}"
	VIAddVersionKey /LANG=${LANG_ENGLISH} "CompanyName" "${PRODUCT_PUBLISHER}"
	VIAddVersionKey /LANG=${LANG_ENGLISH} "FileVersion" "${PRODUCT_VERSION}"
	VIAddVersionKey /LANG=${LANG_ENGLISH} "ProductVersion" "${PRODUCT_VERSION}"
	VIAddVersionKey /LANG=${LANG_ENGLISH} "FileDescription" "${PRODUCT_NAME} Installer"
	VIAddVersionKey /LANG=${LANG_ENGLISH} "LegalCopyright" "© ${PRODUCT_PUBLISHER}"
	VIAddVersionKey /LANG=${LANG_ENGLISH} "Comments" "meow meow meow"

;--------------------------------
;Installer Sections


	!include "sections\install.nsi"

	!include "sections\uninstall.nsi"

!macro CheckParam Flag Section
	${GetParameters} $R0
	${GetOptions} $R0 ${Flag} $R1
	${IfNot} ${Errors}
		SectionSetFlags ${Section} ${SF_SELECTED}
	${EndIf}
!macroend
	
Function .onInit
	
	!insertmacro CheckParam "/Stable" ${InstallStable}
	!insertmacro CheckParam "/PTB" ${InstallPTB}
	!insertmacro CheckParam "/Canary" ${InstallCanary}

	!insertmacro CheckParam "/All" ${InstallStable}
	!insertmacro CheckParam "/All" ${InstallPTB}
	!insertmacro CheckParam "/All" ${InstallCanary}

	# If InstallPTB and InstallCanary are *not* set, then set SF_SELECTED on stable
	SectionGetFlags ${InstallPTB} $0
	SectionGetFlags ${InstallCanary} $1

	IntOp $0 $0 | $1
	${If} $0 == 0
		SectionSetFlags ${InstallStable} ${SF_SELECTED}
	${EndIf}

FunctionEnd

Function un.onInit
	
	!insertmacro CheckParam "/Stable" ${UninstallStable}
	!insertmacro CheckParam "/PTB" ${UninstallPTB}
	!insertmacro CheckParam "/Canary" ${UninstallCanary}
	
	# If no flags are set, mark all for uninstallation.
	SectionGetFlags ${UninstallStable} $0
	SectionGetFlags ${UninstallPTB} $1
	SectionGetFlags ${UninstallCanary} $2

	IntOp $0 $0 | $1
	IntOp $0 $0 | $2
	${If} $0 == 0
		SectionSetFlags ${UninstallStable} ${SF_SELECTED}
		SectionSetFlags ${UninstallPTB} ${SF_SELECTED}
		SectionSetFlags ${UninstallCanary} ${SF_SELECTED}
	${EndIf}

FunctionEnd

;--------------------------------
;Descriptions

	;Language strings
	LangString DESC_InstallStable ${LANG_ENGLISH} "Install Vencord for Discord Stable"
	LangString DESC_InstallPTB ${LANG_ENGLISH} "Install Vencord for Discord PTB"
	LangString DESC_InstallCanary ${LANG_ENGLISH} "Install Vencord for Discord Canary"

	;Assign language strings to sections
	!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
		!insertmacro MUI_DESCRIPTION_TEXT ${InstallStable} $(DESC_InstallStable)
		!insertmacro MUI_DESCRIPTION_TEXT ${InstallPTB} $(DESC_InstallPTB)
		!insertmacro MUI_DESCRIPTION_TEXT ${InstallCanary} $(DESC_InstallCanary)
	!insertmacro MUI_FUNCTION_DESCRIPTION_END


	LangString DESC_UninstallStable ${LANG_ENGLISH} "Uninstall Vencord for Discord Stable"
	LangString DESC_UninstallPTB ${LANG_ENGLISH} "Uninstall Vencord for Discord PTB"
	LangString DESC_UninstallCanary ${LANG_ENGLISH} "Uninstall Vencord for Discord Canary"

	!insertmacro MUI_UNFUNCTION_DESCRIPTION_BEGIN
		!insertmacro MUI_DESCRIPTION_TEXT ${UninstallStable} $(DESC_UninstallStable)
		!insertmacro MUI_DESCRIPTION_TEXT ${UninstallPTB} $(DESC_UninstallPTB)
		!insertmacro MUI_DESCRIPTION_TEXT ${UninstallCanary} $(DESC_UninstallCanary)
	!insertmacro MUI_UNFUNCTION_DESCRIPTION_END

