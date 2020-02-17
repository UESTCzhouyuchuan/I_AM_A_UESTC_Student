#include<stdio.h>
#define MAX 100
#include<ctype.h>
#include<stdlib.h>
#include<stdbool.h>

int capitalization(char str[]);

int main(void)
{
	char *str;
	str=(char*)malloc(MAX*sizeof(char));
	printf("Pls input a sentence: \n");
	gets(str);
	printf("Total words: %d\n",capitalization(str));
	printf("After capitalization: %s",str);
	return 0;
	
}
/*int capitalization(char str[])
{
	int i=1;
	while((*str)==' ')
	str++;
	*str=toupper(*str);
	
	for(;*str!='\0';str++)
	{
		if(*(str-1)==' '){
			*str=toupper(*str);
			i++;
		}
		
	}
	return i; 
}*/

int capitalization(char*s)
{
	int i;
	int num_words=0;
	bool is_word=false;
	for(i = 0;s[i]!='\0';s++)
	{
		if(s[i]==' ')
        is_word = false;
        else if(!is_word)
        {
        	num_words++;
        	s[i]=toupper(s[i]);
        	is_word = true;
        }
	}
	return num_words;
	
}
