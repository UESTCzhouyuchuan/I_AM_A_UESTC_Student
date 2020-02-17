#include<stdio.h>

int main(void)
{
	int i=0,ji=0;
	int num=0;
	for(;num!=-1;)
	{
		scanf(" %d",&num);
		if(num%2)
		ji++;
		else
		i++; 
	} 
	printf("%d %d",ji-1,i);
	return 0;
}