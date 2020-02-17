#pragma once
#include<iostream>
class Quadrangle
{
public:
  std::string tag;
  std::string what(){
    return tag;
  };
};

typedef Quadrangle *QUADPTR;

class Parallelogram
{
private:
  Quadrangle quad;
  int width,height;
public:
  Parallelogram(std::string tag,int w,int h){
    quad.tag = tag;
    width = w;
    height = h;
  };
  // 复制构造函数
  Parallelogram(const Parallelogram &q):quad(q.quad),width(q.width),height(q.height){};
  ~Parallelogram();
  void create(std::string tag, int w, int h) 
  { 
    quad.tag = tag;
    width = w;
    height = h;
  };
  double area();
  void draw(bool showResult = true);
};

class Rectangle
{
private:
  int width,height;
  Quadrangle quad;
public:
  void create(int w, int h) 
  { 
    quad.tag = "Rectangle";
    width = w;
    height = h;
  };
  double area();
  void draw(bool showResult = true);
  Rectangle(){
    quad.tag = "Rectangle";
  }
};
class Square
{
private:
  Quadrangle quad;
  int width,height;
public:
  void create(int w, int h) 
  { 
    quad.tag = "Square";
    width = w;
    height = h;
  };
  double area();
  void draw(bool showResult = true);
  Square(){
    quad.tag = "Square";
  }
};
class Trapezoid
{
private:
  Quadrangle quad;
  int width,height;
public:
  void create(int w, int h) 
  { 
    quad.tag = "Trapezoid";
    width = w;
    height = h;
  };
  double area();
  void draw(bool showResult = true);
  Trapezoid(){
    quad.tag = "Trapezoid";
  }
};
class Diamond
{
private:
  Quadrangle quad;
  int width,height;
public:
  void create(int w, int h) 
  { 
    quad.tag = "Diamond";
    width = w;
    height = h;
  };
  double area();
  void draw(bool showResult = true);
  Diamond(){
    quad.tag = "Diamond";
  }
};





