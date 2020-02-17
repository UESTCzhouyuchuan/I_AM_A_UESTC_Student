#include<stdio.h>
#include<string.h>
#include<stdlib.h>
#define SIZE 20
#define MAX_NUM 10

int main(void)
{
	int counter=0,j,i;
	int size=SIZE;
	struct Reminder{
		int day;
		int hour;
		char incident[SIZE];
	};
	struct Reminder reminder[10];
	do{
		if(counter>MAX_NUM){
			printf("NO--space-left");
			break;
		}
		printf("Enter day,hour(24) and reminder: ");
		scanf(" %2d",&reminder[counter].day);
		if(reminder[counter].day==0)
		break;
		else
		scanf(" %2d %s",&reminder[counter].hour,
		&reminder[counter].incident);
		
		for( i=0;i < counter;i++){
		 if(reminder[i].day>=reminder[counter].day)
		 if(reminder[i].hour>reminder[counter].hour)
	 	 break;}
	 	 reminder[i]=reminder[counter];
		
			for(j =counter;j>i;j--){
				reminder[j]=reminder[j-1];
			}
			counter++;
	}while(1);
	for(i = 0;i< counter ;i++)
	{
		printf("%2d %2d %s\n",reminder[i].day,reminder[i].hour,reminder[i].incident);
	}
	
	return 0;
	
}