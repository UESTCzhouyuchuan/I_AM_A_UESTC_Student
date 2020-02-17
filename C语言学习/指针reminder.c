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
	struct Reminder *reminder[MAX_NUM],*meno_p;
	do{
		meno_p=(struct Reminder*)malloc(sizeof(struct Reminder));
		if(counter>MAX_NUM){
			printf("NO--space-left");
			break;
		}
		printf("Enter day and reminder: ");
		scanf(" %2d",&meno_p->day);
		printf("\n");
		if(meno_p->day==0)
		break;
		else
		gets(meno_p->incident);
	
		for( i=0;i < counter;i++){
		 if(reminder[i]->day>=meno_p->day)
	 	 break;}
		
			for(j =counter;j>i;j--){
				reminder[j]=reminder[j-1];
			}
			 reminder[i]=meno_p;
			counter++;
	}while(1);
	printf("Day Reminder\n");
	for(i = 0;i< counter ;i++)
	{
		printf("%2d%s\n",reminder[i]->day,reminder[i]->incident);
	}
	
	return 0;
	
}
