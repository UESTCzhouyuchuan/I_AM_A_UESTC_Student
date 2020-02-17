#pragma once
#include<string>
#include<iostream>
#include "quadrangle.h"
using namespace std;
/*梯形*/
class Trapezoid : public Quadrangle
{
public:
	Trapezoid(int w1 = 5.0, int w2 = 7.0, int h = 8.0, string tag = "Trapezoid") :topWidth(w1), bottomWidth(w2), height(h), Quadrangle(tag) {};
	~Trapezoid() {};
	void draw(){ std::cout << what()<<":上底=" <<TopWidth()<<",下底="<<BottomWidth()
		<<",高="<<Height()<< std::endl;; };
	double area() const { return (double)(bottomWidth + topWidth) * height / 2; };
	string what() const { return tag; };
	int& BottomWidth() { return bottomWidth; };
	int& TopWidth() { return topWidth; };
	int& Height() { return height; };
	Trapezoid& operator=(const Trapezoid& tr)
	{
		tag = tr.tag;
		bottomWidth = tr.bottomWidth;
		topWidth = tr.topWidth;
		height = tr.height;
		return *this;
	}
protected:
	int topWidth;
	int bottomWidth;
	int height;
};
