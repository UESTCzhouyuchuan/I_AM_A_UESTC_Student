#include<stdio.h>

int main(void)
{
	int number,daoxu=0;
	printf("Please input an integer: \n");
	scanf(" %d",&number);
	while(number!=0)
	{
		daoxu=daoxu*10+number%10;
		number/=10;
	}
	printf("After reversing: %d",daoxu);
	return 0;
	
} 