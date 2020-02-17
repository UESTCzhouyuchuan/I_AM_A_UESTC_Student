#include<stdio.h>
#include<stdlib.h>

int commonnumber(int,int);
int main(void)
{
	int numerator,denominator;
	scanf("%d/%d",&numerator,&denominator);
	int commonnum=commonnumber(numerator,denominator);
	printf("%d/%d",numerator/commonnum,denominator/commonnum);

	return 0;
}

int commonnumber(int n,int m)
{
	int temp;//reserve the value of n
	for(;;){
	temp=n; 
	n=m%n;
	if(n==0)
	return temp;
	m=temp;
	}

}

 

 