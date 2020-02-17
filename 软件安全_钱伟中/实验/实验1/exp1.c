#include<stdio.h>
int fun(int a,int b){
  int c;
  if (a<b){
    c = b - a;
  } else{
    c = a - b;
  }
  printf("their sum is ");// 41576Ch
  printf("can you have ");//41575Ch
  printf("the ability of ");//415748h
  printf("reverse analysis");//415858h
  return c;
}
int main(){
  printf("this is a simple"); //415AB0
  printf("program you are analyzing now");// 4157ACh 
  int a = 0x39; //[ebp-8h]
  int b = 0x3C; //[ebp-14h]
  if (a<=b){
    //push b,push a
    fun(a, b);
  } else{
    printf("hello");//4162E4h
  }
  b = 0x32;
  if (a>b){
    //push b push a
    fun(a, b);
  }
  printf("this is true end! but you should not relax yourself!!! Be careful");//4162A0h
  printf("trap");//415BC8h
  return 0;
}
