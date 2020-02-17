//
//  Header.h
//  homework3
//
//  Created by lan on 2019/10/13.
//  Copyright © 2019 lan. All rights reserved.
//

#include <iostream>
#include <stdio.h>
#include <string>

class Quadrangle
{
public:
    std::string tag;
    std::string what()
    {
        return tag;
    };
};


class Rectangle
{
private:
    Quadrangle quad;
    int width, length;
    
public:
    void create(std::string Tag, int w, int l)
    {
        quad.tag=Tag;
        width=w;
        length=l;
    };
    
    double area()
    {
        return width*length;
    }
    
    void draw(){
        std::cout<<"The type:"<<quad.tag<<",Width:"<<width<<",Lenth:"<<length;
    };
};


class Square{
private:
    Quadrangle quad;
    int len;
    
public:
    void create(std::string Tag, int l)
    {
        quad.tag=Tag;
        len=l;
    }
    
    double area()
    {
        return len*len;
    }
    
    void draw()
    {
           std::cout<<"The type:"<<quad.tag<<",lenth:"<<len;
       }
};


class Trapezoid
{
private:
    Quadrangle quad;
    int up_l, low_l, high;

public:
    void create(std::string Tag, int up, int low, int h)
    {
        quad.tag=Tag;
        up_l=up;
        low_l=low;
        high=h;
    }
    
    double area()
    {
        return high*(up_l+low_l)/2;
    }
    
    void draw()
    {
           std::cout<<"The type:"<<quad.tag<<",uplenth:"<<up_l<<",lowlenth:"<<low_l<<",high:"<<high;
       }
};


class Diamond
{
private:
    Quadrangle quad;
    int dia1, dia2;

public:
    void create(std::string Tag, int l1, int l2)
    {
        quad.tag=Tag;
        dia1=l1;
        dia2=l2;
    }
    
    double area(){
        return dia1*dia2/2;
    }
    
    void draw(){
           std::cout<<"The type:"<<quad.tag<<"diagonal1"<<dia1<<"diagonal2"<<dia2;
       }
};


typedef Quadrangle*  QUADPTR;

struct Node
{
    QUADPTR quad;
    Node *next;
};



class List
{
private:
    Node *head, *tail;
    size_t len;
    
public:
    void init()
    {
        head=nullptr;
        tail=nullptr;
        len=0;
    }

    void push_back(QUADPTR q)
    {
        Node *s;
        if(len<=0)
        {
            s=(Node*)malloc(sizeof(Node));
            s->quad=q;
            s->next=nullptr;
            head=s;
            tail=s;
            len=1;
        }
        else
        {
            s=(Node*)malloc(sizeof(Node));
            s->next=tail->next;
            tail->next=s;
            s->quad=q;
            tail=s;
            len++;
        }
    }

    size_t size()
    {
        return len;
    }

    bool isEmpty()
    {
        if(len==0)
            return true;
        else
            return false;
    }

    void empty()
    {
        int i;
        Node *s;
        for(i=0; i<(int)len; i++){
            s=(Node*)malloc(sizeof(Node));
            s=head;
            head=s->next;
            free(s);
        }
        head->next=nullptr;
        head->quad=nullptr;
        tail=head;
        len=0;
    }
    
    void traverse( )
    {
        Node *s;
        s=(Node*)malloc(sizeof(Node));
        s=head;
        
        while(1){
            if(s == tail || s->next==nullptr)
                break;
            else{
                std::cout<<"The shape:"<<s->quad->tag;
                s=s->next;
            }
        }
    }
};
    
