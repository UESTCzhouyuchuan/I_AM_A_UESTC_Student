#include<stdio.h>
#include<limits.h>
#include<string.h>
#define ROW 10
#define GLOS 20

void read_word(char str[],int n);
void strcompare(char strL[],char strS[],const char str[]);
int main(void)
{
	char word[ROW][GLOS+1];
	char Largest[GLOS+1],Smallest[GLOS+1];
	int counter=0;
	printf("Enter word: \n");
	read_word(word[counter++],GLOS);
	strcpy(Largest,word[0]);
	strcpy(Smallest,word[0]);
	for(;;){
		printf("Enter word: \n");
		read_word(word[counter],GLOS);
		strcompare(Largest,Smallest,word[counter]);
		if(strlen(word[counter])==4)
		break;
		counter++;
		}
	
		printf("Smallest word: %s\n",Smallest);
		printf("Largest word: %s\n",Largest);
	return 0;
} 
void read_word(char str[],int n)
{
	int ch,i=0;
	while((ch = getchar())!= '\n')
	 if(i < n){
 		str[i++] = ch;
 	}
	 str[i] = '\0';
	 return;
}
void strcompare(char strL[],char strS[],const char str[])
{
	char *s=str;
	for(;*str==*strL;str++,strL++)
	if(*str==0)
	return;
	if(*(str) > *(strL))
	strcpy(strL,str);
	for(;*s==*strS;s++,strS++)
	if(*s=='\0')
	return;
	if(*s < *strS)
	strcpy(strS,s);
	
	
	return;
}
