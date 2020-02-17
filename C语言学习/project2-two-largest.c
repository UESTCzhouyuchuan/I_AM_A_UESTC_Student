#include<stdio.h>
#include<stdlib.h>
#include<limits.h>

void find_two_largest(int[],int*,int*,int*,int*);
int main(void)
{
	int a[10],*p,largest,secondlargest,indx,sindx;
	int top=10;
	printf("Please input 10 integers: \n");
	for(p =a;p <a+top;p++)
	scanf(" %d",p);
	find_two_largest(a ,&largest,&secondlargest,&indx,&sindx);
	printf("The largest:%d\nThe index of the largest:%d\n",largest,indx);
	printf("The second largest:%d\nThe index of the second largest:%d\n",secondlargest,sindx);
	return 0;
}
void find_two_largest(int n[],int*max,int*smax,int*indx,int*sindx)
{
	int i;
	*max=*smax=INT_MIN;
	for(i=0;i<10;i++)
	{
		if(*max<n[i])
		{
			*max=n[i];
			*indx=i;
		}
		
	}
	for(i=0;i<10;i++)
	{
		
		if(i==*indx)continue;
			if(*smax < n[i])
			{
				*smax=n[i];
				*sindx=i;
			}
			
		
	}
	 return;
}

