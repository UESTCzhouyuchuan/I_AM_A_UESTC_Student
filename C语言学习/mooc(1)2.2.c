#include<stdio.h>

int main(void)
{
int n;
scanf(" %d",&n);
switch(n%10)
{
	case 1:        printf("Faint signals, barely perceptible, ");break;
	case 2:        printf("Very weak signals, ");break;
	case 3:        printf("Weak signals, ");break;
	case 4:        printf("Fair signals, ");break;
	case 5:        printf("Fairly good signals, ");break;
	case 6:        printf("Good signals, ");break;
	case 7:        printf("Moderately strong signals, ");break;
	case 8:        printf("Strong signals, ");break;
	case 9:        printf("Extremely strong signals, ");break;
}
switch(n/10)
{
case 1:             printf("unreadable.");break;
case 2:             printf("barely readable, occasional words distinguishable.");break;
case 3:             printf("readable with considerable difficulty.");break;
case 4:             printf("readable with practically no difficulty.");break;
case 5:             printf("perfectly readable.");break;
}

return 0;
}

/*Unreadable
Barely readable, occasional words distinguishable
Readable with considerable difficulty
Readable with practically no difficulty
Perfectly readable
报告第二位是S，共分九个级别，用1—9中的一位数字表示
Faint signals, barely perceptible
Very weak signals
Weak signals
Fair signals
Fairly good signals
Good signals
Moderately strong signals
Strong signals
Extremely strong signals*/