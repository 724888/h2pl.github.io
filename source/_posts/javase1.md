---
title: Java基础1：理解Java面向对象三大特性
date: 2018-04-22 00:51:35
tags:
    - Java基础系列
categories:
	- 后端
	- Java
---


具体代码在我的GitHub中可以找到：
> https://github.com/h2pl/MyTech

喜欢的话麻烦点下星哈

文章首发于我的个人博客：
> https://h2pl.github.io/2018/04/22/javase1

更多关于Java后端学习的内容请到我的CSDN博客上查看：
> https://blog.csdn.net/a724888

本节主要介绍Java面向对象三大特性：继承 封装 多态，以及其中的原理。

本文会结合虚拟机对引用和对象的不同处理来介绍三大特性的原理。

<!-- more -->

## 继承

Java中的继承只能单继承，但是可以通过内部类继承其他类来实现多继承。


    public class Son extends Father{
    public void go () {
    System.out.println("son go");
    }
    public void eat () {
    System.out.println("son eat");
    }
    public void sleep() {
    System.out.println("zzzzzz");
    }
    public void cook() {
    //匿名内部类实现的多继承
    new Mother().cook();
    //内部类继承第二个父类来实现多继承
    Mom mom = new Mom();
    mom.cook();
    }
    private class Mom extends Mother {
    @Override
    public void cook() {
    System.out.println("mom cook");
    }
    }
    }


## 封装

封装主要是因为Java有访问权限的控制。public > protected > package = default > private。封装可以保护类中的信息，只提供想要被外界访问的信息。

类的访问范围
	
 	A、public	包内、包外，所有类中可见
	B、protected	包内所有类可见，包外有继承关系的子类可见
	(子类对象可调用)
	C、(default)表示默认，不仅本类访问，而且是同包可。
	D、private	仅在同一类中可见 

## 多态

多态一般可以分为两种，一个是重写overwrite，一个是重载override。

    重写是由于继承关系中的子类有一个和父类同名同参数的方法，会覆盖掉父类的方法。重载是因为一个同名方法可以传入多个参数组合。
    
    注意，同名方法如果参数相同，即使返回值不同也是不能同时存在的，编译会出错。
    
    从jvm实现的角度来看，重写又叫运行时多态，编译时看不出子类调用的是哪个方法，但是运行时操作数栈会先根据子类的引用去子类的类信息中查找方法，找不到的话再到父类的类信息中查找方法。

    而重载则是编译时多态，因为编译期就可以确定传入的参数组合，决定调用的具体方法是哪一个了。
    

### 向上转型和向下转型：

	public static void main(String[] args) {
        Son son = new Son();
        //首先先明确一点，转型指的是左侧引用的改变。
        //father引用类型是Father，指向Son实例，就是向上转型，既可以使用子类的方法，也可以使用父类的方法。
        //向上转型,此时运行father的方法
        Father father = son;
        father.smoke();
        //不能使用子类独有的方法。
        // father.play();编译会报错
        father.drive();
        //Son类型的引用指向Father的实例，所以是向下转型，不能使用子类非重写的方法，可以使用父类的方法。

        //向下转型，此时运行了son的方法
        Son son1 = (Son) father;
        //转型后就是一个正常的Son实例
        son1.play();
        son1.drive();
        son1.smoke();
        
        //因为向下转型之前必须先经历向上转型。
		//在向下转型过程中，分为两种情况：

		//情况一：如果父类引用的对象如果引用的是指向的子类对象，
		//那么在向下转型的过程中是安全的。也就是编译是不会出错误的。
        //因为运行期Son实例确实有这些方法
        Father f1 = new Son();
        Son s1 = (Son) f1;
        s1.smoke();
        s1.drive();
        s1.play();

        //情况二：如果父类引用的对象是父类本身，那么在向下转型的过程中是不安全的，编译不会出错，
        //但是运行时会出现java.lang.ClassCastException错误。它可以使用instanceof来避免出错此类错误。
        //因为运行期Father实例并没有这些方法。
            Father f2 = new Father();
            Son s2 = (Son) f2;
            s2.drive();
            s2.smoke();
            s2.play();

        //向下转型和向上转型的应用，有些人觉得这个操作没意义，何必先向上转型再向下转型呢，不是多此一举么。其实可以用于方法参数中的类型聚合，然后具体操作再进行分解。
        //比如add方法用List引用类型作为参数传入，传入具体类时经历了向下转型
        add(new LinkedList());
        add(new ArrayList());

        //总结
        //向上转型和向下转型都是针对引用的转型，是编译期进行的转型，根据引用类型来判断使用哪个方法
        //并且在传入方法时会自动进行转型（有需要的话）。运行期将引用指向实例，如果是不安全的转型则会报错。
        //若安全则继续执行方法。

    }
    public static void add(List list) {
        System.out.println(list);
        //在操作具体集合时又经历了向上转型
	//        ArrayList arr = (ArrayList) list;
	//        LinkedList link = (LinkedList) list;
    }

总结：
向上转型和向下转型都是针对引用的转型，是编译期进行的转型，根据引用类型来判断使用哪个方法。并且在传入方法时会自动进行转型（有需要的话）。运行期将引用指向实例，如果是不安全的转型则会报错，若安全则继续执行方法。

### 编译期的静态分派

其实就是根据引用类型来调用对应方法。


	public static void main(String[] args) {
	    Father father  = new Son();
	    静态分派 a= new 静态分派();

	    //编译期确定引用类型为Father。
	    //所以调用的是第一个方法。
	    a.play(father);
	    //向下转型后，引用类型为Son，此时调用第二个方法。
	    //所以，编译期只确定了引用，运行期再进行实例化。
	    a.play((Son)father);
	    //当没有Son引用类型的方法时，会自动向上转型调用第一个方法。
	    a.smoke(father);
	    //
    

	}
	public void smoke(Father father) {
	    System.out.println("father smoke");
	}
	public void play (Father father) {
	    System.out.println("father");
	    //father.drive();
	}
	public void play (Son son) {
	    System.out.println("son");
	    //son.drive();
	}



### 方法重载优先级匹配


	public static void main(String[] args) {
        方法重载优先级匹配 a = new 方法重载优先级匹配();
        //普通的重载一般就是同名方法不同参数。
        //这里我们来讨论当同名方法只有一个参数时的情况。
        //此时会调用char参数的方法。
        //当没有char参数的方法。会调用int类型的方法，如果没有int就调用long
        //即存在一个调用顺序char -> int -> long ->double -> ..。
        //当没有基本类型对应的方法时，先自动装箱，调用包装类方法。
        //如果没有包装类方法，则调用包装类实现的接口的方法。
        //最后再调用持有多个参数的char...方法。
        a.eat('a');
        a.eat('a','c','b');
    }
    public void eat(short i) {
        System.out.println("short");
    }
    public void eat(int i) {
        System.out.println("int");
    }
    public void eat(double i) {
        System.out.println("double");
    }
    public void eat(long i) {
        System.out.println("long");
    }
    public void eat(Character c) {
        System.out.println("Character");
    }
    public void eat(Comparable c) {
        System.out.println("Comparable");
    }
    public void eat(char ... c) {
        System.out.println(Arrays.toString(c));
        System.out.println("...");
    }

	//    public void eat(char i) {
	//        System.out.println("char");
	//    }


下一节具体介绍了基本数据类型以及常量池，具体请见：

https://blog.csdn.net/a724888/article/details/80041698





