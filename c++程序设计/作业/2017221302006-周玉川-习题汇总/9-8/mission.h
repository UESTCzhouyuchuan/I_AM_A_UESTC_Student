#include "container.h"
class Mission
{
private:
  /* data */
public:
  Mission(/* args */);
  ~Mission();
};

Mission::Mission(/* args */)
{
  std::cout << "Mission Start" << std::endl;
  List list = List();
  QUADPTR parallelogram = new Parallelogram("Parallelogram", 10, 20);
  QUADPTR trapezoid = new Trapezoid();
  QUADPTR square = new Square(520);
  QUADPTR diamond = new Diamond(13, 14, 52);
  list.push_back(parallelogram);
  list.push_back(trapezoid);
  list.push_back(square);
  list.push_back(diamond);
  std::cout << "��ʼ��������" << std::endl;
  list.iterator();
  std::cout << "������Ϊ��" << list.size() << std::endl;
}
Mission::~Mission()
{
  std::cout << "�������Mission End" << std::endl;
}
