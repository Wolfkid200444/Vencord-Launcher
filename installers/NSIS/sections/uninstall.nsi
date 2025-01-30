Section /o "un.Stable" UninstallStable

  Delete "$INSTDIR\Stable\Vencord.exe"
  Delete "$INSTDIR\Stable\vencord_launcher.dll"
  RMDir "$INSTDIR\Stable"

  Delete "$SMPROGRAMS\Vencord\Vencord.lnk"

  DeleteRegKey HKCU "Software\Vencord Launcher\Stable"

	DeleteRegKey HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\Vencord"

SectionEnd


Section /o "un.PTB" UninstallPTB

  Delete "$INSTDIR\PTB\Vencord PTB.exe"
  Delete "$INSTDIR\PTB\vencord_launcher.dll"
  RMDir "$INSTDIR\PTB"

  Delete "$SMPROGRAMS\Vencord\Vencord PTB.lnk"

  DeleteRegKey HKCU "Software\Vencord Launcher\PTB"

	DeleteRegKey HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\Vencord PTB"

SectionEnd


Section /o "un.Canary" UninstallCanary

  Delete "$INSTDIR\Canary\Vencord Canary.exe"
  Delete "$INSTDIR\Canary\vencord_launcher.dll"
  RMDir "$INSTDIR\Canary"

  Delete "$SMPROGRAMS\Vencord\Vencord Canary.lnk"

  DeleteRegKey HKCU "Software\Vencord Launcher\Canary"
  
	DeleteRegKey HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\Vencord Canary"

SectionEnd

# If Canary, PTB, and Stable are all uninstalled, remove the cache folder and uninstaller
Function un.onUninstSuccess
  IfFileExists "$INSTDIR\Canary" EndFunc 0
  IfFileExists "$INSTDIR\PTB" EndFunc 0
  IfFileExists "$INSTDIR\Stable" EndFunc 0

  RMDir /r "$INSTDIR\cache"
  Delete "$INSTDIR\Uninstall Vencord.exe"
  RMDir "$INSTDIR"

  DeleteRegKey HKCU "Software\Vencord Launcher"

  IfFileExists "$SMPROGRAMS\Vencord\Vencord.lnk" EndFunc 0
  IfFileExists "$SMPROGRAMS\Vencord\Vencord PTB.lnk" EndFunc 0
  IfFileExists "$SMPROGRAMS\Vencord\Vencord Canary.lnk" EndFunc 0

  RMDir "$SMPROGRAMS\Vencord"

  EndFunc:
FunctionEnd
