#include<stdio.h>
#include<stdlib.h> 
#include<stdbool.h>
#include<string.h>
#define NUM_MAX 1000
void mystrcmp(const char*str1,const char*str2);
int main(void)
{
	int size=NUM_MAX;
	int counter=0;
	/*char*becompare=(char*)malloc(size*sizeof(char));
	for(;(*becompare=getchar())!='\n';becompare++)
	counter++;*/
	char becompare[NUM_MAX],compare[NUM_MAX];
	gets(becompare);
	gets(compare);
	mystrcmp(becompare,compare);
	return 0;
}

void mystrcmp(const char*str1,const char*str2)
{
	int i,j;
	int put_times=0;
	
	int counter1=strlen(str1);
	int counter2=strlen(str2);
	
	for(i =0 ;i < counter2;i++)
	{
	    bool is_part=true;
		for(j =0; j < counter1 ; j++)
		{
			if(str2[i+j]!=str1[j])
			{
			
				is_part=false;
				break;
			}
		}
		if(is_part){
			printf("%d ",i);
			put_times++;
		}
	} 
	if(!put_times)
	printf("-1");
}