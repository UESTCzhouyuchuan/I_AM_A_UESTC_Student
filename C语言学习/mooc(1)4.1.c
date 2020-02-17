#include<stdio.h>
#define MAX 200
#include<stdbool.h>

//bool prime_(int n);
int main(void)
{
	int prime[MAX],n[5000];
	int i,j,sum=0,x1,x2;//(x1,x2)the region
	scanf("%d %d",&x1,&x2);
	for(i=0;i<5000;i++)
	n[i]=0;
	for(i=2;i < 5000;i++)
	{
		for(j=2;j*i<5000;j++)
		n[i*j]=1;
	}
	for(i=2,j=1;i<5000&&j<=x2;i++)
	{
		if(!n[i])
		{
			prime[j]=i;
			j++;
		}
	}
	for(i= x1;i<=x2;i++)
	{
		sum=prime[i]+sum;
	}
	printf("%d",sum);
	 
}

