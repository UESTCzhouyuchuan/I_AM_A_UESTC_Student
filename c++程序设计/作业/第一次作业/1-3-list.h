#pragma once
#include "1-3-quad.h"

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
  List(){
    head = nullptr;
    tail = nullptr;
    len = 0;
  };
  void init(){};
  void push_back(QUADPTR p)
  {
    Node *tmp = new Node(); // Ϊ�����Node�ṹ�����һ���µ��ڴ�
    tmp->quad = p;          // ������Node�ṹ���quad��ʼ��Ϊq
    tmp->next = nullptr;    // ������Node�ṹ���next��ʼ��ΪNULL
    if (tail == nullptr){   // �ж������Ƿ�Ϊ��
      head = tmp;           //����Ϊ��ʱ����head��tail����Ϊtmp
      tail = tmp;
    } else{
      tail->next = tmp;  // �������β��ָ���nextָ���������Node�ṹ��
      tail = tmp;        // �������β����Ϊ�������Node�ṹ��
    }
    len += sizeof(Node);// �����¼����size
    return;
  }
  void traverse(predicate_t pred);
  void itrator(){
    if (tail == nullptr){
      std::cout << "�����ǿյ�"<<std::endl;
    } else{
      int count = 1;
      Node*tmp = head;
      while(tmp !=tail){
        std::cout << "�����" << count << "����" << tmp->quad->tag<<std::endl;
        count++;
        tmp = tmp->next;
      }
      std::cout << "�����" << count << "����" << tmp->quad->tag;
    }
  }
  size_t size(){
    return len;
  };
};