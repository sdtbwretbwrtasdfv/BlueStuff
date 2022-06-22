# Blue team stuff    (ノಠ ∩ಠ)ノ彡( \o°o)\
## _Why there are so much opensource tools for Red and so few for Blue?_

What is this:
- Invoke-investigation.ps1 - simple script for download different useful stuff from endpoint.
- MakeMeUNPWNABLE.bat - script for windows hardening. The most important point is 12, but I was unable to automate this. Script will show how to do this manually.
- PE-Invoke-investigation - is portable executable version of investigator, baised on aweasome Sysinternals tools (basicly blobs are hexed sysinternals exe). If you dont trust to unknown blobs just create your own win bin2sc.sh. This script will pack all the result to zip using PWSH.

```sh
C:\Users\User>C:\Users\User\Downloads\MakeMeUNPWNABLE.bat
1. Disable LanManserver (WARNING! This will break software centre) [Y/N]? N
2. Disable Spooler (WARNING! This will break printing) [Y/N]? N
3. Disable RemoteRegistry (Can be used for latteral) [Y/N]? N
4. Disable WSearch (Can be used for persist) [Y/N]? N
5. Disable admin shares by registry (WARNING! This will break PSexec to you PC) [Y/N]? N
6. Harden MS Office against common malspam attacks [Y/N]? N
7. Enable SmartScreen for Edge [Y/N]? N
8. Disable local creds caching [Y/N]? N
9. Disable Windows Credential Manager [Y/N]? N
10. Protect LSA from loading externals [Y/N]? N
11. Enable Windows Defender Credential Guard [Y/N]? N
12. Enable Restrictions for network logon (WARNING! Nobody except you will have possibility to logon to you PC) [Y/N]? N
13. Disable powershell v2 [Y/N]? N
14. Delete microsoft shitty and spying apps [Y/N]? N
```

```sh
C:\Users\User\Desktop\investigator_x64.exe

        /\
       /  \
      /,--.\
     /< () >\
    /  `--'  \
   /          \
  /            \
 /______________\
Investigator v.1.0

ERROR: Not enough arguments

Example of usage:
./investigator.exe run_type

Available run_type's:
     full                           - This is a full investigation. Network, process, autoruns, pipes, logs etc.

     proc_enum                      - Enumerate of processes
     patches                        - Enumerate KB's
     network                        - Show network info
     logs                           - Dump all Infosec logs

     loggedon                       - Enumerate loggedon users
     pipes                          - Dump all Infosec logs

     autorun_all                    - Enumerate all methods of autostart
     autorun_boot                   - Enumerate boot execute
     autorun_appinit                - Enumerate appinit DLLs
     autorun_explorer_addons        - Enumerate explorer addons
     autorun_sidebar_gadgets        - Enumerate sidebar gadgets (Vista and higher)
     autorun_img_hijacks            - Enumerate image hijacks
     autorun_ie_addons              - Enumerate Internet Explorer addons
     autorun_known_dlls             - Enumerate known DLLs
     autorun_logon_startups         - Enumerate logon startups
     autorun_wmi_entries            - Enumerate WMI entries
     autorun_net_providers          - Enumerate winsock protocol and network providers
     autorun_codecs                 - Enumerate codecs
     autorun_print_mon_dlls         - Enumerate printer monitor DLLs
     autorun_LSA_sec_providers      - Enumerate LSA security providers
     autorun_autostart_services     - Enumerate autostart services and non-disabled drivers
     autorun_scheduled_tasks        - Enumerate scheduled tasks
     autorun_winlogon_entries       - Enumerate winlogon entries

     help                           - Show help message
```

## Warranty
DO NOT USE THIS FOR ILLEGAL PURPOSES.THE AUTHOR DOES NOT KEEP RESPONSIBILITY FOR ANY ILLEGAL ACTION YOU DO.
THERE IS NO WARRANTY FOR THE PROGRAM, TO THE EXTENT PERMITTED BY APPLICABLE LAW. 
THE ENTIRE RISK AS TO THE QUALITY AND PERFORMANCE OF THE PROGRAM IS WITH YOU

