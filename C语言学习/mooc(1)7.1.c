#include<stdio.h>
#include<stdlib.h>
#include<stdbool.h>


int main(void)
{
	int number[100]={0},max;
	int counter,indix,tempt;
	scanf("%d %d",&max,&tempt);
	number[max]=tempt;
	for(counter=1;counter<10;counter++){
			scanf("%d %d",&indix,&tempt);
			number[indix]=tempt+number[indix];
	}
	for(counter=max;counter>1;counter--)
	{
		if(number[counter]!=0)
		{
			if(number[counter]==1)
			{
				printf("x%d+",counter);
				continue;
			}
			printf("%dx%d+",number[counter],counter);
		}
	}
	if(number[1]!=0)
	printf("%dx+",number[1]);
	printf("%d",number[0]);
	return 0;

	return 0;
	
}