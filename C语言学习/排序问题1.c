#include<stdio.h>
#define N ((sizeof(num)/sizeof(num[0])))
int main(void)
{
	int num[]={12,14,6,8,9,23,61,29,27,3,66,};
	int i,j,min,middle,max;
	for(i =0;i<N/2;i++)
	{	min=i;
	    max=N-i-1;
	    for(j=0;j<N-i;j++){
	    	if(num[j]>num[max])
	    	max=j;
	    }
	    if(max!=(N-i-1)){
	    	middle=num[N-i-1];
	    	num[N-i-1]=num[max];
	    	num[max]=middle;
	    }
		for(j=i+1;j<N-i;j++)
		{
			if(num[j]<num[min])
			min=j;
			}
			if(min!=i){
				middle=num[i];
				num[i]=num[min];
				num[min]=middle;   
		}
	}
	for(i=0;i<N;i++)
	printf("num[%d]=%d\n",i,num[i]);
	return 0;
}
