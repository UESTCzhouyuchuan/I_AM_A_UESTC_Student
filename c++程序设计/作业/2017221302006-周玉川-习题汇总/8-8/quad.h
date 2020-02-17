#pragma once
#include <string>
/*四边形*/
class Quadrangle
{
protected:
  std::string tag;

public:
  Quadrangle(std::string t) : tag(t){};
  std::string what() const { return tag; };
  double area() const;
  void draw(bool showResult = true) const;
};

typedef Quadrangle *QUADPTR;
/**平行四边形*/
class Parallelogram : public Quadrangle
{
protected:
  int width, height;

public:
  // 构造函数
  Parallelogram(std::string tag, int w, int h) : Quadrangle(tag), width(w), height(h){};
  // 复制构造函数
  Parallelogram(const Parallelogram &q) : width(q.width), height(q.height), Quadrangle(q.tag){};
  ~Parallelogram();
  double area();
  void draw(bool showResult = true);
};
/*矩形*/
class Rectangle : public Parallelogram
{
public:
  Rectangle(std::string tag, int w, int h) : Parallelogram(tag, w, h){};
  Rectangle(const Rectangle &q) : Parallelogram(q){};
};
/*正方形*/
class Square : public Rectangle
{
public:
  Square(int l) : Rectangle("Square", l, l){};
  Square(const Square &q) : Rectangle(q){};
};
/*不规则四边形*/
class Trapezoid : public Quadrangle
{
public:
  Trapezoid() : Quadrangle("Trapezoid"){};
};
/*梯形*/
class Diamond : public Parallelogram
{
private:
  int bottomWidth;

public:
  Diamond(int topWidth, int bottomWidth, int height)
      : Parallelogram("Diamond", topWidth, height), bottomWidth(bottomWidth){};
  Diamond(const Diamond &q) : Parallelogram(q), bottomWidth(q.bottomWidth){};
};
