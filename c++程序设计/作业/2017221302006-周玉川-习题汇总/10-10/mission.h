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
  List<QUADPTR> list1 = List<QUADPTR>();
  QUADPTR parallelogram = new Parallelogram("Parallelogram", 10, 20);
  QUADPTR trapezoid = new Trapezoid();
  QUADPTR square = new Square(520);
  QUADPTR diamond = new Diamond(13, 14, 52);
  list1.push_back(parallelogram);
  list1.push_back(trapezoid);
  list1.push_back(square);
  list1.push_back(diamond);
  std::cout << "��ʼ��������list1" << std::endl;
  list1.iterator();
  std::cout << "����list1����Ϊ��" << list1.size() << std::endl;
  List<QUADPTR> list2 = List<QUADPTR>();
  QUADPTR parallelogram2 = new Parallelogram("Parallelogram", 5, 20);
  list2.push_back(parallelogram2);
  std::cout << "��ʼ��������list2" << std::endl;
  list2.iterator();
  std::cout << "����list2����Ϊ��" << list2.size() << std::endl;
  std::cout << "�����ϲ�list1��list2�Ľ��" << std::endl;
  List<QUADPTR> list3 = (list1 + list2);
  list3.iterator();
  std::cout << "����list2����Ϊ��" << list3.size() << std::endl;
}
Mission::~Mission()
{
  std::cout << "�������Mission End" << std::endl;
}
