#pragma once
#include <string>
#include <iostream>
/*�ı���*/
class Quadrangle
{
protected:
  std::string tag;

public:
  Quadrangle(std::string t) : tag(t){};
  std::string what() const { return tag; };
  virtual double area() const = 0; // ���麯��
  virtual void draw() const = 0;   // ���麯��
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
  double area() const { return width * height; };
  void draw() const { std::cout << "draw Parallelogram" << std::endl; };
};
/*����*/
class Rectangle : public Parallelogram
{
public:
  Rectangle(std::string tag, int w, int h) : Parallelogram(tag, w, h){};
  Rectangle(const Rectangle &q) : Parallelogram(q){};
  double area() const { return width * height; };
  void draw() const { std::cout << "draw Rectangle" << std::endl; };
};
/*������*/
class Square : public Rectangle
{
public:
  Square(int l) : Rectangle("Square", l, l){};
  Square(const Square &q) : Rectangle(q){};
  double area() const { return width * height; };
  void draw() const { std::cout << "draw Square" << std::endl; };
};
/*����*/
class Trapezoid : public Quadrangle
{
public:
  Trapezoid() : Quadrangle("Trapezoid"){};
  double area() const { return -1; };
  void draw() const { std::cout << "draw Trapezoid" << std::endl; };
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
  double area() const { return (double)(width + bottomWidth) / 2 * height; };
  void draw() const { std::cout << "draw Diamond" << std::endl; };
};
