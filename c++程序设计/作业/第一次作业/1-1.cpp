#include<iostream>

// cin����һ������,��-1����
int main(){
  int sum = 0;
  int cur = 0;
  do{
    std::cin >> cur;
    sum += cur;
  } while (cur != -1);
  std::cout << "���Ϊ" << sum + 1;
  return 0;
}