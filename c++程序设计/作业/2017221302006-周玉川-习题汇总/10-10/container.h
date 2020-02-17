// container.h
#pragma once
#include "quad.h"
template <typename T>
class Container
{
public:
  virtual ~Container(){};
  virtual Container &push_back(T p);
  virtual size_t size() const = 0;
  virtual bool isEmpty() const = 0;
  virtual void empty() = 0;
};
template <typename T>
struct Node
{
  T quad;
  Node *next;
};
template <typename T>
class List : public Container<T>
{
private:
  size_t len;
  Node<T> *head, *tail;
  template <typename U>
  friend List<U> operator+(const List<U> &list, U p);
  template <typename U>
  friend List<U> operator+(const List<U> &list1, const List<U> &list2);

public:
  List() : len(0), head(nullptr), tail(nullptr){};
  // 复制构造函数
  List(const List &list);
  // 析构函数
  ~List();
  List &push_back(T p);
  size_t size() const;
  bool isEmpty() const { return size() == 0; };
  void empty();
  void iterator();
};
template <typename T>
List<T> operator+(const List<T> &list, T p)
{
  List<T> t(list);
  return t.push_back(p);
};
template <typename T>
List<T> operator+(const List<T> &list1, const List<T> &list2)
{
  List<T> t(list1);
  if (list2.isEmpty())
    return t;
  Node<T> *temp = list2.head;
  while (temp != list2.tail)
  {
    t.push_back(temp->quad);
    temp = temp->next;
  }
  return t.push_back(temp->quad);
};
template <typename T>
bool Container<T>::isEmpty() const
{
  return false;
};
template <typename T>
size_t Container<T>::size() const
{
  return 0;
}
template <typename T>
void Container<T>::empty()
{
}
template <typename T>
Container<T> &Container<T>::push_back(T p)
{
  return *this;
}
template <typename T>
List<T> &List<T>::push_back(T p)
{
  Node<T> *tmp = new Node<T>(); // 为加入的Node结构体分配一个新的内存
  tmp->quad = p;                // 将申请Node结构体的quad初始化为q
  tmp->next = nullptr;          // 将申请Node结构体的next初始化为NULL
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
template <typename T>
size_t List<T>::size() const
{
  return len;
}
template <typename T>
void List<T>::empty()
{
  if (!isEmpty())
  {
    Node<T> *before = head, *after;
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
template <typename T>
List<T>::List(const List<T> &list)
{
  if (!list.isEmpty())
  {
    head = new Node<T>();
    head->quad = list.head->quad;
    head->next = nullptr;
    Node<T> *list_beCopy_iterator = list.head, *list_copy_iterator = head, *list_new_node;
    if (list.head != list.tail)
    {
      while (list_beCopy_iterator != list.tail)
      {
        list_new_node = new Node<T>();
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
      tail = new Node<T>();
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
template <typename T>
List<T>::~List()
{
  empty();
};
template <typename T>
void List<T>::iterator()
{
  if (isEmpty())
  {
    std::cout << "链表是空的" << std::endl;
  }
  else
  {
    int count = 1;
    Node<T> *tmp = head;
    while (tmp != tail && tmp != nullptr)
    {
      std::cout << "链表第" << count << "个是" << tmp->quad->what();
      std::cout << ";面积为：" << tmp->quad->area() << std::endl;
      count++;
      tmp = tmp->next;
    }
    std::cout << "链表第" << count << "个是" << tmp->quad->what();
    std::cout << ";面积为：" << tmp->quad->area() << std::endl;
  }
}