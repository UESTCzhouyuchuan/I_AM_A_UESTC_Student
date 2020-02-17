#pragma once
#include <string>
/*�ı���*/
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
/**ƽ���ı���*/
class Parallelogram : public Quadrangle
{
protected:
  int width, height;

public:
  // ���캯��
  Parallelogram(std::string tag, int w, int h) : Quadrangle(tag), width(w), height(h){};
  // ���ƹ��캯��
  Parallelogram(const Parallelogram &q) : width(q.width), height(q.height), Quadrangle(q.tag){};
  ~Parallelogram();
  double area();
  void draw(bool showResult = true);
};
/*����*/
class Rectangle : public Parallelogram
{
public:
  Rectangle(std::string tag, int w, int h) : Parallelogram(tag, w, h){};
  Rectangle(const Rectangle &q) : Parallelogram(q){};
};
/*������*/
class Square : public Rectangle
{
public:
  Square(int l) : Rectangle("Square", l, l){};
  Square(const Square &q) : Rectangle(q){};
};
/*�������ı���*/
class Trapezoid : public Quadrangle
{
public:
  Trapezoid() : Quadrangle("Trapezoid"){};
};
/*����*/
class Diamond : public Parallelogram
{
private:
  int bottomWidth;

public:
  Diamond(int topWidth, int bottomWidth, int height)
      : Parallelogram("Diamond", topWidth, height), bottomWidth(bottomWidth){};
  Diamond(const Diamond &q) : Parallelogram(q), bottomWidth(q.bottomWidth){};
};
