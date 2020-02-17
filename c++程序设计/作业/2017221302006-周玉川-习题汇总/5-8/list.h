#pragma once
#include "quad.h"

struct Node
{
  QUADPTR quad;
  Node *next;
};

typedef bool predicate_t(QUADPTR);

class List
{
private:
  Node *head, *tail;
  size_t len;

public:
  List()
  {
    head = nullptr;
    tail = nullptr;
    len = 0;
  };
  List(const List &list)
  {
    if (list.head != nullptr && list.tail != nullptr)
    {
      head = new Node();
      head->quad = list.head->quad;
      head->next = nullptr;
      Node *list_beCopy_itrator = list.head, *list_copy_itrator = head, *list_new_node;
      if (list.head != list.tail)
      {
        while (list_beCopy_itrator != list.tail)
        {
          list_new_node = new Node();
          list_beCopy_itrator = list_beCopy_itrator->next;
          list_new_node->quad = list_beCopy_itrator->quad;
          list_copy_itrator->next = list_new_node;
          list_copy_itrator = list_new_node;
        }
        tail = list_copy_itrator;
        tail->next = nullptr;
      }
      else
      {
        tail = new Node();
        tail->quad = list.tail->quad;
        tail->next = nullptr;
      }
    }
  };
  ~List()
  {
    if (tail != nullptr)
    {
      Node *before = head, *after;
      while (before != tail)
      {
        after = before->next;
        delete before;
        before = after;
      }
      delete before;
    }
  };
  void init()
  {
    head = nullptr;
    tail = nullptr;
    len = 0;
  };
  void push_back(QUADPTR p)
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
    len += sizeof(Node); // 加上新加入的size
    return;
  }
  void traverse(predicate_t pred);
  void itrator()
  {
    if (tail == nullptr)
    {
      std::cout << "链表是空的" << std::endl;
    }
    else
    {
      int count = 1;
      Node *tmp = head;
      while (tmp != tail && tmp != nullptr)
      {
        std::cout << "链表第" << count << "个是" << tmp->quad->tag << std::endl;
        count++;
        tmp = tmp->next;
      }
      std::cout << "链表第" << count << "个是" << tmp->quad->tag << std::endl;
    }
  }
  size_t size()
  {
    return len;
  };
  bool isEmpty()
  {
    return head == nullptr && tail == nullptr;
  }
  void empty()
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
  }
};