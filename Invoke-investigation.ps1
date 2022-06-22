$Domain = Read-Host -Prompt 'Input the domain name'
$Server = Read-Host -Prompt 'Input the server name'

$BlueteamServer = Read-Host -Prompt 'Where to save results?'


#$User = Read-Host -Prompt 'Input the user name'
#$Pass = Read-Host -Prompt 'Input the user password'
$Date = (Get-Date).AddDays(-1) 
$Day = $Date.Day
$Month = $Date.Month 
$Year = $Date.Year
$ProjDir = "$($Server).$($Day).$($Month).$($Year)"
$CurrentDir = (Get-Item -Path ".\").FullName
mkdir $ProjDir
cd $ProjDir
mkdir Logs
$Separator = "#####################################################################################################################################################################################################"
function process_enum {
echo "Enumerating processes"
echo 'If you wanna query info about specific PID use: wmic /node:hostname process where "ProcessID=12152" get CommandLine, ExecutablePath'
wmic /node:$Server process list brief; wmic /node:$Server process list brief >> 1.Processes.txt
}
function processes_by_user{
$user_name = Read-Host -Prompt 'Enter the user name'
Get-WmiObject win32_process -ComputerName $Server |Select-Object Name,@{n='Owner';e={$_.GetOwner().User}} >> processes
cat .\processes |Select-String -pattern $user_name
del
}
function startup_enum {
echo "Enumerating StartUp"
wmic /node:$Server startup list full; wmic /node:$Server startup list full >> 2.StartUp.txt
}
function patches_enum {
echo "Enumerating patches"
wmic /node:$Server qfe list; wmic /node:$Server qfe list >> 3.Patches.txt
}
function loggedon_enum {
echo "Logged on users"
query user /server:$Server; query user /server:$Server >> 4.LoggedOn.txt
}
function service_enum {
echo "All services is presented in file Services_all.txt"
wmic /node:$Server service list >> 5.Services_all.txt
}
function autostart_enum {
echo "Services AutoStart"
cmd /c 'wmic /node:'$Server ' SERVICE WHERE StartMode="Auto" GET Name, State'; cmd /c 'wmic /node:'$Server ' SERVICE WHERE StartMode="Auto" GET Name, State'  >> 6.Services.Autorstart.txt
}
function running_services_enum {
echo "Running services"
cmd /c 'Wmic /node:'$Server ' SERVICE WHERE (state="running") get caption, name, startmode, state'; cmd /c 'Wmic /node:'$Server ' SERVICE WHERE (state="running") get caption, name, startmode, state' >> 6.Services.Running.txt
}
function netstat_enum {
echo "List network connections"
cmd /c 'wmic /node:'$Server ' process call create "cmd /c netstat.exe -ab >> C:\users\public\connections.txt" 2>&1' 
sleep 5
cat \\$Server\C$\users\public\connections.txt
cat \\$Server\C$\users\public\connections.txt >> 8.Netstat.txt
del \\$Server\C$\users\public\connections.txt
}
function get_some_logs {
echo "Dwonloading logs"
echo $Separator
copy \\$Server\C$\Windows\System32\winevt\Logs\Security.evtx Logs\
copy \\$Server\C$\Windows\System32\winevt\Logs\'Windows PowerShell.evtx' Logs\
copy \\$Server\C$\Windows\System32\winevt\Logs\System.evtx Logs\
copy \\$Server\C$\Windows\System32\winevt\Logs\'Kaspersky Event Log.evtx' Logs\
}
function get_shell {
$question = 'PsExec on dat host?'
$choices = New-Object Collections.ObjectModel.Collection[Management.Automation.Host.ChoiceDescription]
$choices.Add((New-Object Management.Automation.Host.ChoiceDescription -ArgumentList '&Yes'))
$choices.Add((New-Object Management.Automation.Host.ChoiceDescription -ArgumentList '&No'))
$decision = $Host.UI.PromptForChoice($title, $question, $choices, 1)
if ($decision -eq 0) {
    $Content = [System.Convert]::FromBase64String($psexec)
	Set-Content -Path itsnotpsexecanymore.exe -Value $Content -Encoding Byte
	./itsnotpsexecanymore.exe \\$Server cmd
} else {
    Write-Host 'OKAY :('
}
}
function full_investigation {
clear
echo 'Full investigation'
echo $Separator
process_enum
echo $Separator
startup_enum
echo $Separator
autostart_enum
echo $Separator
patches_enum
echo $Separator
loggedon_enum
echo $Separator
service_enum
echo $Separator
running_services_enum
echo $Separator
netstat_enum
echo $Separator
get_some_logs
echo $Separator
cd ../
Robocopy.exe .\$ProjDir\ \\$BlueteamServer\$ProjDir /z /E 
}

#####################################################################################################################################################################################################
#BINS section
#####################################################################################################################################################################################################

#####################################################################################################################################################################################################
function Show-Menu
{
     param (
           [string]$Title = 'Invoke-investigation'
     )
     cls
	Write-Host "================ $Title ================"
    
	Write-Host "1: Full investigation."
	Write-Host "2: Enumerate processes."
	Write-Host "3: Processes by user."
	Write-Host "4: Enumerate startup apps." 
	Write-Host "5: Enumerate autostart."
	Write-Host "6: Enumerate patches."
	Write-Host "7: Enumerate logged on users."
	Write-Host "8: Enumerate services."
	Write-Host "9: Enumerate running services."
	Write-Host "10: Enumerate network connections."
	Write-Host "11: Get logs."					 
	Write-Host "Q: Press 'Q' to quit."
}
do
{
     Show-Menu
     $input = Read-Host "Please make a selection"
     switch ($input)
     {
           '1' {
                cls
				full_investigation
            } '2' {
                cls
                process_enum
            } '3' {
                cls
                processes_by_user			
            } '4' {
                cls
                startup_enum
			} '5' {
                cls
                autostart_enum				
			} '6' {
                cls
				patches_enum
			} '7' {
                cls
				loggedon_enum
			} '8' {
                cls
				service_enum
			} '9' {
                cls
				running_services_enum
			} '10' {
                cls
				netstat_enum
			} '11' {
                cls
                get_some_logs			
           } 'q' {
                return
           }
     }
     pause
}
until ($input -eq 'q')
