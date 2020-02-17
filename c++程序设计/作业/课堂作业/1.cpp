#include <bits/stdc++.h>
using namespace std;
/*
*类strBlob
*通过智能指针实现对象共享数据
*实现字符串的常见操作
*/
class strBlob
{
private:
    typedef vector<string>::size_type string_vector_size_type;
    shared_ptr<vector<string>> data;                                // 智能指针对象
    void check(string_vector_size_type i, const string &msg) const; //
public:
    strBlob();                                                    //普通构造函数
    strBlob(const initializer_list<string> &il);                  //复制构造函数
    string_vector_size_type size() const { return data->size(); } //返回大小
    bool empty() const { return data->empty(); }                  //判断是否为空
    void push_back(const string &t) { data->push_back(t); };      //添加
    void pop_back();                                              //删除
    string &front();                                              //返回头的引用
    string &back();                                               //返回尾的引用
    friend strBlob operator+(const strBlob &a, const strBlob &b); //重载运算符加+
    ~strBlob();                                                   //析构函数
};

// 默认构造函数，make_shared创建一个智能指针
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