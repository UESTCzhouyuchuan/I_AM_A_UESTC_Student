#include<stdio.h>

int main(void)
{
	int n,number[10],j=0,i;
	scanf(" %d",&n);
	if(n <0 )
	{
		printf("fu ");
		n=-n;
	}
	do{
		number[j]=n%10;
		n/=10;
		j++;
	}while(n!=0 );
	for(i=j-1;i>0;i--)
	{
		switch(number[i])
		{
			case 0:         printf("ling ");break;
			case 1:         printf("yi ");break;
			case 2:         printf("er ");break;
			case 3:         printf("san ");break;
			case 4:         printf("si ");break;
			case 5:         printf("wu ");break;
			case 6:         printf("liu ");break;
			case 7:         printf("qi ");break;
			case 8:         printf("ba ");break;
			case 9:         printf("jiu ");break; 
		}
	}
	switch(number[0])
		{
			case 0:         printf("ling");break;
			case 1:         printf("yi");break;
			case 2:         printf("er");break;
			case 3:         printf("san");break;
			case 4:         printf("si");break;
			case 5:         printf("wu");break;
			case 6:         printf("liu");break;
			case 7:         printf("qi");break;
			case 8:         printf("ba");break;
			case 9:         printf("jiu");break; 
		}
		return 0;
	
	
}