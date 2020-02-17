#include<stdio.h>
#include<string.h>
#include<stdlib.h>
#define SIZE 50
#define MAX_NUM 10

int main(void)
{
	int counter=0,j,i;
	int size=SIZE;
	struct Reminder{
		int day;
		char incident[SIZE];
	};
	struct Reminder reminder[10];
	do{
		if(counter>MAX_NUM){
			printf("NO--space-left");
			break;
		}
		printf("Enter day and reminder: ");
		scanf(" %2d",&reminder[counter].day);
		printf("\n");
		if(reminder[counter].day==0)
		break;
		else
		gets(reminder[counter].incident);
		
		for( i=0;i < counter;i++){
		 if(reminder[i].day>=reminder[counter].day)
	 	 break;}
			for(j =counter;j>i;j--){
				reminder[j]=reminder[j-1];
			}
			reminder[i]=reminder[counter];
			counter++;
	}while(1);
	printf("Day Reminder\n");
	for(i = 0;i< counter ;i++)
	{
		printf("%2d%s\n",reminder[i].day,reminder[i].incident);
	}
	
	return 0;
	
}