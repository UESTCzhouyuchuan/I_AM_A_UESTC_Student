#pragma once
#include <string>
/*ËÄ±ßÐÎ*/
class Quadrangle
{
protected:
	std::string tag;

public:
	Quadrangle(std::string t) : tag(t) {};
	std::string what() const { return tag; };
	virtual double area() const = 0; // ´¿Ðéº¯Êý
	virtual void draw() = 0;   // ´¿Ðéº¯Êý
};

typedef Quadrangle* QUADPTR;