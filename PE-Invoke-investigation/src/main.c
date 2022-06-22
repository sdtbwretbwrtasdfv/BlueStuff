#include <stdio.h>
#include <windows.h>
#include <locale.h>

#ifdef m64
	#include "embedded/autorunsc64_stub.h"
	#include "embedded/logonsessions64_stub.h"
	#include "embedded/pipelist64_stub.h"
#endif

#ifdef m32
	#include "embedded/autorunsc_stub.h"
	#include "embedded/logonsessions_stub.h"
	#include "embedded/pipelist_stub.h"
#endif



int mkdir(const char *pathname);

/* ################################# SYSINTERNALS SECTION #################################*/
int loggedon() {
	system("cmd /c query user >> .tmp/LoggedOn_not_admin.txt");
	FILE* file = fopen( "logonsessions.exe", "wb" );
	fwrite( logonsessions_stub, 1, sizeof(logonsessions_stub), file );
	fclose (file);
	int end = system("logonsessions.exe /accepteula >> .tmp/LoggedOn_admin.txt");
	system("del logonsessions.exe");
	return 0;
}
int pipes(){
	FILE* file = fopen( "pipelist.exe", "wb" );
	fwrite( pipelist_stub, 1, sizeof(pipelist_stub), file );
	fclose (file);
	int end = system("pipelist.exe /accepteula >> .tmp/Pipes.txt");
	system("del pipelist.exe");
	return 0;
}

int autoruns(char *part2) {
	FILE* file = fopen( "autorunsc.exe", "wb" );
	fwrite( autorunsc_stub, 1, sizeof(autorunsc_stub), file );
	fclose (file);
	char part1[] = "autorunsc.exe /accepteula ";
	char part3[] = " >> .tmp/Autoruns.txt";
	int size = strlen(part1) + strlen(part2) + strlen(part3) + 1;
	char *str = malloc(size);
	strcpy (str, part1);
  strcat (str, part2);
  strcat (str, part3);
	system(str);
	system("del autorunsc.exe");
	return 0;
}

/* ################################# SYSINTERNALS SECTION END #################################*/

/* ################################# WMI SECTION START #################################*/
int proc_enum() {
	system("wmic process list brief >> .tmp/Processes.txt");
	return 0;
}
int patches() {
	system("wmic qfe list >> .tmp/Patches.txt");
	return 0;
}
int network() {
	system("cmd /c netstat.exe -ab >> .tmp/Netstat.txt");
	system("cmd /c ipconfig /all >> .tmp/Ipconfig.txt");
	return 0;
}
int logs() {
	if(mkdir(".tmp/Logs") == -1)
		printf("\nCanno't create logs folder\n");
	system("copy C:\\Windows\\System32\\winevt\\Logs\\Security.evtx .tmp\\Logs\\");
	system("copy C:\\Windows\\System32\\winevt\\Logs\\System.evtx .tmp\\Logs\\");
	system("copy C:\\Windows\\System32\\winevt\\Logs\\Application.evtx .tmp\\Logs\\");
	system("copy \"C:\\Windows\\System32\\winevt\\Logs\\Windows PowerShell.evtx\" .tmp\\Logs\\");
	system("copy \"C:\\Windows\\System32\\winevt\\Logs\\Microsoft-Windows-TaskScheduler%4Maintenance.evtx\" .tmp\\Logs\\");
	system("copy \"C:\\Windows\\System32\\winevt\\Logs\\Microsoft-Windows-TaskScheduler%4Operational.evtx\" .tmp\\Logs\\");
	return 0;
}
/* ################################# WMI SECTION END #################################*/
/* ################################# TECHNICAL SECTION START #################################*/
int help() {
	printf("\n");
	printf("Example of usage: \n");
	printf("./investigator.exe run_type \n\n");
	printf("Available run_type's: \n");
	printf("     full                           - This is a full investigation. Network, process, autoruns, pipes, logs etc.\n");
	printf("\n");
	printf("     proc_enum                      - Enumerate of processes\n");
	printf("     patches                        - Enumerate KB's \n");
	printf("     network                        - Show network info \n");
	printf("     logs                           - Dump all Infosec logs \n");
	printf("\n");
	printf("     loggedon                       - Enumerate loggedon users \n");
	printf("     pipes                          - Dump all Infosec logs \n");
	printf("\n");
	printf("     autorun_all                    - Enumerate all methods of autostart \n");
	printf("     autorun_boot                   - Enumerate boot execute \n");
	printf("     autorun_appinit                - Enumerate appinit DLLs \n");
	printf("     autorun_explorer_addons        - Enumerate explorer addons \n");
	printf("     autorun_sidebar_gadgets        - Enumerate sidebar gadgets (Vista and higher) \n");
	printf("     autorun_img_hijacks            - Enumerate image hijacks \n");
	printf("     autorun_ie_addons              - Enumerate Internet Explorer addons \n");
	printf("     autorun_known_dlls             - Enumerate known DLLs \n");
	printf("     autorun_logon_startups         - Enumerate logon startups \n");
	printf("     autorun_wmi_entries            - Enumerate WMI entries \n");
	printf("     autorun_net_providers          - Enumerate winsock protocol and network providers \n");
	printf("     autorun_codecs                 - Enumerate codecs \n");
	printf("     autorun_print_mon_dlls         - Enumerate printer monitor DLLs \n");
	printf("     autorun_LSA_sec_providers      - Enumerate LSA security providers \n");
	printf("     autorun_autostart_services     - Enumerate autostart services and non-disabled drivers \n");
	printf("     autorun_scheduled_tasks        - Enumerate scheduled tasks \n");
	printf("     autorun_winlogon_entries       - Enumerate winlogon entries \n");
	printf("\n");
	printf("     help                           - Show help message \n");
	printf("\n");
	exit(0);
	return 0;
}
int prerun() {
	if(mkdir(".tmp") == -1)
		printf("\nCanno't create temp folder\n");
		system("systeminfo >> .tmp/System_information.txt");
	return 0;
}

int full() {
	proc_enum();
	patches();
	network();
	logs();
	loggedon();
	pipes();
	autoruns("-h -t -a *");
	return 0;
}

/* ################################# TECHNICAL SECTION  END #################################*/

int main( int argc,	char *argv[], char **envp ) {
	SetConsoleCP(1251);
	SetConsoleOutputCP(1251);
	setlocale(LC_ALL,"rus");
	printf("\n");
	printf("        /\\       \n");
	printf("       /  \\      \n");
	printf("      /,--.\\     \n");
	printf("     /< () >\\    \n");
	printf("    /  `--'  \\   \n");
	printf("   /          \\  \n");
	printf("  /            \\ \n");
	printf(" /______________\\\n");
	printf("Investigator v.1.0\n");
	int count;
	if(argc<2) {
		printf("\n");
		printf("\x1B[31mERROR: Not enough arguments\n\033[0m\t\t");
		help();
	}
	if(argc>2) {
		printf("\n");
		printf("\x1B[31mERROR: Too much arguments\n\033[0m\t\t");
		help();
		return 0;
	}
	if (strcmp(argv[1], "full") == 0) {
		prerun();
		int func_complete = full();
	}
	else if (strcmp(argv[1], "proc_enum") == 0) {
		prerun();
		int func_complete = proc_enum();
	}
	else if (strcmp(argv[1], "patches") == 0) {
		prerun();
		int func_complete = patches();
	}
	else if (strcmp(argv[1], "network") == 0) {																			/*ENCODING PROBLEMS*/
		prerun();
		int func_complete = network();
	}
	else if (strcmp(argv[1], "logs") == 0) {																				/*Системе не удается найти указанный путь.*/
		prerun();
		int func_complete = logs();
	}


	else if (strcmp(argv[1], "loggedon") == 0) {
		prerun();
		int func_complete = loggedon();
	}
	else if (strcmp(argv[1], "pipes") == 0) {
		prerun();
		int func_complete = pipes();
	}


	else if (strcmp(argv[1], "autorun_all") == 0) {
		prerun();
		autoruns("-h -t -a *");
	}
	else if (strcmp(argv[1], "autorun_boot") == 0) {
		prerun();
		autoruns("-h -t -a b");
	}
	else if (strcmp(argv[1], "autorun_appinit") == 0) {
		prerun();
		autoruns("-h -t -a d");
	}
	else if (strcmp(argv[1], "autorun_explorer_addons") == 0) {
		prerun();
		autoruns("-h -t -a e");
	}
	else if (strcmp(argv[1], "autorun_sidebar_gadgets") == 0) {
		prerun();
		autoruns("-h -t -a g");
	}
	else if (strcmp(argv[1], "autorun_img_hijacks") == 0) {
		prerun();
		autoruns("-h -t -a h");
	}
	else if (strcmp(argv[1], "autorun_ie_addons") == 0) {
		prerun();
		autoruns("-h -t -a i");
	}
	else if (strcmp(argv[1], "autorun_known_dlls") == 0) {
		prerun();
		autoruns("-h -t -a k");
	}
	else if (strcmp(argv[1], "autorun_logon_startups") == 0) {
		prerun();
		autoruns("-h -t -a l");
	}
	else if (strcmp(argv[1], "autorun_wmi_entries") == 0) {
		prerun();
		autoruns("-h -t -a m");
	}
	else if (strcmp(argv[1], "autorun_net_providers") == 0) {
		prerun();
		autoruns("-h -t -a n");
	}
	else if (strcmp(argv[1], "autorun_codecs") == 0) {
		prerun();
		autoruns("-h -t -a o");
	}
	else if (strcmp(argv[1], "autorun_print_mon_dlls") == 0) {
		prerun();
		autoruns("-h -t -a p");
	}
	else if (strcmp(argv[1], "autorun_LSA_sec_providers") == 0) {
		prerun();
		autoruns("-h -t -a r");
	}
	else if (strcmp(argv[1], "autorun_autostart_services") == 0) {
		prerun();
		autoruns("-h -t -a s");
	}
	else if (strcmp(argv[1], "autorun_scheduled_tasks") == 0) {
		prerun();
		autoruns("-h -t -a t");
	}
	else if (strcmp(argv[1], "autorun_winlogon_entries") == 0) {
		prerun();
		autoruns("-h -t -a w");
	}

	else if (strcmp(argv[1], "help") == 0) {
		prerun();
		help();
	}
	else {
		printf("\x1B[31mERROR: Invalid arguments\n\033[0m\t\t");
		help();
	}
	/*###################################################################*/
	system("powershell Compress-Archive -Path .tmp -DestinationPath %computername%.zip");
	system("RD /S /Q .tmp");
	/*system("tar -cf %computername%.%date%.zip .tmp");
	system("RD /S /Q .tmp");*/

	return 0;
}
