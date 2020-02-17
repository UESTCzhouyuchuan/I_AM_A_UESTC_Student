#include<stdio.h>
#include<stdbool.h>
 
bool is_prime(int);
int main(void)
{
	int number;
	int i;
	scanf(" %d",&number);
	printf("%d=",number);
	if(!is_prime(number)){
	for( i =2 ;i < number; i++)
	{
		if(!(number%i))
		{
			printf("%dx",i);
			number=number/i;
			i--;
		}
	}
	}
	
	printf("%d",number);
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