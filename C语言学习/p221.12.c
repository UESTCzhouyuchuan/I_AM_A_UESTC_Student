#include<stdio.h>
#include<string.h>
#define MAX 20
void get_extension(const char file_name[],char extension[]);

int main(void)
{
	char extension[5];
	char file_name[MAX+1];
	printf("Enter full name of a file: \n");
	gets(file_name);
	get_extension(file_name,extension);
	printf("The extension is: %s\n",extension);
}
void get_extension(const char file_name[],char extension[])
{
	int num=strlen(file_name);
	if(!num){
		*extension='\0';
		return;
	}
	for(file_name=file_name+num-1;*file_name!='.';file_name--);
	strcpy(extension,file_name+1);
	return;
}
