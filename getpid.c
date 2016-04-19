# include<stdio.h>
# include<string.h>
# include<stdlib.h>
int get_pid(char*str)
{   
	char cmd[100]="pidof ";
	strcat(cmd,str); 
	int pid=system(cmd);
	return pid;
}
int main()
{
	
	printf("%d",get_pid("firefox"));
	
return 0;
}
