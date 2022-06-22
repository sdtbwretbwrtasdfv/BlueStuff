REM v1.1
@echo off
setlocal EnableExtensions DisableDelayedExpansion

reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "HideFileExt" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "HideFileExt" /t REG_DWORD /d 0 /f
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Hidden" /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Hidden" /t REG_DWORD /d 1 /f
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowSuperHidden" /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowSuperHidden" /t REG_DWORD /d 1 /f

echo/
if exist "%SystemRoot%\System32\choice.exe" goto UseChoice

:UseChoice
%SystemRoot%\System32\choice.exe /C YN /N /M "1. Disable LanManserver (WARNING! This will break software centre) [Y/N]?"
if not errorlevel 1 goto UseChoice
if errorlevel 2 goto UseChoice2
:Continue
echo "Disabling LanManserver"
sc config "LanManserver" start= disabled
endlocal

:UseChoice2
%SystemRoot%\System32\choice.exe /C YN /N /M "2. Disable Spooler (WARNING! This will break printing) [Y/N]?"
if not errorlevel 1 goto UseChoice2
if errorlevel 2 goto UseChoice4
:Continue2
echo "Disabling Spooler"
sc config "Spooler" start= disabled
endlocal

:UseChoice4
%SystemRoot%\System32\choice.exe /C YN /N /M "3. Disable RemoteRegistry (Can be used for latteral) [Y/N]?"
if not errorlevel 1 goto UseChoice4
if errorlevel 2 goto UseChoice5
:Continue4
echo "Disabling RemoteRegistry"
sc config "RemoteRegistry" start= disabled
endlocal

:UseChoice5
%SystemRoot%\System32\choice.exe /C YN /N /M "4. Disable WSearch (Can be used for persist) [Y/N]?"
if not errorlevel 1 goto UseChoice5
if errorlevel 2 goto UseChoice6
:Continue5
echo "Disabling WSearch"
sc config "WSearch" start= disabled
endlocal

:UseChoice6
%SystemRoot%\System32\choice.exe /C YN /N /M "5. Disable admin shares by registry (WARNING! This will PSexec to you PC) [Y/N]?"
if not errorlevel 1 goto UseChoice6
if errorlevel 2 goto UseChoice7
:Continue6
echo "Disabling admin shares by registry"
REG ADD HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters /v AutoShareWks /t REG_DWORD /d 0 /f
endlocal

:UseChoice7
%SystemRoot%\System32\choice.exe /C YN /N /M "6. Harden MS Office against common malspam attacks [Y/N]?"
if not errorlevel 1 goto UseChoice7
if errorlevel 2 goto UseChoice8
:Continue7
echo "Disables Macros, enables ProtectedView"
reg add "HKCU\SOFTWARE\Microsoft\Office\12.0\Excel\Security" /v PackagerPrompt /t REG_DWORD /d 2 /f
reg add "HKCU\SOFTWARE\Microsoft\Office\12.0\Excel\Security" /v VBAWarnings /t REG_DWORD /d 4 /f
reg add "HKCU\SOFTWARE\Microsoft\Office\12.0\Excel\Security" /v WorkbookLinkWarnings /t REG_DWORD /d 2 /f
reg add "HKCU\SOFTWARE\Microsoft\Office\12.0\PowerPoint\Security" /v PackagerPrompt /t REG_DWORD /d 2 /f
reg add "HKCU\SOFTWARE\Microsoft\Office\12.0\PowerPoint\Security" /v VBAWarnings /t REG_DWORD /d 4 /f
reg add "HKCU\SOFTWARE\Microsoft\Office\12.0\Word\Options\vpref\fNoCalclinksOnopen_90_1" /t REG_DWORD /d 1 /f
reg add "HKCU\SOFTWARE\Microsoft\Office\12.0\Word\Security" /v PackagerPrompt /t REG_DWORD /d 2 /f
reg add "HKCU\SOFTWARE\Microsoft\Office\12.0\Word\Security" /v VBAWarnings /t REG_DWORD /d 4 /f
reg add "HKCU\SOFTWARE\Microsoft\Office\14.0\Excel\Options\DontUpdateLinks" /t REG_DWORD /d 1 /f
reg add "HKCU\SOFTWARE\Microsoft\Office\14.0\Excel\Security" /v PackagerPrompt /t REG_DWORD /d 2 /f
reg add "HKCU\SOFTWARE\Microsoft\Office\14.0\Excel\Security" /v VBAWarnings /t REG_DWORD /d 4 /f
reg add "HKCU\SOFTWARE\Microsoft\Office\14.0\Excel\Security" /v WorkbookLinkWarnings /t REG_DWORD /d 2 /f
reg add "HKCU\SOFTWARE\Microsoft\Office\14.0\PowerPoint\Security" /v PackagerPrompt /t REG_DWORD /d 2 /f
reg add "HKCU\SOFTWARE\Microsoft\Office\14.0\PowerPoint\Security" /v VBAWarnings /t REG_DWORD /d 4 /f
reg add "HKCU\SOFTWARE\Microsoft\Office\14.0\Word\Security" /v PackagerPrompt /t REG_DWORD /d 2 /f
reg add "HKCU\SOFTWARE\Microsoft\Office\14.0\Word\Security" /v VBAWarnings /t REG_DWORD /d 4 /f
reg add "HKCU\SOFTWARE\Microsoft\Office\14.0\Word\Security" /v AllowDDE /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Office\15.0\Excel\Options\DontUpdateLinks" /t REG_DWORD /d 1 /f
reg add "HKCU\SOFTWARE\Microsoft\Office\15.0\Excel\Security" /v PackagerPrompt /t REG_DWORD /d 2 /f
reg add "HKCU\SOFTWARE\Microsoft\Office\15.0\Excel\Security" /v VBAWarnings /t REG_DWORD /d 4 /f
reg add "HKCU\SOFTWARE\Microsoft\Office\15.0\Excel\Security" /v WorkbookLinkWarnings /t REG_DWORD /d 2 /f
reg add "HKCU\SOFTWARE\Microsoft\Office\15.0\PowerPoint\Security" /v PackagerPrompt /t REG_DWORD /d 2 /f
reg add "HKCU\SOFTWARE\Microsoft\Office\15.0\PowerPoint\Security" /v VBAWarnings /t REG_DWORD /d 4 /f
reg add "HKCU\SOFTWARE\Microsoft\Office\15.0\Word\Securitsy" /v PackagerPrompt /t REG_DWORD /d 2 /f
reg add "HKCU\SOFTWARE\Microsoft\Office\15.0\Word\Security" /v VBAWarnings /t REG_DWORD /d 4 /f
reg add "HKCU\SOFTWARE\Microsoft\Office\15.0\Word\Security" /v AllowDDE /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Office\16.0\Excel\Options\DontUpdateLinks" /t REG_DWORD /d 1 /f
reg add "HKCU\SOFTWARE\Microsoft\Office\16.0\Excel\Security" /v PackagerPrompt /t REG_DWORD /d 2 /f
reg add "HKCU\SOFTWARE\Microsoft\Office\16.0\Excel\Security" /v VBAWarnings /t REG_DWORD /d 4 /f
reg add "HKCU\SOFTWARE\Microsoft\Office\16.0\Excel\Security" /v WorkbookLinkWarnings /t REG_DWORD /d 2 /f
reg add "HKCU\SOFTWARE\Microsoft\Office\16.0\PowerPoint\Security" /v PackagerPrompt /t REG_DWORD /d 2 /f
reg add "HKCU\SOFTWARE\Microsoft\Office\16.0\PowerPoint\Security" /v VBAWarnings /t REG_DWORD /d 4 /f
reg add "HKCU\SOFTWARE\Microsoft\Office\16.0\Word\Security" /v PackagerPrompt /t REG_DWORD /d 2 /f
reg add "HKCU\SOFTWARE\Microsoft\Office\16.0\Word\Security" /v VBAWarnings /t REG_DWORD /d 4 /f
reg add "HKCU\SOFTWARE\Microsoft\Office\16.0\Word\Security" /v AllowDDE /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Office\Common\Security" /v DisableAllActiveX /t REG_DWORD /d 1 /f
endlocal

:UseChoice8
%SystemRoot%\System32\choice.exe /C YN /N /M "7. Enable SmartScreen for Edge [Y/N]?"
if not errorlevel 1 goto UseChoice8
if errorlevel 2 goto UseChoice9
:Continue8
echo "Enabling SmartScreen for Edge"
reg add "HKCU\SOFTWARE\Policies\Microsoft\MicrosoftEdge\PhishingFilter" /v EnabledV9 /t REG_DWORD /d 1 /f
endlocal

:UseChoice9
%SystemRoot%\System32\choice.exe /C YN /N /M "8. Disable local creds caching [Y/N]?"
if not errorlevel 1 goto UseChoice9
if errorlevel 2 goto UseChoice10
:Continue9
echo "Disabling local creds caching "
reg add "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon" /v CachedLogonsCount /t REG_SZ /d 0 /f
endlocal


:UseChoice10
%SystemRoot%\System32\choice.exe /C YN /N /M "9. Disable Windows Credential Manager [Y/N]?"
if not errorlevel 1 goto UseChoice10
if errorlevel 2 goto UseChoice11
:Continue10
echo "Disabling Windows Credential Manager "
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa" /v Disabledomaincreds /t REG_DWORD /d 1 /f
endlocal

:UseChoice11
%SystemRoot%\System32\choice.exe /C YN /N /M "10. Protect LSA from loading externals [Y/N]?"
if not errorlevel 1 goto UseChoice11
if errorlevel 2 goto UseChoice12
:Continue11
echo "Protecting LSA "
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa" /v RunAsPPL /t REG_DWORD /d 1 /f
endlocal

:UseChoice12
%SystemRoot%\System32\choice.exe /C YN /N /M "11. Enable Windows Defender Credential Guard [Y/N]?"
if not errorlevel 1 goto UseChoice12
if errorlevel 2 goto UseChoice13
:Continue12
echo "Enabling Windows Defender Credential Guard "
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\DeviceGuard" /v EnableVirtualizationBasedSecurity /t REG_DWORD /d 1 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\DeviceGuard" /v RequirePlatformSecurityFeatures /t REG_DWORD /d 1 /f
reg add "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\LSA" /v LsaCfgFlags /t REG_DWORD /d 1 /f
endlocal

:UseChoice13
%SystemRoot%\System32\choice.exe /C YN /N /M "12. Enable Restrictions for network logon (WARNING! Nobody except you will have possibility to logon to you PC) [Y/N]?"
if not errorlevel 1 goto UseChoice13
if errorlevel 2 goto UseChoice14
:Continue13
echo "You should do this manua:"
echo "1. Open gpedit.msc"
echo "2. go to Computer Configuration\Windows Settings\Security Settings\Local Policies\User Rights Assignment\Access this computer from the network"
echo "3. Del everything except yourself"
endlocal


:UseChoice14
%SystemRoot%\System32\choice.exe /C YN /N /M "13. Disable powershell v2 [Y/N]?"
if not errorlevel 1 goto UseChoice14
if errorlevel 2 goto UseChoice15
:Continue14
echo "Disabeling Powershell v2"
copy C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe tmp.exe
echo "" >> tmp.exe
tmp.exe Disable-WindowsOptionalFeature -Online -FeatureName MicrosoftWindowsPowerShellV2
del tmp.exe
endlocal


:UseChoice15
%SystemRoot%\System32\choice.exe /C YN /N /M "14. Delete microsoft shitty and spying apps [Y/N]?"
if not errorlevel 1 goto UseChoice15
if errorlevel 2 goto :EOF
:Continue15
echo "Microsoft dont spy..."
copy C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe tmp.exe
echo "" >> tmp.exe
tmp.exe -command "Get-AppxPackage *Microsoft.BingWeather* -AllUsers | Remove-AppxPackage"
tmp.exe -command "Get-AppxPackage *Microsoft.GetHelp* -AllUsers | Remove-AppxPackage"
tmp.exe -command "Get-AppxPackage *Microsoft.Getstarted* -AllUsers | Remove-AppxPackage"
tmp.exe -command "Get-AppxPackage *Microsoft.Messaging* -AllUsers | Remove-AppxPackage"
tmp.exe -command "Get-AppxPackage *Microsoft.Microsoft3DViewer* -AllUsers | Remove-AppxPackage"
tmp.exe -command "Get-AppxPackage *Microsoft.MicrosoftOfficeHub* -AllUsers | Remove-AppxPackage"
tmp.exe -command "Get-AppxPackage *Microsoft.MicrosoftSolitaireCollection* -AllUsers | Remove-AppxPackage"
tmp.exe -command "Get-AppxPackage *Microsoft.MixedReality.Portal* -AllUsers | Remove-AppxPackage"
tmp.exe -command "Get-AppxPackage *Microsoft.Office.OneNote* -AllUsers | Remove-AppxPackage"
tmp.exe -command "Get-AppxPackage *Microsoft.OneConnect* -AllUsers | Remove-AppxPackage"
tmp.exe -command "Get-AppxPackage *Microsoft.Print3D* -AllUsers | Remove-AppxPackage"
tmp.exe -command "Get-AppxPackage *Microsoft.SkypeApp* -AllUsers | Remove-AppxPackage"
tmp.exe -command "Get-AppxPackage *Microsoft.Wallet* -AllUsers | Remove-AppxPackage"
tmp.exe -command "Get-AppxPackage *Microsoft.WebMediaExtensions* -AllUsers | Remove-AppxPackage"
tmp.exe -command "Get-AppxPackage *Microsoft.WebpImageExtension* -AllUsers | Remove-AppxPackage"
tmp.exe -command "Get-AppxPackage *Microsoft.WindowsAlarms* -AllUsers | Remove-AppxPackage"
tmp.exe -command "Get-AppxPackage *Microsoft.WindowsCamera* -AllUsers | Remove-AppxPackage"
tmp.exe -command "Get-AppxPackage *microsoft.windowscommunicationsapps* -AllUsers | Remove-AppxPackage"
tmp.exe -command "Get-AppxPackage *Microsoft.WindowsFeedbackHub* -AllUsers | Remove-AppxPackage"
tmp.exe -command "Get-AppxPackage *Microsoft.WindowsMaps* -AllUsers | Remove-AppxPackage"
tmp.exe -command "Get-AppxPackage *Microsoft.WindowsSoundRecorder* -AllUsers | Remove-AppxPackage"
tmp.exe -command "Get-AppxPackage *Microsoft.Xbox.TCUI* -AllUsers | Remove-AppxPackage"
tmp.exe -command "Get-AppxPackage *Microsoft.XboxApp* -AllUsers | Remove-AppxPackage"
tmp.exe -command "Get-AppxPackage *Microsoft.XboxGameOverlay* -AllUsers | Remove-AppxPackage"
tmp.exe -command "Get-AppxPackage *Microsoft.XboxGamingOverlay* -AllUsers | Remove-AppxPackage"
tmp.exe -command "Get-AppxPackage *Microsoft.XboxIdentityProvider* -AllUsers | Remove-AppxPackage"
tmp.exe -command "Get-AppxPackage *Microsoft.XboxSpeechToTextOverlay* -AllUsers | Remove-AppxPackage"
tmp.exe -command "Get-AppxPackage *Microsoft.YourPhone* -AllUsers | Remove-AppxPackage"
tmp.exe -command "Get-AppxPackage *Microsoft.ZuneMusic* -AllUsers | Remove-AppxPackage"
tmp.exe -command "Get-AppxPackage *Microsoft.ZuneVideo* -AllUsers | Remove-AppxPackage"
tmp.exe -command "Get-AppxPackage *Microsoft.WindowsFeedback* -AllUsers | Remove-AppxPackage"
tmp.exe -command "Get-AppxPackage *Windows.ContactSupport* -AllUsers | Remove-AppxPackage"
tmp.exe -command "Get-AppxPackage *Duolingo* -AllUsers | Remove-AppxPackage"
tmp.exe -command "Get-AppxPackage *Microsoft.BingNews* -AllUsers | Remove-AppxPackage"
tmp.exe -command "Get-AppxPackage *Microsoft.Advertising.Xaml* -AllUsers | Remove-AppxPackage"

REM tmp.exe -command "Get-AppxProvisionedPackage -Online | Where-Object {$_.DisplayName -eq 'Microsoft.BingWeather'} | Remove-AppxProvisionedPackage -Online"
REM tmp.exe -command "Get-AppxProvisionedPackage -Online | Where-Object {$_.DisplayName -eq 'Microsoft.GetHelp'} | Remove-AppxProvisionedPackage -Online"
REM tmp.exe -command "Get-AppxProvisionedPackage -Online | Where-Object {$_.DisplayName -eq 'Microsoft.Getstarted'} | Remove-AppxProvisionedPackage -Online"
REM tmp.exe -command "Get-AppxProvisionedPackage -Online | Where-Object {$_.DisplayName -eq 'Microsoft.MicrosoftOfficeHub'} | Remove-AppxProvisionedPackage -Online"
REM tmp.exe -command "Get-AppxProvisionedPackage -Online | Where-Object {$_.DisplayName -eq 'Microsoft.MicrosoftSolitaireCollection'} | Remove-AppxProvisionedPackage -Online"
REM tmp.exe -command "Get-AppxProvisionedPackage -Online | Where-Object {$_.DisplayName -eq 'Microsoft.MixedReality.Portal'} | Remove-AppxProvisionedPackage -Online"
REM tmp.exe -command "Get-AppxProvisionedPackage -Online | Where-Object {$_.DisplayName -eq 'Microsoft.WindowsAlarms'} | Remove-AppxProvisionedPackage -Online"
REM tmp.exe -command "Get-AppxProvisionedPackage -Online | Where-Object {$_.DisplayName -eq 'microsoft.windowscommunicationsapps'} | Remove-AppxProvisionedPackage -Online"
REM tmp.exe -command "Get-AppxProvisionedPackage -Online | Where-Object {$_.DisplayName -eq 'Microsoft.WindowsFeedbackHub'} | Remove-AppxProvisionedPackage -Online"
REM tmp.exe -command "Get-AppxProvisionedPackage -Online | Where-Object {$_.DisplayName -eq 'Microsoft.WindowsMaps'} | Remove-AppxProvisionedPackage -Online"
REM tmp.exe -command "Get-AppxProvisionedPackage -Online | Where-Object {$_.DisplayName -eq 'Microsoft.WindowsSoundRecorder'} | Remove-AppxProvisionedPackage -Online"
REM tmp.exe -command "Get-AppxProvisionedPackage -Online | Where-Object {$_.DisplayName -eq 'Microsoft.XboxApp'} | Remove-AppxProvisionedPackage -Online"
REM tmp.exe -command "Get-AppxProvisionedPackage -Online | Where-Object {$_.DisplayName -eq 'Microsoft.XboxTCUI'} | Remove-AppxProvisionedPackage -Online"
REM tmp.exe -command "Get-AppxProvisionedPackage -Online | Where-Object {$_.DisplayName -eq 'Microsoft.XboxGameOverlay'} | Remove-AppxProvisionedPackage -Online"
REM tmp.exe -command "Get-AppxProvisionedPackage -Online | Where-Object {$_.DisplayName -eq 'Microsoft.XboxGamingOverlay'} | Remove-AppxProvisionedPackage -Online"
REM tmp.exe -command "Get-AppxProvisionedPackage -Online | Where-Object {$_.DisplayName -eq 'Microsoft.XboxIdentityProvider'} | Remove-AppxProvisionedPackage -Online"
REM tmp.exe -command "Get-AppxProvisionedPackage -Online | Where-Object {$_.DisplayName -eq 'Microsoft.YourPhone'} | Remove-AppxProvisionedPackage -Online"
REM tmp.exe -command "Get-AppxProvisionedPackage -Online | Where-Object {$_.DisplayName -eq 'Microsoft.ZuneMusic'} | Remove-AppxProvisionedPackage -Online"
REM tmp.exe -command "Get-AppxProvisionedPackage -Online | Where-Object {$_.DisplayName -eq 'Microsoft.ZuneVideo'} | Remove-AppxProvisionedPackage -Online"

del tmp.exe
endlocal


