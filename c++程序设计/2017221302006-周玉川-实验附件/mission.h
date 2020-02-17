#pragma once

#include<iostream>
#include<cstdlib>
#include<ctime>
#include<cstring>

#include "diamond.h";
#include "List.h";
#include "parallelogram.h";
#include "quadrangle.h";
#include "rectangle.h";
#include "square.h";
#include "trapezoid.h";

#define RAND_MAX 30 //���������೤�ȵ������
#define NUM 5 //���������
using namespace std;
class Mission {
public:
	Mission() { cout << "***************************Missiion Start!*******************************" << endl; };
	void Start();
	~Mission() { cout << "**************************Missiion End!*********************************" << endl; };

};
bool access(QUADPTR p) {
	p->draw();
	cout << "area=" << p->area() << endl;
	return true;
}
void Mission::Start()
{
	int width, height, topWidth, number;
	double answer;
	QUADPTR q = new Trapezoid();
	List list;
	char cmd;
	srand((unsigned)time(NULL));
	cout << "================ C++ʵ��΢��C++����̨Ӧ�ÿ��� =================" << endl;
	cout << "=====++++++++++++2017221302006 ����+++++++++++ =============" << endl;
	while (true) 
	{
		cout << "================q��Q���������� ================================" << endl;
		cout << "================�����ַ����������� ============" << endl;
		cout << "user#";
		cmd = getchar();
		if (cmd == 'q' || cmd == 'Q') {
			cout << "============����֮ǰ����ϰһ�� ============" << endl;
			list.traverse(access);
			cout << "============�ټ� ============" << endl;
			break;
		}
		while (cmd != '\n' && getchar() != '\n');
		width = rand() % RAND_MAX;
		height =  rand()% RAND_MAX;
		topWidth =  rand()% RAND_MAX;
		number = rand() % NUM;
		/*0��Diamond
		 *1��Parallelogram
		 *2��Rectangle
		 *3��Square
		 *4��Trapezoid
		 */
		switch (number) {
		case 0:
			q = new Diamond(width);
			break;
		case 1:
			q = new Parallelogram(width, height);
			break;
		case 2:
			q = new Rectangle(width, height);
			break;
		case 3:
			q = new Square(width);
			break;
		case 4:
			q = new Trapezoid(width, topWidth, height);
			break;
		};
		q->draw();
		cout << "�����������ͼ�ε��������������Ĵ𰸣�" << endl << "answer:";
		cin >> answer;
		while (getchar() != '\n');
		if (answer == q->area())
		{
			cout << "��ϲ�㣬�����" << endl;
		}
		else
		{
			cout << "���ź��������" << endl;
		}
		list.push_back(q);
	}
}