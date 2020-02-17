//6-8.cpp
#include "list.h"

using namespace std;
class mission
{
private:
  List ls;

public:
  void missionStart()
  {
    cout << "Mission start." << endl;
    // ls.init();不需要初始化
    QUADPTR quad[5];
    for (int i = 0; i < 5; i++)
    {
      quad[i] = new Quadrangle();
    }
    quad[0]->tag = "Parallelogram";
    quad[1]->tag = "Rectangle";
    quad[2]->tag = "Square";
    quad[3]->tag = "Trapezoid";
    quad[4]->tag = "Diamond";
    for (int i = 0; i < 4; i++)
    {
      ls.push_back(quad[i]);
    }
    cout << "原List：" << endl;
    ls.iterator();
    ls += quad[4];
    cout << "ls += quad[4]之后的List：" << endl;
    ls.iterator();
  };
  void missionComplete()
  {
    cout << "Mission complete." << endl;
    // ls.empty();也不需要人为回收内存
    cout << "Tip:clear function ok." << endl;
  };
};
int main()
{
  mission ms;
  ms.missionStart();
  ms.missionComplete();
  return 0;
}