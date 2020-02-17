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
  int width,height;
  Quadrangle quad;
public:
  void create(std::string tag, int w, int h);
  double area();
  void draw(bool showResult = true);
};

class Rectangle
{
private:
  int width,height;
public:
	Quadrangle quad;
  void create(std::string tag, int w, int h);
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
  void create(std::string tag, int w, int h);
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
  void create(std::string tag, int w, int h);
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
  void create(std::string tag, int w, int h);
  double area();
  void draw(bool showResult = true);
  Diamond(){
    quad.tag = "Diamond";
  }
};






