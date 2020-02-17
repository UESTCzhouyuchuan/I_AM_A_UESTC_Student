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

#define RAND_MAX 30 //定义形体类长度的最大数
#define NUM 5 //形体类个数
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
	cout << "================ C++实验微型C++控制台应用开发 =================" << endl;
	cout << "=====++++++++++++2017221302006 周玉川+++++++++++ =============" << endl;
	while (true) 
	{
		cout << "================q、Q：结束测试 ================================" << endl;
		cout << "================其他字符：继续测试 ============" << endl;
		cout << "user#";
		cmd = getchar();
		if (cmd == 'q' || cmd == 'Q') {
			cout << "============临走之前，复习一下 ============" << endl;
			list.traverse(access);
			cout << "============再见 ============" << endl;
			break;
		}
		while (cmd != '\n' && getchar() != '\n');
		width = rand() % RAND_MAX;
		height =  rand()% RAND_MAX;
		topWidth =  rand()% RAND_MAX;
		number = rand() % NUM;
		/*0：Diamond
		 *1：Parallelogram
		 *2：Rectangle
		 *3：Square
		 *4：Trapezoid
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
		cout << "计算随机生成图形的面积，并输入你的答案：" << endl << "answer:";
		cin >> answer;
		while (getchar() != '\n');
		if (answer == q->area())
		{
			cout << "恭喜你，答对了" << endl;
		}
		else
		{
			cout << "很遗憾，答错了" << endl;
		}
		list.push_back(q);
	}
}