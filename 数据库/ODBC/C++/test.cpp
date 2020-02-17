#include <bits/stdc++.h>
using namespace std;

int l[20001];
int f[20001];
void find(int i){
  int r = i;
  while(r!=f[r]){
    f[r] = f[f[r]];
    l[r] += l[f[r]];
    r = f[r];
  }
}
int mian()
{
  int n;
  int a, b, c;
  cin >> n;
  for (int i = 1; i <= n; i++)
    f[i] = i;
  while (1)
  {
    cin >> a;
    if (a == 0)
      break;
    cin >> b >> c;
    if (f[a]!=a){
      int tmp = a;
      a = b;
      b = a;
    }
    f[a] = b;
    l[a] = c;
  }
  for (int i = 1; i <= n;i++){
    find(i);
    cout << l[i];
  }
  return 0;
}
