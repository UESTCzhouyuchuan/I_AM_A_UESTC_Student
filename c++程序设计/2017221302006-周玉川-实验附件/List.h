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
	// Ĭ�Ϲ��캯��
	List()
	{
		head = nullptr;
		tail = nullptr;
		len = 0;
	};
	// ���ƹ��캯��
	List(const List& list);
	// ��������
	~List();
	bool isEmpty() const { return len == 0; }; // �ж�����Ϊ��
	void empty();                                                        //�������
	List& operator+=(QUADPTR p);
	List& operator+=(const List& list); //ƴ����������
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
//ƴ����������
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
	empty();           //���ͷ�
	return *this += p; //�ٸ���
};
QUADPTR List::operator[](size_t index)
{
	if (index < 0 || index >= size())
	{
		return nullptr; //������Χ���ؿ�
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
		empty();// �ͷ�
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
	Node* tmp = new Node(p); // Ϊ�����Node�ṹ�����һ���µ��ڴ�
	if (tail == nullptr)
	{             // �ж������Ƿ�Ϊ��
		head = tmp; //����Ϊ��ʱ����head��tail����Ϊtmp
		tail = tmp;
	}
	else
	{
		tail->next = tmp; // �������β��ָ���nextָ���������Node�ṹ��
		tail = tmp;       // �������β����Ϊ�������Node�ṹ��
	}
	len += 1;// �����¼����size
	return *this;
}
void List::traverse(predicate_t pred)
{
	if (isEmpty())
	{
		std::cout << "�����ǿյ�" << std::endl;
	}
	else
	{
		int count = 0;
		Node* temp = head;
		while (temp != nullptr && count < len) 
		{
			std::cout << "��" << ++count << "��" << std::endl;
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