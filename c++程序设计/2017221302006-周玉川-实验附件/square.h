#pragma once
#include<string>
#include<iostream>
#include "rectangle.h"
using namespace std;
/*Õý·½ÐÎ*/
class Square : public Rectangle
{
public:
	Square(int w = 6, string nm = "Square") :Rectangle(w, w, nm) {};
	~Square() {};
	void draw() {
		std::cout << what() << ":¿í=" << Width()<< std::endl;;
	};
	double area() const { return width * width; };
	string what() const { return Rectangle::what(); };
	int& Width() { return width; };
	Square& operator=(const Square& sq)
	{
		tag = sq.tag;
		width = sq.width;
		height = sq.height;
		return *this;
	}
};

