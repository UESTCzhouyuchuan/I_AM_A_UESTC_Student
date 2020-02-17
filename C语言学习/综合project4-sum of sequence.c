#include<stdio.h>

double sum_of_sequence(double,double,int);
int main(void)
{
	double sum=0;
	int times;
	printf("please input the number of items: \n");
	scanf(" %d",&times);
	sum=sum_of_sequence(1,2,times);
	printf("The sum is: %.5f",sum);
	return 0;
	
	
}

double sum_of_sequence(double mu,double fenzi,int n)
{
	
	if(n==0)
	return 0;
	else
	return fenzi/mu+sum_of_sequence(fenzi,mu+fenzi,n-1);
}