#include<stdio.h>

void reduce(int numerator,int denominator,
            int*reduced_numerator,
			int*reduced_denominator);
			
int main(void)
{
     int numerator,denominator;
     int reduced_numerator,reduced_denominator;
     printf("Entera fraction: ");
     scanf("%d/%d",&numerator,&denominator);
     reduce(numerator,denominator,&reduced_numerator,&reduced_denominator);
     printf("\nIn lowest terms: %d/%d",reduced_numerator,reduced_denominator);
     return 0;
     
}

int find_gac(int m,int n){
	int reminder;
    for(;n!=0;)
    {
    	reminder=n;
    	n=m%n;
    	m=reminder;
    }
    return m;
	
} 
 
void reduce(int n,int m,
            int *reduced_numerator,
			int *reduced_denominator)
			{
			int gac=find_gac(m,n);
			*reduced_numerator=n/gac;
			*reduced_denominator=m/gac;
			if(*reduced_denominator<0)
			{
				*reduced_denominator*=-1;
				*reduced_numerator*=-1;
			}
			return;	
			}