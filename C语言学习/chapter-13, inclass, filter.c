#include<stdio.h>
#include<ctype.h>

int filter(char str[]);
int main(void)
{
	char str[51];
	int i,sum;
	printf("Pls input a sentence: \n");
	sum=filter(str);
	printf("total letters: %d\n",sum);
	printf("after filter: %s\n",str);
	return 0;
}

int filter(char str[])
{
	char ch,ch1;
	int i=0;
	do{
	ch=getchar();
	ch1=tolower(ch);
	if(ch1<='z'&&ch1>='a')
	str[i++]=ch;
	}while(ch!='\n');
	str[i]='\0';
	return i;

}