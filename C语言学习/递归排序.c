#include<stdio.h>
#define INTT_SIZE 10
#include<stdlib.h>

int main(void)
{
	char*num;
	int i,ch,size=INTT_SIZE;
	num=(char*)malloc(size*sizeof(char));
	ch=getchar();
	for(i=0;ch!='\n';i++)
	{
		if(i>=size){
			size*=2;
			num=(char*)realloc(num,size*sizeof(char));	
		}
		num[i]=ch;
		ch=getchar();
	}
	
	for(i--;i>=0;i--)
	if(num[i])
	putchar(num[i]);
	free(num);
	return 0;
	
} 