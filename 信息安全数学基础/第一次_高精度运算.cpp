#include <bits/stdc++.h>
#define MAX_LEN 1025
using namespace std;

void print(int a[],int aLen){
	int i;
	if (aLen==0){
		printf("0\n");
	}
	else{
		for ( i = aLen-1 ; i >=0; i--)
	     printf("%d",a[i]);
	    printf("\n");
	}
	
}
int bigPlus ( int a[],int aLen, int b[],int bLen ,int c[] ){
	int max_len = ( aLen > bLen ? aLen: bLen );//���ֵ 
	int i;
	
	for ( i = 0 ; i < max_len+2 ; i++){
		c[i]=0;
	}
	int carry=0;//��λ��ʼ��Ϊ0
	
	for ( i = 0 ; i < max_len ; i++){
		c[i]=a[i]+b[i]+carry;
		carry=c[i]/10;
		c[i]=c[i]%10;
	}
	if (carry){
		c[i]=1;
		max_len++;// �����н�λ��λ����һ 
	}
	return max_len;
}

int bigMult ( int a[],int aLen, int b[],int bLen, int c[] ){
	int i,j;
	for ( i = 0 ; i < aLen+bLen ; i++){
		c[i]=0;
	}
	for ( i = 0 ; i < aLen ; i++){
		for ( j = 0 ; j < bLen ; j++){
			c[i+j]+=a[i]*b[j];
		}
	}
	for ( i = 0 ; i < aLen+bLen-1 ; i++){
		if ( c[i] >= 10){
			c[i+1]+=c[i]/10;
			c[i]%=10;
		}
	
	}
	//a��b������󳤶�Ϊ��a[0]+b[0],��СΪa[0]+b[0]-1 
	if (c[i]==0){  //c[i]����Ϊ�ڶ������ 
		i--;
	}
	return i+1;
	
}
int bigSub ( int a[],int aLen , int b[], int bLen, int c[]){//a���Լ�b  


	int i;
	if ( aLen < bLen )
	return -1;
	else if (aLen == bLen){
		for ( i = aLen-1 ; i >= 0 ; i--){
			if ( a[i] > b[i]) break;
			else if (a[i] < b[i]) return -1;
		}
		if (i==0)
		return 0;
	}

	int h=0;//��λ��ʼ��Ϊ0 
	for ( i = 0 ; i < bLen ; i++){
		c[i]=a[i]-b[i]+h;
		if (c[i] < 0){
			c[i]+=10;
			h=-1;
		}
		else{
			h=0;
		}
	}
	for ( ; i < aLen ; i++ )
	{
		c[i]=a[i]+h;
		if (c[i] < 0)
		{
			c[i]+=10;
			h=-1;
		}
		else{
			h=0;
		}
	
	}
	for ( i = aLen-1 ; i >= 0 ; i--)
	{
		if (c[i] > 0 ){
			break;
		}
	}
	return i+1;
}


int bigDivide( int a[],int aLen, int b[],int bLen, int r[] ){
	int i, j,tmp;
	int Len = aLen-bLen;

	//��ʼ�����r[] 
	
	if ( Len < 0 ) return 0;
	if ( Len > 0){
		for ( i = aLen-1 ; i > Len-1 ; i--){
			b[i] = b[i-Len];
		}
		for ( i = 0; i < Len ; i++)
			b[i]=0;	
		bLen = aLen;
	}
	for ( i = 0 ; i <  Len+2 ; i++){
		r[i] = 0;
	}
	j=0;
	while (j <= Len){
		//�������ܼ�Ϊֹ 
		while ((tmp = bigSub(a,aLen,b+j,bLen-j,a) )>= 0){
			aLen = tmp;
			r[Len-j]++;
	}
	j++;
   }	
	for ( i = Len ; i >= 0 ; i--)
	     if (r[i] > 0) 
	     break;
	return i+1;
	
}


int main(void){
	int a[MAX_LEN],b[MAX_LEN],c[2*MAX_LEN];
	char str[MAX_LEN];
	int i;
	int aLen,bLen,cLen;
	memset(a,0,sizeof(a));
	memset(b,0,sizeof(b));
	memset(c,0,sizeof(c));
	printf("��������������: \n");
	gets(str);
	aLen=strlen(str);
	for ( i = 0 ; i < aLen ; i++){
		a[i]=str[aLen-i-1]-'0';
	}
	
	gets(str);
	bLen=strlen(str);
	for ( i = 0 ; i < bLen ; i++){
		b[i]=str[bLen-i-1]-'0';
	}

	printf("\na: ");print(a,aLen);
	printf("b: ");print(b,bLen);
	
	//�� 
	
	printf("\na+b:\n");
	cLen=bigPlus(a,aLen,b,bLen,c);
	print(c,cLen);
	//�� 
	
	printf("\na-b:\n");
	cLen=bigSub(a,aLen,b,bLen,c);
	print(c,cLen);
	//�� 
	
	printf("\na*b: \n");
	cLen=bigMult(a,aLen,b,bLen,c);
	print(c,cLen);
	//�� 
	
	printf("\na/b : \n");
	cLen=bigDivide(a,aLen,b,bLen,c);
	print(c,cLen);
	return 0;
	
}
