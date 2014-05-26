#include <stdio.h>
#include <stdlib.h>
#include<sys/stat.h>
#include <sys/types.h>
#include <sys/id.h>
#include <unistd.h>
#include <string.h>
#include <ctype.h>
#define MAXCHAR 40

int run_sys_call(char *buffer);
 
int main(int argc, char *argv[])
{
    char cmd[MAXCHAR];
    int cmd_status=0;

    setuid(0);
    if (setuid(0) != 0)
    {
        printf("setuid() error\n");
        printf("your uid id is %d\n", (int) getuid());
        exit(EXIT_FAILURE); 
    }
	int i;
	char cmdargv[MAXCHAR];
	strcpy(cmdargv, argv[1]);
	if (argc>2)
	{
		for(i=2;i<argc;i++)
		{
			strcat(cmdargv, " ");
			strcat(cmdargv, argv[i]);
		}
	}
	
  
    fflush(stdout);
    if (strncmp(argv[1], "null", 4)!=0 && strncmp(argv[1], "NULL", 4)!=0)
    {
    	sprintf(cmd,"ls %s\n", cmdargv); 
    	cmd_status=run_sys_call(cmd);
    	//if (cmd_status!=0)
    	//{
	//	printf("ERROR:CMD %s\n", cmd);
        //	exit(EXIT_FAILURE); 
    	//}
    }
    return cmd_status;
}

int run_sys_call(char *buffer)
{
    int res;
    int errmsg=0;
    res = system(buffer);
    if ( WEXITSTATUS(res) != 0 ) 
    {
	//printf("%s\n",buffer);
	//printf("System call failed.\n");
        errmsg=1;
    }
	
    return errmsg;
}
