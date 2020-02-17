#include "1-3-list.h"

int main() {
	QUADPTR quad[5];
  for (int i = 0; i < 5;i++)
	{
		quad[i] = new Quadrangle();
	}
  quad[0]->tag = "Parallelogram";
  quad[1]->tag = "Rectangle";
  quad[2]->tag = "Square";
  quad[3]->tag = "Trapezoid";
  quad[4]->tag = "Diamond";
  List *list = new List();
  list->itrator();
  for (int i = 0; i < 5;i++)
  {
    list->push_back(quad[i]);
  }
  list->itrator();
  return 0;
}