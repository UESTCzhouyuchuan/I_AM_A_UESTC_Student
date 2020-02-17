// container.h
#pragma once
#include "quad.h"
#include <iostream>
class Container
{
public:
  Container &push_back(QUADPTR p);
  size_t size() const;
  bool isEmpty() const;
  void empty();
};
struct Node
{
  QUADPTR quad;
  Node *next;
};
class List : public Container
{
private:
  size_t len;
  Node *head, *tail;

public:
  List() : len(0), head(nullptr), tail(nullptr){};
  // ���ƹ��캯��
  List(const List &list);
  // ��������
  ~List();
  List &push_back(QUADPTR p);
  size_t size() const;
  bool isEmpty() const { return size() == 0; };
  void empty();
  void iterator();
};
bool Container::isEmpty() const
{
  return false;
};
size_t Container::size() const
{
  return 0;
}
void Container::empty()
{
}
Container &Container::push_back(QUADPTR p)
{
  return *this;
}
List &List::push_back(QUADPTR p)
{
  Node *tmp = new Node(); // Ϊ�����Node�ṹ�����һ���µ��ڴ�
  tmp->quad = p;          // ������Node�ṹ���quad��ʼ��Ϊq
  tmp->next = nullptr;    // ������Node�ṹ���next��ʼ��ΪNULL
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
  len += 1; // �����¼����size
  return *this;
}
size_t List::size() const
{
  return len;
}
void List::empty()
{
  if (!isEmpty())
  {
    Node *before = head, *after;
    while (before != tail)
    {
      after = before->next;
      delete before;
      before = after;
    }
    delete before;
    head = nullptr;
    tail = nullptr;
  }
};
List::List(const List &list)
{
  if (!list.isEmpty())
  {
    head = new Node();
    head->quad = list.head->quad;
    head->next = nullptr;
    Node *list_beCopy_iterator = list.head, *list_copy_iterator = head, *list_new_node;
    if (list.head != list.tail)
    {
      while (list_beCopy_iterator != list.tail)
      {
        list_new_node = new Node();
        list_beCopy_iterator = list_beCopy_iterator->next;
        list_new_node->quad = list_beCopy_iterator->quad;
        list_copy_iterator->next = list_new_node;
        list_copy_iterator = list_new_node;
      }
      tail = list_copy_iterator;
      tail->next = nullptr;
    }
    else
    {
      tail = new Node();
      tail->quad = list.tail->quad;
      tail->next = nullptr;
    }
    len = list.size();
  }
  else
  {
    List();
  }
};
List::~List()
{
  empty();
};
void List::iterator()
{
  if (isEmpty())
  {
    std::cout << "�����ǿյ�" << std::endl;
  }
  else
  {
    int count = 1;
    Node *tmp = head;
    while (tmp != tail && tmp != nullptr)
    {
      std::cout << "�����" << count << "����" << tmp->quad->what() << std::endl;
      count++;
      tmp = tmp->next;
    }
    std::cout << "�����" << count << "����" << tmp->quad->what() << std::endl;
  }
}