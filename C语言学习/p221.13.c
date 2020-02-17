#include<stdio.h>
#include<string.h>
#define MARGIN 20

void build_index_url(const char domain[],char index_url[]);
int main(void)
{
	char domain[MARGIN];
	char indix_url[MARGIN+10]="http://www.";
	puts("Enter a domain name: ");
	gets(domain);
	build_index_url(domain,indix_url);
	printf("The URL is: %s",indix_url);
	
	return 0;
}
void build_index_url(const char *domain,char*indix_url)
{
	
	strcat(strcat(indix_url,domain),"/index.html");
	return;
}