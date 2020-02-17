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
	List(){
    head = NULL;
    tail = NULL;
    len = 0;
  };
  void init();
  void push_back(QUADPTR p)
  {
    Node *tmp = new Node(); // Ϊ�����Node�ṹ�����һ���µ��ڴ�
    tmp->quad = p;          // ������Node�ṹ���quad��ʼ��Ϊq
    tmp->next = NULL;    // ������Node�ṹ���next��ʼ��ΪNULL
    if (tail == NULL){   // �ж������Ƿ�Ϊ��
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
  size_t size();
  void itrator(){
    if (tail == NULL){
      std::cout << "�����ǿյ�";
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
  };
};
