#pragma once
#include<string>
#include<iostream>
#include "parallelogram.h"
using namespace std;
/*¾ØÐÎ*/
class Rectangle : public Parallelogram
{
public:
	Rectangle(int w = 4, int h = 8, string nm = "Rectangle") :Parallelogram(w, h, nm) {};
	Rectangle(const Rectangle & rec) :Parallelogram(rec) {};
	~Rectangle() {};
	string what()const { return Parallelogram::what(); }
	double area()const { return Parallelogram::area(); }
	void draw() {
		std::cout << what() << ":¿í=" << Width()
			<< ",¸ß=" << Height() << std::endl;;
	};
	int& Width() { return width; }
	int& Height() { return height; };
	Rectangle& operator=(const Rectangle& re)
	{
		tag = re.tag;
		width = re.width;
		height = re.height;
		return *this;
	}
};
