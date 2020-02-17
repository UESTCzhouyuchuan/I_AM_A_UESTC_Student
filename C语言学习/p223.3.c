#include<stdio.h>
#include<stdbool.h>
#include<stdlib.h>
#include<time.h>

#define NUM_SUTTS 4
#define NUM_RANK 13
void clear_input(void);
int main(void)
{ 
    bool in_hand[NUM_SUTTS][NUM_RANK]={false};
    const char *code[4][13]={{"Two of spades","Three of spades","Four of spades","Five of spades",
	"Six of spades","Seven of spades","Eight of spades","Nine of spades","T of spades",
	 "J of spades","Q of spades","K of spades","A of spades"},
    {"Two of diamonds","Three of diamonds","Four of diamonds","Five of diamonds",
	 "Six of diamonds","Seven of diamonds","Eight of diamonds","Nine of diamonds","T of diamonds",
	 "J of diamonds","Q of diamonds","K of diamonds","A of diamonds"},
    {"Two of hearts","Three of hearts","Four of hearts","Five of hearts",
	 "Six of hearts","Seven of hearts","Eight of hearts","Nine of hearts","T of hearts",
	 "J of hearts","Q of hearts","K of hearts","A of hearts"},
	 {"Two of clubs","Three of clubs","Four of clubs","Five of clubs",
	 "Six of clubs","Seven of clubs","Eight of clubs","Nine of clubs","T of clubs",
	 "J of clubs","Q of clubs","K of clubs","A of clubs"}};
    srand(time(NULL));
    int num,sutts,rank,i,n=1;
    char play_game;//需要改为char play_game='Y'; 要不然第一次输错程序就结束了 
	do{	
	 printf("Enter number of card in hand: ");
    if(!scanf(" %d",&num))
	{
		printf("Error!!!Please enter again(number)!!!\n");
		clear_input(); 
	    continue;	
	}
    for(i=0;i<num;){
    	sutts=rand()%4;
        rank=rand()%13;
        if(!in_hand[sutts][rank]){
        	  printf("%s\n",code[sutts][rank]);
        	  in_hand[sutts][rank]=true;
        	  i++;
        }
        
    }
    printf("Play again(Y/N): ");
    n=scanf(" %c",&play_game);//问题是没法执行这条语句 
    }while(play_game=='Y');
    printf("%c %d",play_game,n);// 测试play—game储存的字符和scanf执行的次数 
    
	return 0;
}

void clear_input(void)
{
	char ch;
	while((ch=getchar())!='\n');
	return ;
}