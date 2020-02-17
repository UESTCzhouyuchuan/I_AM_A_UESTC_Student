#include<stdio.h>
#include<myheadfile\comfunc.h>
#define MINUTE_PER_HOUR 60
#define HOUR_PER_HALF_DAY 12	
#define SIZE ((int)(sizeof(departure)/sizeof(departure[0])))

void find_closet_flight(int desired_time,int *departure_time,int*arrive_time);

int main(void)
{
    int  minute,hour,desired_time,departure_time,departure_hour,
	 arrive_time,arrive_hour;
	printf("Enter a 24-hour time: ");
	scanf("%d:%d",&hour,&minute);
	desired_time=hour*MINUTE_PER_HOUR+minute;
	find_closet_flight(desired_time,&departure_time,&arrive_time);
	departure_hour=departure_time/MINUTE_PER_HOUR;
	printf("Cloest departure time: %d:%2d",departure_hour<=12?departure_hour:(departure_hour-12),
	departure_time-departure_hour*MINUTE_PER_HOUR);
	if(departure_time>=12)
	printf(" p.m., ");
	else printf(" a.m.,");
	
	arrive_hour=arrive_time/MINUTE_PER_HOUR;
	printf("arriving at %d:%d",arrive_hour>12?(arrive_hour-12):arrive_hour,
	arrive_time-arrive_hour*MINUTE_PER_HOUR );
	if(arrive_time>=12)
	printf(" p.m.");
	else printf(" a.m.");
	
	return 0;	
}

void find_closet_flight(int desired_time,int *departure_time,
                        int*arrive_time)
{
    int departure[]={480,583,679,767,840,945,1140,1305},
        arrive[] ={616,712,811,900,968,1075,1280,1438},
        closest;
        if(desired_time<=departure[0])
        closest=0;
        else if(desired_time>=departure[SIZE-1])
        closest=SIZE-1;
        else{ 
            closest=0;
        	while(desired_time>departure[closest+1])
			closest++;
        	if((departure[closest+1]-desired_time)<
			(desired_time-departure[closest]))
			closest++;	
        }
        *departure_time=departure[closest];
        *arrive_time=arrive[closest];
        
}

 