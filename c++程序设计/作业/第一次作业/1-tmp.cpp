#include<iostream>
struct Quadrangle{
  std::string tag;
};
typedef Quadrangle *QUADPTR;
struct Parallelogram{
  Quadrangle quad;
  int width, height;
};
struct Node
{
  QUADPTR quad;
  Node *next;
};
struct List{
  Node*head,*tail;
  size_t len;
};
void push_back(List&list, QUADPTR q){
  Node *tmp = new Node(); // 为加入的Node结构体分配一个新的内存
    tmp->quad = q;          // 将申请Node结构体的quad初始化为q
    tmp->next = nullptr;    // 将申请Node结构体的next初始化为NULL
    if (list.tail == nullptr){   // 判断链表是否为空
      list.head = tmp;           //链表为空时，把head和tail都置为tmp
      list.tail = tmp;
    } else{
      list.tail->next = tmp;  // 将链表的尾部指针的next指向新申请的Node结构体
      list.tail = tmp;        // 将链表的尾部置为新申请的Node结构体
    }
    list.len += sizeof(Node);// 加上新加入的size
    return;
}