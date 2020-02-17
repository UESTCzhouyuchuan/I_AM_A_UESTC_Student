//
//  main.cpp
//  homework3
//
//  Created by lan on 2019/10/13.
//  Copyright © 2019 lan. All rights reserved.
//

#include <iostream>

#include "tmp2.h"
int main(int argc, const char *argv[])
{
  List*list = new List();
  int ran;
  list->init();
  for (int i = 0; i < 6; i++)
  {
    ran = rand() % 4;
    if (ran == 0)
    {
      Quadrangle *q = new Quadrangle();
      q->tag = "Rectangle";
      list->push_back(q);
    }

    else if (ran == 1)
    {
      Quadrangle *q = new Quadrangle();
      q->tag = "Square";
      list->push_back(q);
    }

    else if (ran == 2)
    {
      Quadrangle *q = new Quadrangle();
      q->tag = "Trapezoid";
      list->push_back(q);
    }

    else
    {

      Quadrangle *q = new Quadrangle();
      q->tag = "Diamond";
      list->push_back(q);
    }
  }

  list->traverse();
}
