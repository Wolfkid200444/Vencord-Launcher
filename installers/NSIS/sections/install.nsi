Section /o "Discord Stable" InstallStable

	SetOutPath "$INSTDIR\Stable"
	File "/oname=Vencord.exe" "${BINARIES_ROOT}\vencord-stable.exe"
	File "${BINARIES_ROOT}\vencord_launcher.dll"

	WriteRegStr HKCU "Software\Vencord Launcher\Stable" "" "$INSTDIR\Stable"

	WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\Vencord" "DisplayName" "Vencord"
	WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\Vencord" "HelpLink" "https://vencord.dev"
	WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\Vencord" "InstallLocation" "$INSTDIR\Stable"
	WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\Vencord" "InstallSource" "https://vencord.dev"
	WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\Vencord" "UninstallString" "$\"$INSTDIR\Uninstall Vencord.exe$\" /Stable"
	WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\Vencord" "QuietUninstallString" "$\"$INSTDIR\Uninstall Vencord.exe$\" /Stable /S"
	WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\Vencord" "DisplayIcon" "$INSTDIR\Stable\Vencord.exe"

	CreateDirectory "$SMPROGRAMS\Vencord"
	CreateShortCut "$SMPROGRAMS\Vencord\Vencord.lnk" "$INSTDIR\Stable\Vencord.exe" "" "$INSTDIR\Stable\Vencord.exe"

SectionEnd


Section /o "Discord PTB" InstallPTB

	SetOutPath "$INSTDIR\PTB"
	File "/oname=Vencord PTB.exe" "${BINARIES_ROOT}\vencord-ptb.exe"
	File "${BINARIES_ROOT}\vencord_launcher.dll"

	WriteRegStr HKCU "Software\Vencord Launcher\PTB" "" "$INSTDIR\PTB"

	WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\Vencord PTB" "DisplayName" "Vencord PTB"
	WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\Vencord PTB" "HelpLink" "https://vencord.dev"
	WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\Vencord PTB" "InstallSource" "https://vencord.dev"
	WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\Vencord PTB" "InstallLocation" "$INSTDIR\PTB"
	WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\Vencord PTB" "UninstallString" "$\"$INSTDIR\Uninstall Vencord.exe$\" /PTB"
	WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\Vencord PTB" "QuietUninstallString" "$\"$INSTDIR\Uninstall Vencord.exe$\" /PTB /S"
	WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\Vencord PTB" "DisplayIcon" "$INSTDIR\PTB\Vencord PTB.exe"

	CreateDirectory "$SMPROGRAMS\Vencord"
	CreateShortCut "$SMPROGRAMS\Vencord\Vencord PTB.lnk" "$INSTDIR\PTB\Vencord PTB.exe" "" "$INSTDIR\PTB\Vencord PTB.exe"

SectionEnd


Section /o "Discord Canary" InstallCanary

	SetOutPath "$INSTDIR\Canary"
	File "/oname=Vencord Canary.exe" "${BINARIES_ROOT}\vencord-canary.exe"
	File "${BINARIES_ROOT}\vencord_launcher.dll"

	WriteRegStr HKCU "Software\Vencord Launcher\Canary" "" "$INSTDIR\Canary"

	WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\Vencord Canary" "DisplayName" "Vencord Canary"
	WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\Vencord Canary" "HelpLink" "https://vencord.dev"
	WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\Vencord Canary" "InstallSource" "https://vencord.dev"
	WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\Vencord Canary" "InstallLocation" "$INSTDIR\Canary"
	WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\Vencord Canary" "UninstallString" "$\"$INSTDIR\Uninstall Vencord.exe$\" /Canary"
	WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\Vencord Canary" "QuietUninstallString" "$\"$INSTDIR\Uninstall Vencord.exe$\" /Canary /S"
	WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\Vencord Canary" "DisplayIcon" "$INSTDIR\Canary\Vencord Canary.exe"

	CreateDirectory "$SMPROGRAMS\Vencord"
	CreateShortCut "$SMPROGRAMS\Vencord\Vencord Canary.lnk" "$INSTDIR\Canary\Vencord Canary.exe" "" "$INSTDIR\Canary\Vencord Canary.exe"

SectionEnd

Function .onInstSuccess

	WriteUninstaller "$INSTDIR\Uninstall Vencord.exe"

	CreateDirectory "$SMPROGRAMS\Vencord"

FunctionEnd
