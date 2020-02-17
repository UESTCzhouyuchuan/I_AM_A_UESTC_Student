//finished by zhouyuchuan --2017221302006 
#include <bits/stdc++.h>
using namespace std;
#define N 26
typedef struct{
	char data;
	double weight;
	int parent;
	int lchild;
	int rchild;
}HTNode;
typedef struct
{
	char cd[N*2];
	int start;
}HCode;
HTNode words[N*4];
HCode output[N*2];
char str[100];	
int n=0;
void ReadInput(void);
void BuildHuffman(void);
void SecretOutput(void);
void TransSecret(void); 
void Disp(HCode hc);
void FwriteFile(void);
int main(void)
{
	ReadInput();
	BuildHuffman();
	SecretOutput();
	TransSecret();
	return 0;
}
void FwriteFile(void)
{
	FILE*fp=fopen("out.txt","w");
	if (fp==NULL)
	{
		perror("Error\n");
	}
	int i=0,j;
	for (;str[i]!='\0';i++)
	{
		
	}
}
void ReadInput(void)
{
	memset(words,0,sizeof(words));
	memset(output,0,sizeof(output));
	int i;
	for (i=0;i<N;i++){
		words[i].data=i+'a';
		words[i+N].data=i+'A';
	}
	FILE*fp;
	if ((fp=fopen("in.txt","r+"))==NULL)
	{
		perror("Error\n");
	}
	i=0;
	char ch;
	while (fscanf(fp,"%c",&ch)!=EOF)
	{
		str[i]=ch;
		i++;
	}
	fclose(fp);
	str[i]='\0';
	i=0;
	while (str[i]!='\0')
	{
		if (str[i]<='z'&&str[i]>='a')
			words[str[i]-'a'].weight++;
		else if (str[i]>='A'&&str[i]<='Z')
			words[str[i]-'A'+N].weight++;
		i++;
	}
}
void BuildHuffman(void){
	int i,k,lnode,rnode;
	double min1,min2;
	for (i=0;i<2*N;i++)
	if (words[i].weight!=0)n++;
	for (i=0;i<4*N-1;i++)
	words[i].lchild=words[i].parent=words[i].rchild=-1;
	for (i=N*2;i<N*2+n-1;i++)
	{
		min1=min2=99999;
		lnode=rnode=-1;
		for (k=0;k<=i-1;k++)
		{
			if (words[k].weight==0)continue;
			if (words[k].parent==-1)
			{
				if(words[k].weight<min1)
				{
					min2=min1;rnode=lnode;
					min1=words[k].weight;lnode=k;
				}
				else if(words[k].weight<min2)
				{
					min2=words[k].weight;rnode=k;
				}
			}
		}
		words[i].weight=min1+min2;
		words[i].lchild=lnode;words[i].rchild=rnode;
		words[lnode].parent=i;words[rnode].parent=i;
	}
}
void SecretOutput(void)
{
	int i,f,c;
	HCode hc;
	for (i=0;i<N*2;i++)
	{
		if (words[i].weight==0)continue;
		hc.start=n;c=i;
		f=words[i].parent;
		while (f!=-1)
		{
			if (words[f].lchild==c)
				hc.cd[hc.start--]='0';
			else
				hc.cd[hc.start--]='1';
			c=f;f=words[f].parent;
		}
		hc.start++;
		output[i]=hc;
	}
	printf("Output: \n");
	for (i=0;i<N*2;i++)
	{
		if (words[i].weight!=0)
		{
			printf("%c: ",words[i].data);
			Disp(output[i]);
		}
	}
}
void Disp(HCode hc)
{
	int i;
	for(i=hc.start;i<=n;i++)
	printf("%c",hc.cd[i]);

	printf("\n");
}
void TransSecret(void)
{
	int FDot=N*2+n-2,result;
	char ch[1000];
	printf("Please input the secret code:\n");
	scanf("%s",ch);
	int i=0;
	printf("After deciphering: \n");
	for (i=0;i<strlen(ch);i++)
	{
		if (ch[i]=='1')
		result=words[FDot].rchild;
		else
		result=words[FDot].lchild;
		if (words[result].lchild==-1&&words[result].rchild==-1)
		{
			printf("%c",words[result].data);
			FDot=N*2+n-2;
		}
		else
		FDot=result;
	}
	printf("\n");
		
}
