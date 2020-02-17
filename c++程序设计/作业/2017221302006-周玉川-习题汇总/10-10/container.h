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
  // ���ƹ��캯��
  List(const List &list);
  // ��������
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
  Node<T> *tmp = new Node<T>(); // Ϊ�����Node�ṹ�����һ���µ��ڴ�
  tmp->quad = p;                // ������Node�ṹ���quad��ʼ��Ϊq
  tmp->next = nullptr;          // ������Node�ṹ���next��ʼ��ΪNULL
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
    std::cout << "�����ǿյ�" << std::endl;
  }
  else
  {
    int count = 1;
    Node<T> *tmp = head;
    while (tmp != tail && tmp != nullptr)
    {
      std::cout << "�����" << count << "����" << tmp->quad->what();
      std::cout << ";���Ϊ��" << tmp->quad->area() << std::endl;
      count++;
      tmp = tmp->next;
    }
    std::cout << "�����" << count << "����" << tmp->quad->what();
    std::cout << ";���Ϊ��" << tmp->quad->area() << std::endl;
  }
}