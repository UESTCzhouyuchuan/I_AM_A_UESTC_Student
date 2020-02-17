#include<stdio.h>
#include<limits.h>
#include<string.h>

#define ROW 10
#define GLOS 20

void read_word(char str[],int n);
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
		if(strcmp(word[counter],Largest)==1)
		strcpy(Largest,word[counter]);
		if(strcmp(word[counter],Smallest)==-1)
		strcpy(Smallest,word[counter]);
		
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
