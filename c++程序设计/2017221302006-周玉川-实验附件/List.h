#pragma once
#include "quadrangle.h"
#include<iostream>

struct Node
{
	QUADPTR quad;
	Node* next;
	Node(QUADPTR q) :quad(q), next(nullptr) {};
};

typedef bool predicate_t(QUADPTR);

class List
{
private:
	Node* head, * tail;
	size_t len;

public:
	// 默认构造函数
	List()
	{
		head = nullptr;
		tail = nullptr;
		len = 0;
	};
	// 复制构造函数
	List(const List& list);
	// 析构函数
	~List();
	bool isEmpty() const { return len == 0; }; // 判断链表为空
	void empty();                                                        //清空链表
	List& operator+=(QUADPTR p);
	List& operator+=(const List& list); //拼接两个链表
	List& operator=(const List& p);
	QUADPTR operator[](size_t index);

	friend List operator+(const List& list, QUADPTR p);
	friend List operator+(const List& list1, const List& list2);
	List& push_back(QUADPTR p);
	void traverse(predicate_t pred);
	size_t size() const { return len; };
};
List& List::operator+=(QUADPTR p)
{
	return push_back(p);
};
//拼接两个链表
List& List::operator+=(const List& list)
{
	if (list.isEmpty())
		return *this;
	Node* t = list.head;
	while (t != list.tail)
	{
		push_back(t->quad);
		t = t->next;
	}
	return push_back(t->quad);
};
List& List::operator=(const List& p)
{
	empty();           //先释放
	return *this += p; //再复制
};
QUADPTR List::operator[](size_t index)
{
	if (index < 0 || index >= size())
	{
		return nullptr; //超出范围返回空
	}
	if (index == (size() - 1))
	{
		return tail->quad;
	}
	Node* t = head;
	while (index--)
	{
		t = t->next;
	}
	return t->quad;
};

List operator+(const List& list, QUADPTR p)
{
	List t(list);
	return t += p;
};
List operator+(const List& list1, const List& list2)
{
	List t(list1);
	return t += list2;
};
List::List(const List& list)
{
	if (!list.isEmpty())
	{
		empty();// 释放
		head = new Node(list.head->quad);
		Node* list_beCopy_iterator = list.head, * list_copy_iterator = head, * list_new_node;
		if (list.head != list.tail)
		{
			while (list_beCopy_iterator != list.tail)
			{
				list_new_node = new Node(list_beCopy_iterator->quad);
				list_beCopy_iterator = list_beCopy_iterator->next;
				list_copy_iterator->next = list_new_node;
				list_copy_iterator = list_new_node;
			}
			tail = list_copy_iterator;
			tail->next = nullptr;
		}
		else
		{
			tail = head;
		}
		len = list.size();
	}
	else
	{
		List();
	}
}
List::~List()
{
	empty();
}
List& List::push_back(QUADPTR p)
{
	Node* tmp = new Node(p); // 为加入的Node结构体分配一个新的内存
	if (tail == nullptr)
	{             // 判断链表是否为空
		head = tmp; //链表为空时，把head和tail都置为tmp
		tail = tmp;
	}
	else
	{
		tail->next = tmp; // 将链表的尾部指针的next指向新申请的Node结构体
		tail = tmp;       // 将链表的尾部置为新申请的Node结构体
	}
	len += 1;// 加上新加入的size
	return *this;
}
void List::traverse(predicate_t pred)
{
	if (isEmpty())
	{
		std::cout << "链表是空的" << std::endl;
	}
	else
	{
		int count = 0;
		Node* temp = head;
		while (temp != nullptr && count < len) 
		{
			std::cout << "第" << ++count << "个" << std::endl;
			pred(temp->quad);
			temp = temp->next;

		}
	}
};
void List::empty()
{
	if (!isEmpty())
	{
		Node* before = head, * after;
		while (before != tail)
		{
			after = before->next;
			delete before;
			before = after;
		}
		delete before;
		head = nullptr;
		tail = nullptr;
		len = 0;
	}
};