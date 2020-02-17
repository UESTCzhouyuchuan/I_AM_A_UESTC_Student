#include<bits/stdc++.h>
using namespace std;
int tmp[100];
void getLongest(int a[],int len){
  tmp[0] = 1;
  for (int i = 1; i < len;i++){
    tmp[i] = 1;
    for (int j = 0; j < i;j++){
      if (a[i] > a[j] && tmp[i] < (tmp[j]+1)){
        tmp[i] = tmp[j] + 1;
      }
    }
  }
  for (int i = 0; i < len;i++){
    cout << tmp[i];
  }
  return;
}
int main(){
  int a[] = {1,6,2,3,7,5};
  memset(tmp, 0, sizeof(tmp));
  getLongest(a, 6);
  return 0;
}