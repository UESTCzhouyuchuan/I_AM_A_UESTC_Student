#include<stdio.h>
#include<stdbool.h>

bool max_min(int n,int [][n],int,int,int);

int main(void)
{
   int i,j;
   int totalrow;
   scanf("%d",&totalrow);
   int a[totalrow][totalrow];
   for(i=0;i<totalrow;i++)
   {
   	for(j=0;j<totalrow;j++)
   	scanf(" %d",&a[i][j]);
   }
   for(i=0;i<totalrow;i++)
   for(j=0;j<totalrow;j++)
   if(max_min(totalrow,a,a[i][j],i,j)){
   	printf("%d %d",i,j);
   	return 0;
   }
   printf("NO");
   return 0;
   	
}

bool max_min(int n,int a[][n],int number,int row,int column)
{
	int i;
	for(i=0;i<n;i++){
		if(a[row][i]>number)
	     return false;
	     if(a[i][column]<number)
	     return false;
	}
	
	return true;
	
}
