#include<cstdio>
#include<iostream>
using namespace std;
class keyboard
{
  public:
    std::string input(){
      char ret[50];
      int a, b;
      char op;
      cout << "Input the expression:";
      cin >> a >> op >> b;
      sprintf(ret, "%d%c%d", a, op, b);
      return ret;
    };
};
class monitor{
  public:
    void display(std::string content) { cout << "Result:" << content << endl; };
};
class calculator
{
  private:
    keyboard kbd;
    monitor mntr;

    string calculate(string expression){
      int a=0, b=0,res;
      char op;
      int i = 0;
      char ret[50];
      int num = expression[i];
      while( num <='9' && num >= '0'){
        a *= 10;
        a += num - '0';
        i++;
        num = expression[i];
      };
      op = num;
      num = expression[++i];
      while( num <='9' && num >= '0'){
        b *= 10;
        b += num - '0';
        i++;
        num = expression[i];
      };
      //cout << a << op << b;
      switch (op)
      {
      case '+':
        res = a + b;
        break;
      case '-':
        res = a - b;
        break;
      case '*':
        res = a * b;
        break;
      case '/':
        if (b == 0){
          cout << "!!!Warning:divide zero error!!!"<<endl;
          break;
        }
        res = a / b;
        break;
      default:
        break;
      }
      sprintf(ret, "%d %c %d = %d", a, op, b, res);
      return ret;
    };
  public:
    void work(){
      string exp = kbd.input();
      string content = calculate(exp);
      mntr.display(content);
    };
};
int main(){
  calculator t;
  t.work();
  return 0;
}