#include<stdio.h>

int max_(int[],int);
int main(void)
{
	int n[10]={0};
	int i=0,tempt,max;
	printf("Please input some non-negative integers (0 to terminate):\n"); 
	do{
		scanf(" %1d",&tempt);
		if(tempt==0)
		break;
		n[tempt]++;
	}while(1);
	max=max_(n,10);
	printf("%d:",max);
	for(i=1;i<10;i++)
	if(n[i]==max)
	printf("       %d",i);
	
	return 0;
	
}

int max_(int a[],int n)
{
	int i;
	int max=a[1];
	for(i=1;i<n;i++)
	max=max>a[i] ? max:a[i];
	return max;
}