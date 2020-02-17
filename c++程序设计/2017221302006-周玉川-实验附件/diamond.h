#pragma once
#include<string>
#include<iostream>
#include "parallelogram.h"
using namespace std;
/*¡‚–Œ*/
class Diamond : public Parallelogram
{
public:
	Diamond(int l = 5, string tag = "Diamond") :Parallelogram(l, l, tag) {};
	~Diamond() {};
	void draw() {
		std::cout << what() << ":øÌ=" << Width()
			<< ",∏ﬂ=" << Height() << std::endl;;
	};
	double area() const { return (double)width * height / 2; };
	string what() const { return tag; };
	int Width() { return width; }; 
	int Height() { return height; };
	Diamond& operator= (const Diamond& di)
	{
		tag = di.tag;
		width = di.width;
		height = di.height;
		return *this;
	}

};
