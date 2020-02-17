#include<iostream>

// cin读入一组数组,以-1结束
int main(){
  int sum = 0;
  int cur = 0;
  do{
    std::cin >> cur;
    sum += cur;
  } while (cur != -1);
  std::cout << "结果为" << sum + 1;
  return 0;
}