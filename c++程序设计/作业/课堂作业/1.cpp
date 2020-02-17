#include <bits/stdc++.h>
using namespace std;
/*
*��strBlob
*ͨ������ָ��ʵ�ֶ���������
*ʵ���ַ����ĳ�������
*/
class strBlob
{
private:
    typedef vector<string>::size_type string_vector_size_type;
    shared_ptr<vector<string>> data;                                // ����ָ�����
    void check(string_vector_size_type i, const string &msg) const; //
public:
    strBlob();                                                    //��ͨ���캯��
    strBlob(const initializer_list<string> &il);                  //���ƹ��캯��
    string_vector_size_type size() const { return data->size(); } //���ش�С
    bool empty() const { return data->empty(); }                  //�ж��Ƿ�Ϊ��
    void push_back(const string &t) { data->push_back(t); };      //���
    void pop_back();                                              //ɾ��
    string &front();                                              //����ͷ������
    string &back();                                               //����β������
    friend strBlob operator+(const strBlob &a, const strBlob &b); //�����������+
    ~strBlob();                                                   //��������
};

// Ĭ�Ϲ��캯����make_shared����һ������ָ��
strBlob::strBlob() : data(make_shared<vector<string>>())
{
}

strBlob::strBlob(const initializer_list<string> &il) : data(make_shared<vector<string>>(il))
{
}

void strBlob::pop_back()
{
    check(0, "pop_back on empty strBlob");
    data->pop_back();
}

string &strBlob::front()
{
    check(0, "front on empty strBlob");
    return data->front();
}

string &strBlob::back()
{
    check(0, "back on empty strBlob");
    return data->back();
}
strBlob operator+(const strBlob &a, const strBlob &b)
{
    shared_ptr<vector<string>> data = a.data;
}
strBlob::~strBlob()
{
}

void strBlob::check(string_vector_size_type i, const string &msg) const
{
    if (i >= data->size())
    {
        throw out_of_range(msg);
    }
}
int main()
{
    strBlob b1;
    strBlob b2 = {"a", "an", "the"};
    b1 = b2;
    b2.push_back("about");

    cout << "b1:" << b1.size();
    cout << "b2:" << b2.size();
    return 0;
}