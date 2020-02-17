#include<stdio.h>

int main(void)
{
	int fenmu,fenzhi;
	scanf("%d/%d",&fenzhi,&fenmu);
	printf("0.");
	int i=0;
	do{
		if(!fenzhi%fenmu)
		break;
		else
		printf("%d",fenzhi*10/fenmu);
		fenzhi=fenzhi*10%fenmu;
		i++;
	}while(i<200);
	printf("\n");
	return 0;
	
} 