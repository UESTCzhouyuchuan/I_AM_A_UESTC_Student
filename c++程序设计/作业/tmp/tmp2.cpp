#include <iostream>
using namespace std;
class parent
{
public:
  int a = 1;
  virtual void say() const { cout << a << endl; }
};
class child : public parent
{
public:
  int b = 2;
  void say() const { cout << b << endl; };
};
class one
{
public:
  one() { cout << "one" << endl; }
  ~one() { cout << "~one" << endl; }
};
class two
{
public:
  two() { cout << "two" << endl; }
  ~two() { cout << "~two" << endl; }
};
int main()
{
  int a = 1;

  return 0;
}
int f(int a)
{
  return a;
}