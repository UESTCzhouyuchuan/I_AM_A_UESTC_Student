#pragma once
#include <iostream>
class Quadrangle
{
public:
  std::string tag;
  std::string what()
  {
    return tag;
  };
};

typedef Quadrangle *QUADPTR;

class Parallelogram
{
private:
  Quadrangle quad;
  int width, height;

public:
  // 构造函数
  Parallelogram(std::string tag, int w, int h)
  {
    quad.tag = tag;
    width = w;
    height = h;
  };
  // 复制构造函数
  Parallelogram(const Parallelogram &q) : quad(q.quad), width(q.width), height(q.height){};
  ~Parallelogram();
  double area();
  void draw(bool showResult = true);
};

class Rectangle
{
private:
  int width, height;
  Quadrangle quad;

public:
  double area();
  void draw(bool showResult = true);
  Rectangle()
  {
    quad.tag = "Rectangle";
  }
};
class Square
{
private:
  Quadrangle quad;
  int width, height;

public:
  double area();
  void draw(bool showResult = true);
  Square()
  {
    quad.tag = "Square";
  }
};
class Trapezoid
{
private:
  Quadrangle quad;
  int width, height;

public:
  double area();
  void draw(bool showResult = true);
  Trapezoid()
  {
    quad.tag = "Trapezoid";
  }
};
class Diamond
{
private:
  Quadrangle quad;
  int width, height;

public:
  double area();
  void draw(bool showResult = true);
  Diamond()
  {
    quad.tag = "Diamond";
  }
};
