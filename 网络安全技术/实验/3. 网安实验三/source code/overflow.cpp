#define _CRT_SECURE_NO_WARNINGS
#include <stdio.h>
#include <string.h>
#include <windows.h>
void overflow(char* buf)
{
	char des[5]="";
	strcpy(des,buf);
	return;
}
int main(int argc,char *argv[])
{
	LoadLibrary("user32.dll");
		//if(argc>1)
    char longbuf[100]="aaaaaaaaaaaabbbbcccccccccccc";
	overflow(longbuf);
//	overflow(argv[1]);
    return 0;
}
