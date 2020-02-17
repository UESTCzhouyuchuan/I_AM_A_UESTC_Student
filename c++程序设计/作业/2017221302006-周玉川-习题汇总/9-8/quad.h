#pragma once
#include <string>
#include <iostream>
/*四边形*/
class Quadrangle
{
protected:
  std::string tag;

public:
  Quadrangle(std::string t) : tag(t){};
  std::string what() const { return tag; };
  virtual double area() const = 0; // 纯虚函数
  virtual void draw() const = 0;   // 纯虚函数
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
  double area() const { return width * height; };
  void draw() const { std::cout << "draw Parallelogram" << std::endl; };
};
/*矩形*/
class Rectangle : public Parallelogram
{
public:
  Rectangle(std::string tag, int w, int h) : Parallelogram(tag, w, h){};
  Rectangle(const Rectangle &q) : Parallelogram(q){};
  double area() const { return width * height; };
  void draw() const { std::cout << "draw Rectangle" << std::endl; };
};
/*正方形*/
class Square : public Rectangle
{
public:
  Square(int l) : Rectangle("Square", l, l){};
  Square(const Square &q) : Rectangle(q){};
  double area() const { return width * height; };
  void draw() const { std::cout << "draw Square" << std::endl; };
};
/*梯形*/
class Trapezoid : public Quadrangle
{
public:
  Trapezoid() : Quadrangle("Trapezoid"){};
  double area() const { return -1; };
  void draw() const { std::cout << "draw Trapezoid" << std::endl; };
};
/*菱形*/
class Diamond : public Parallelogram
{
private:
  int bottomWidth;

public:
  Diamond(int topWidth, int bottomWidth, int height)
      : Parallelogram("Diamond", topWidth, height), bottomWidth(bottomWidth){};
  Diamond(const Diamond &q) : Parallelogram(q), bottomWidth(q.bottomWidth){};
  double area() const { return (double)(width + bottomWidth) / 2 * height; };
  void draw() const { std::cout << "draw Diamond" << std::endl; };
};
