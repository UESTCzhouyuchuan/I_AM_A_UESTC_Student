#pragma once
#include<string>
#include<iostream>
#include "quadrangle.h"
using namespace std;
/*ƽ���ı���*/
class Parallelogram : public Quadrangle
{
public:
	Parallelogram(int w = 5, int h = 7, string nm = "Parallelogram") :width(w), height(h), Quadrangle(nm) {};
	Parallelogram(const Parallelogram& q) : width(q.width), height(q.height), Quadrangle(q.tag) {};
	~Parallelogram() {};
	void draw() const { std::cout << "draw Parallelogram" << std::endl;; };
	double area() const { return width * height; };
	void draw() {
		std::cout << what() << ":��=" << Width()
			<< ",��=" << Height() << std::endl;;
	};
	int& Width() { return width; }; //��ȡ���εĿ���������Σ�����Ҫһ����Աint& Width2()����ȡ��һ��ƽ�бߵĳ���
	int& Height() { return height; };//��ȡ���εĸ�
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
