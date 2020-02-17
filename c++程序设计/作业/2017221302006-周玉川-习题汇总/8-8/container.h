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
  // 复制构造函数
  List(const List &list);
  // 析构函数
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
  Node *tmp = new Node(); // 为加入的Node结构体分配一个新的内存
  tmp->quad = p;          // 将申请Node结构体的quad初始化为q
  tmp->next = nullptr;    // 将申请Node结构体的next初始化为NULL
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
  len += 1; // 加上新加入的size
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
    std::cout << "链表是空的" << std::endl;
  }
  else
  {
    int count = 1;
    Node *tmp = head;
    while (tmp != tail && tmp != nullptr)
    {
      std::cout << "链表第" << count << "个是" << tmp->quad->what() << std::endl;
      count++;
      tmp = tmp->next;
    }
    std::cout << "链表第" << count << "个是" << tmp->quad->what() << std::endl;
  }
}