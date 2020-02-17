#pragma once
#include<string>
#include<iostream>
#include "quadrangle.h"
using namespace std;
/*平行四边形*/
class Parallelogram : public Quadrangle
{
public:
	Parallelogram(int w = 5, int h = 7, string nm = "Parallelogram") :width(w), height(h), Quadrangle(nm) {};
	Parallelogram(const Parallelogram& q) : width(q.width), height(q.height), Quadrangle(q.tag) {};
	~Parallelogram() {};
	void draw() const { std::cout << "draw Parallelogram" << std::endl;; };
	double area() const { return width * height; };
	void draw() {
		std::cout << what() << ":宽=" << Width()
			<< ",高=" << Height() << std::endl;;
	};
	int& Width() { return width; }; //获取矩形的宽。如果是梯形，还需要一个成员int& Width2()来获取另一条平行边的长度
	int& Height() { return height; };//获取矩形的高
	Parallelogram& operator=(const Parallelogram& pa)
	{
		tag = pa.tag;
		width = pa.width;
		height = pa.height;
		return *this;
	}
protected:
	int width;
	int height;
};
