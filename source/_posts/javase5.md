---
title: Java基础5：抽象类和接口
date: 2018-04-24 00:30:14
tags:
	- Java基础
categories:
	- 后端
	- Java
---
本文主要介绍了抽象类和接口的使用方法和区别

具体代码在我的GitHub中可以找到
> https://github.com/h2pl/MyTech

喜欢的话麻烦点下星哈

文章首发于我的个人博客：
> https://h2pl.github.io/2018/04/24/javase5

更多关于Java后端学习的内容请到我的CSDN博客上查看：

https://blog.csdn.net/a724888
<!-- more -->
>1 抽象类一般会实现一部分操作，并且留一些抽象方法让子类自己实现，比如Stringbuffer和Stringbuilder的父类abstractStringbuilder。

>2 接口一般指一种规定，比如一个map接口中，可能需要实现增删改查等功能，如果你想实现一个具体map，这些方法就必须按照规定去实现。

>3 另外，一个类可以实现多个接口，但是不能继承多个类。
然而接口却可以继承多个其他接口。这一点很神奇。

下面看一下具体的例子，有一些小细节平时可能不会注意。
    
    class A {
    
    }
    interface M extends N,L{

    }
    interface N{
    
    }
    interface L{
    
    }
    interface 接口 {
        public final int i = 1;//变量默认都为public final修饰
        final A a = null;//基本数据类型和引用都一样
        //protected void a();//报错
        //private //报错
        public abstract void a();// 方法都是public abstract修饰的。
    
        //void b(){} 报错，接口里的方法不能有方法体，也不能有{}，只能有()；
    
        // final void b();
        // 注意，抽象方法不能加final。因为final方法不能被重写。
        //但如果抽象方法不被重写那就没有意义了，因为他根本没有代码体。
    
    }
    abstract class 抽象类 {
        public final int i = 1;//变量并没有被pulic和final修饰，只是一般的成员变量
        public final A a = null;
    
        private void A(){}//抽象类可以有具体方法
        abstract void AA();//抽象方法没有方法体
    
        //private abstract void B();//报错，组合非法
        // 因为private修饰的方法无法被子类重写，所以和final一样，使抽象方法无法被实现。
    
    }
    
    //抽象类也可以被实例化，举例说明
    abstract class B{
        B() {
            System.out.println("b init");
        }
    }
    
    class C extends B{
        C(){
            super();
            System.out.println("c init");
        }
    }
    
    public class 接口对比抽象类 {
        @Test
        public void test() {
            C c = new C();
            //结果先实例化B，再实例化C。
            //因为会调用到父类的构造方法。
        }
    }