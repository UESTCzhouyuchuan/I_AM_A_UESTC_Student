#include<stdio.h>

int multily(int n,int m);
int main(void)
{
	int num1,num2;
	printf("Enter two numbers you want to multily: ");
	scanf("%d %d",&num1,&num2);
	printf("%d*%d=%d",num1,num2,multily(num1,num2));
	return 0;
}

int multily(int n,int m){
	/*int sum=0,i=1;
	do{
		if(n%2)
		sum+=m;
		n=n/2;
		m*=2;
		i++;
	}while(n);
	return sum;*/
	return (n!=0 ? (n%2 ?(m+multily(n/2,m*2)):(multily(n/2,m*2))): 0);//递归求和 
}
