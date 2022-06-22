# Blue team stuff    (ノಠ ∩ಠ)ノ彡( \o°o)\
## _Why there are so much opensource tools for Red and so few for Blue?_

What is this:
- Invoke-investigation.ps1 - simple script for download different useful stuff from endpoint.
- MakeMeUNPWNABLE.bat - script for windows hardening. The most important point is 12, but I was unable to automate this. Script will show how to do this manually.


```sh
C:\Users\User>C:\Users\User\Downloads\MakeMeUNPWNABLE.bat
1. Disable LanManserver (WARNING! This will break software centre) [Y/N]? N
2. Disable Spooler (WARNING! This will break printing) [Y/N]? N
3. Disable RemoteRegistry (Can be used for latteral) [Y/N]? N
4. Disable WSearch (Can be used for persist) [Y/N]? N
5. Disable admin shares by registry (WARNING! This will PSexec to you PC) [Y/N]? N
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
## Warranty
DO NOT USE THIS FOR ILLEGAL PURPOSES.THE AUTHOR DOES NOT KEEP RESPONSIBILITY FOR ANY ILLEGAL ACTION YOU DO.
THERE IS NO WARRANTY FOR THE PROGRAM, TO THE EXTENT PERMITTED BY APPLICABLE LAW. 
THE ENTIRE RISK AS TO THE QUALITY AND PERFORMANCE OF THE PROGRAM IS WITH YOU

