//Kruskal算法 by Zhou Yuchuan   
#include <bits/stdc++.h>
using namespace std;
#define MAXV 100
typedef struct
{
	int u;
	int v;
	int weight;
}Edge;
int FindSet(int x,int Set[])
{
	if (x==Set[x])
	return x;
	else Set[x]=FindSet(Set[x],Set);
}
bool mycompare(Edge e1,Edge e2)
{
	return e1.weight<e2.weight;
}
void Kruskal(void)
{
	int i,j,k,u1,v1,sn1,sn2;
	char str[MAXV];
	int Set[MAXV];
	Edge E[MAXV*10];
	k=0;
	int n,m;
	printf("请输入顶点个数: \n");
	scanf ("%d",&n);
	m=n*(n-1)/2;
	printf("请输入%d个顶点标识(eg: abcde): \n",n);
	//while (getchar()!='\n');
	//gets(str);
	scanf ("%s",str);
	//scanf("%s",str);
	int w;
	for (i=0;i<n;i++)
		for (j=i+1;j<n;j++)
		{
			printf("边(%c,%c)权重为: ",str[i],str[j]);
			scanf("%d",&w);
			E[k].u=i;E[k].v=j;E[k].weight=w;
			k++;
		}
	sort(E,E+m,mycompare);
	for (i=0;i<n;i++)
	Set[i]=i;
	j=0;
	printf("利用Kruskal算法得出最小生成树: \n");
	for (k=0;k<n-1;j++)
	{
		u1=E[j].u;
		v1=E[j].v;
		sn1=FindSet(u1,Set);
		sn2=FindSet(v1,Set);
		if (sn1!=sn2)
		{
			printf("%c--->%c,%d\n",str[u1],str[v1],E[j].weight);
			k++;
			Set[sn1]=sn2;
		}
	}
}
int main(void)
{
	int flag=1;
	while (flag)
	{
		Kruskal();
		printf("Program ended with exit code: ");
		scanf ("%d",&flag);
	}
	return 0;
}
