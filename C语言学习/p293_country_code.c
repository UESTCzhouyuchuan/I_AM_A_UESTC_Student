#include<stdio.h>
#include<stdlib.h>
#define N 32

//void research_code(struct dialing_code [],int);
int main(void){
	int num;
	
	struct dialing_code{
		char*country;
		int code;
	};
	struct dialing_code country_code[32]={
	{"Argentina",54},{"Bangladesh",880},
	{"Brazil",55},{"Burma(Myanmar)",95},
	{"China",86},{"Colombia",57},
	{"Congo, Dem.Rep. of",243},{"Egypt",20},
	{"Ethiopia",251},{"France",33},
	{"Germany",49},{"India",91},
	{"Indonesia",62},{"Iran",98},
	{"Italy",39},{"Janpan",81},	
	{"Mexico",52},{"Nigeria",234},
	{"Pakistan",92},{"Philippines",63},
	{"Poland",48},{"Russia",7},
	{"South Africa",27},{"Korea",82},
	{"Spain",34},{"Sudan",249},
	{"Thailand",66},{"Turkey",90},
	{"Ukraine",380},{"United Kingdom",44},
	{"United States",1},{"Vietnam",84},	
	};
	printf("Enter dialing code:\n");
	scanf(" %d",&num);
	int i;
	for(i = 0;i < N;i++){
		if(country_code[i].code==num){
			printf("The country with dialing code %d is %s",num,country_code[i].country);
			return 0;
		}
	}
	printf("No corresponding country found");
	//printf("The country with dialing code %d is %s",num,country_code[indix].country);
	return 0;
}

/*void research_code(struct dialing_code country_code[],int num)
{
	int i;
	for(i = 0;i < N;i++){
		if(country_code[i].code==num){
			printf("The country with dialing code %d is %s",num,country_code[i].country);
			return;
		}
	}
	printf("No corresponding country found");
	return;
	
}*/