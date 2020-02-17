#include<stdio.h>

int main(void)
{
	int UTC,BJT;
	int hour,min;
	scanf("%d",&BJT);
	hour=(BJT/100+24-8)%24;
	min=BJT%100;
	if(hour==0)
	{
		printf("%d",min);
	}
	else
	printf("%d%.2d",hour,min);
	return 0;
}