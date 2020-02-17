#include<stdio.h>
#include<math.h>


int f(int x,int head);
int main(void)
{
	int num;
	int head;
	scanf(" %d^%d",&num,&head);
	printf("%d^%d=%d",num,head,f(num,head));
	return 0;
}

int f(int x,int head)
{
	return head==0 ? 1:(head % 2 ? (x*pow(f(x,(head-1)/2),2)):(pow(f(x,head/2),2)));
}
