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
  Node *tmp = new Node(); // Ϊ�����Node�ṹ�����һ���µ��ڴ�
    tmp->quad = q;          // ������Node�ṹ���quad��ʼ��Ϊq
    tmp->next = nullptr;    // ������Node�ṹ���next��ʼ��ΪNULL
    if (list.tail == nullptr){   // �ж������Ƿ�Ϊ��
      list.head = tmp;           //����Ϊ��ʱ����head��tail����Ϊtmp
      list.tail = tmp;
    } else{
      list.tail->next = tmp;  // �������β��ָ���nextָ���������Node�ṹ��
      list.tail = tmp;        // �������β����Ϊ�������Node�ṹ��
    }
    list.len += sizeof(Node);// �����¼����size
    return;
}