#include<stdio.h>
#include<stdbool.h>
#define MAX 50 

bool is_prime(int);
int sum_yinzi(int);

int main(void)
{
	int number1,number2;
	int i,j=0,n[MAX];
	scanf("%d %d",&number1,&number2);
	for(i=number1;i<=number2;i++)
	{
		if(!is_prime(i)){
			if(i==sum_yinzi(i))
		{
			n[j]=i;
			j++;
		}
		}
		
			
	}
	if(j==0)
	printf("NIL\n");
	else
	{
		for(i = 0;i<j-1;i++)
		printf("%d ",n[i]);
		printf("%d",n[j-1]);
	}
	return 0;
	
}

bool is_prime(int n)
{
	int r,i;
	for(i=2;i*i<=n;i++)
	{
		r=n%i;
		if(r==0)
		return false;
	}
	return true;
}
int sum_yinzi(int n)
{
	int sum;
	sum=0;
	int i;
	for( i =1 ;i < n; i++)
	{
		if(!(n%i))
		{
			sum=sum+i;
		}
	}
	return sum;
}