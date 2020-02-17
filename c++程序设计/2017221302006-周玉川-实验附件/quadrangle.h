#pragma once
#include <string>
/*�ı���*/
class Quadrangle
{
protected:
	std::string tag;

public:
	Quadrangle(std::string t) : tag(t) {};
	std::string what() const { return tag; };
	virtual double area() const = 0; // ���麯��
	virtual void draw() = 0;   // ���麯��
};

typedef Quadrangle* QUADPTR;