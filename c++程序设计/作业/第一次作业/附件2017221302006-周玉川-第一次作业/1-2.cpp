#include<iostream>
void plus(int a,int b){
  std::cout<< "结果是:" << a + b;
  return;
}
void subtract(int a,int b){
  std::cout << "结果是:" << a - b;
  return;
}
void multiply(int a,int b){
  std::cout << "结果是:"<< a * b;
  return;
}
void divide(int a,int b){
  std::cout << "结果是:" << a * 1.0 / b;
  return;
}
typedef void (*operate)(int,int);
operate fun(int operateSymbol)
{
  operate res = nullptr;
  switch (operateSymbol)
  {
  case 1:
    res = plus;
    break;
  case 2:
    res = subtract;
    break;
  case 3:
    res = multiply;
    break;
  case 4:
    res = divide;
    break;
  default:
    break;
  }
  return res;
}
int main(){
  int a, b;
  int operateSymbol;
  std::cin >> a >>b>> operateSymbol;
  //void (*operates[4])(int a, int b) = {plus, subtract, multiply, divide};
  // if (1 <= operateSymbol && operateSymbol<=4){
  //   operates[operateSymbol-1](a, b);
  // } else{
  //   std::cout << "非法的运算输入";
  // }
  operate f = fun(operateSymbol);
  f(a,b);
  return 0;
}