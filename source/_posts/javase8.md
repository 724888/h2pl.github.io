---
title: Java基础8：深入理解内部类
date: 2018-04-25 22:47:39
tags:
    - Java基础系列
categories:
	- 后端
	- Java
---
本文主要介绍了Java内部类的基本原理，使用方法和各种细节。

有关内部类实现回调，事件驱动和委托机制的文章将在后面发布。

具体代码在我的GitHub中可以找到

https://github.com/h2pl/MyTech

喜欢的话麻烦点下星哈

文章首发于我的个人博客：

https://h2pl.github.io/2018/04/25/javase8

更多关于Java后端学习的内容请到我的CSDN博客上查看：

https://blog.csdn.net/a724888
<!-- more -->

## 内部类初探

一、什么是内部类？

　　内部类是指在一个外部类的内部再定义一个类。内部类作为外部类的一个成员，并且依附于外部类而存在的。内部类可为静态，可用protected和private修饰（而外部类只能使用public和缺省的包访问权限）。内部类主要有以下几类：成员内部类、局部内部类、静态内部类、匿名内部类

二、内部类的共性
> (1)内部类仍然是一个独立的类，在编译之后内部类会被编译成独立的.class文件，但是前面冠以外部类的类名和$符号 。
> 
> (2)内部类不能用普通的方式访问。
> 
> (3)内部类声明成静态的，就不能随便的访问外部类的成员变量了，此时内部类只能访问外部类的静态成员变量 。
> 
> (4)外部类不能直接访问内部类的的成员，但可以通过内部类对象来访问

 

　　内部类是外部类的一个成员，因此内部类可以自由地访问外部类的成员变量，无论是否是private的。

　　因为当某个外围类的对象创建内部类的对象时，此内部类会捕获一个隐式引用，它引用了实例化该内部对象的外围类对象。通过这个指针，可以访问外围类对象的全部状态。

通过反编译内部类的字节码，分析之后主要是通过以下几步做到的： 
> 　　1 编译器自动为内部类添加一个成员变量， 这个成员变量的类型和外部类的类型相同， 这个成员变量就是指向外部类对象的引用； 

> 　　2 编译器自动为内部类的构造方法添加一个参数， 参数的类型是外部类的类型， 在构造方法内部使用这个参数为1中添加的成员变量赋值；

> 　　3 在调用内部类的构造函数初始化内部类对象时， 会默认传入外部类的引用。

二、使用内部类的好处：

> 静态内部类的作用：

>1 只是为了降低包的深度，方便类的使用，静态内部类适用于包含类当中，但又不依赖与外在的类。
> 
>2 由于Java规定静态内部类不能用使用外在类的非静态属性和方法，所以只是为了方便管理类结构而定义。于是我们在创建静态内部类的时候，不需要外部类对象的引用。

> 非静态内部类的作用：

>1 内部类继承自某个类或实现某个接口，内部类的代码操作创建其他外围类的对象。所以你可以认为内部类提供了某种进入其外围类的窗口。
> 
>2 使用内部类最吸引人的原因是:每个内部类都能独立地继承自一个(接口的)实现，所以无论外围类是否已经继承了某个(接口的)实现，对于内部类都没有影响

>3 如果没有内部类提供的可以继承多个具体的或抽象的类的能力，一些设计与编程问题就很难解决。
>  从这个角度看，内部类使得多重继承的解决方案变得完整。接口解决了部分问题，而内部类有效地实现了"多重继承"。


三、
那静态内部类与普通内部类有什么区别呢？问得好，区别如下：
> （1）静态内部类不持有外部类的引用
> 在普通内部类中，我们可以直接访问外部类的属性、方法，即使是private类型也可以访问，这是因为内部类持有一个外部类的引用，可以自由访问。而静态内部类，则只可以访问外部类的静态方法和静态属性（如果是private权限也能访问，这是由其代码位置所决定的），其他则不能访问。
> 
> （2）静态内部类不依赖外部类
> 普通内部类与外部类之间是相互依赖的关系，内部类实例不能脱离外部类实例，也就是说它们会同生同死，一起声明，一起被垃圾回收器回收。而静态内部类是可以独立存在的，即使外部类消亡了，静态内部类还是可以存在的。
> 
> （3）普通内部类不能声明static的方法和变量
> 普通内部类不能声明static的方法和变量，注意这里说的是变量，常量（也就是final static修饰的属性）还是可以的，而静态内部类形似外部类，没有任何限制。

==为什么普通内部类不能有静态变量呢？==

>1 成员内部类 之所以叫做成员 就是说他是类实例的一部分 而不是类的一部分 

>2 结构上来说 他和你声明的成员变量是一样的地位 一个特殊的成员变量 而静态的变量是类的一部分和实例无关

>3 你若声明一个成员内部类 让他成为主类的实例一部分 然后又想在内部类声明和实例无关的静态的东西 你让JVM情何以堪啊
 
>4 若想在内部类内声明静态字段 就必须将其内部类本身声明为静态 

非静态内部类有一个很大的优点：可以自由使用外部类的所有变量和方法

下面的例子大概地介绍了

1 非静态内部类和静态内部类的区别。

2 不同访问权限的内部类的使用。

3 外部类和它的内部类之间的关系


    //本节讨论内部类以及不同访问权限的控制
    //内部类只有在使用时才会被加载。
    //外部类B
    public class B{
        int i = 1;
        int j = 1;
        static int s = 1;
        static int ss = 1;
        A a;
        AA aa;
        AAA aaa;
        //内部类A
    
        public class A {
    //        static void go () {
    //
    //        }
    //        static {
    //
    //        }
    //      static int b = 1;//非静态内部类不能有静态成员变量和静态代码块和静态方法，
            // 因为内部类在外部类加载时并不会被加载和初始化。
            //所以不会进行静态代码的调用
            int i = 2;//外部类无法读取内部类的成员，而内部类可以直接访问外部类成员
    
            public void test() {
                System.out.println(j);
                j = 2;
                System.out.println(j);
                System.out.println(s);//可以访问类的静态成员变量
            }
            public void test2() {
                AA aa = new AA();
                AAA aaa = new AAA();
            }
    
        }
        //静态内部类S，可以被外部访问
        public static class S {
            int i = 1;//访问不到非静态变量。
            static int s = 0;//可以有静态变量
    
            public static void main(String[] args) {
                System.out.println(s);
            }
            @Test
            public void test () {
    //            System.out.println(j);//报错，静态内部类不能读取外部类的非静态变量
                System.out.println(s);
                System.out.println(ss);
                s = 2;
                ss = 2;
                System.out.println(s);
                System.out.println(ss);
            }
        }
    
        //内部类AA，其实这里加protected相当于default
        //因为外部类要调用内部类只能通过B。并且无法直接继承AA，所以必须在同包
        //的类中才能调用到(这里不考虑静态内部类)，那么就和default一样了。
        protected class AA{
            int i = 2;//内部类之间不共享变量
            public void test (){
                A a = new A();
                AAA aaa = new AAA();
                //内部类之间可以互相访问。
            }
        }
        //包外部依然无法访问，因为包没有继承关系，所以找不到这个类
        protected static class SS{
            int i = 2;//内部类之间不共享变量
            public void test (){
    
                //内部类之间可以互相访问。
            }
        }
        //私有内部类A，对外不可见，但对内部类和父类可见
        private class AAA {
            int i = 2;//内部类之间不共享变量
    
            public void test() {
                A a = new A();
                AA aa = new AA();
                //内部类之间可以互相访问。
            }
        }
        @Test
        public void test(){
            A a = new A();
            a.test();
            //内部类可以修改外部类的成员变量
            //打印出 1 2
            B b = new B();
    
        }
    }
    
    
    //另一个外部类
    class C {
        @Test
        public void test() {
            //首先，其他类内部类只能通过外部类来获取其实例。
            B.S s = new B.S();
            //静态内部类可以直接通过B类直接获取，不需要B的实例，和静态成员变量类似。
            //B.A a = new B.A();
            //当A不是静态类时这行代码会报错。
            //需要使用B的实例来获取A的实例
            B b = new B();
            B.A a = b.new A();
            B.AA aa = b.new AA();//B和C同包，所以可以访问到AA
    //      B.AAA aaa = b.new AAA();AAA为私有内部类，外部类不可见
            //当A使用private修饰时，使用B的实例也无法获取A的实例，这一点和私有变量是一样的。
            //所有普通的内部类与类中的一个变量是类似的。静态内部类则与静态成员类似。
        }
    }
  
## 内部类的加载
可能刚才的例子中没办法直观地看到内部类是如何加载的，接下来用例子展示一下内部类加载的过程。


> 1  内部类是延时加载的，也就是说只会在第一次使用时加载。不使用就不加载，所以可以很好的实现单例模式。
> 
>2 不论是静态内部类还是非静态内部类都是在第一次使用时才会被加载。
> 
>3 对于非静态内部类是不能出现静态模块（包含静态块，静态属性，静态方法等）
> 
>4 非静态类的使用需要依赖于外部类的对象，详见上述对象innerClass 的初始化。


简单来说，类的加载都是发生在类要被用到的时候。内部类也是一样

> 1 普通内部类在第一次用到时加载，并且每次实例化时都会执行内部成员变量的初始化，以及代码块和构造方法。

> 2 静态内部类也是在第一次用到时被加载。但是当它加载完以后就会将静态成员变量初始化，运行静态代码块，并且只执行一次。当然，非静态成员和代码块每次实例化时也会执行。

总结一下Java类代码加载的顺序，万变不离其宗。

> 规律一、初始化构造时，先父后子；只有在父类所有都构造完后子类才被初始化
> 
> 规律二、类加载先是静态、后非静态、最后是构造函数。
> 
> 静态构造块、静态类属性按出现在类定义里面的先后顺序初始化，同理非静态的也是一样的，只是静态的只在加载字节码时执行一次，不管你new多少次，非静态会在new多少次就执行多少次
> 
> 规律三、java中的类只有在被用到的时候才会被加载
> 
> 规律四、java类只有在类字节码被加载后才可以被构造成对象实例


## 成员内部类
在方法中定义的内部类称为局部内部类。与局部变量类似，局部内部类不能有访问说明符，因为它不是外围类的一部分，但是它可以访问当前代码块内的常量，和此外围类所有的成员。

需要注意的是：
局部内部类只能在定义该内部类的方法内实例化，不可以在此方法外对其实例化。

    public class 局部内部类 {
        class A {//局部内部类就是写在方法里的类，只在方法执行时加载，一次性使用。
            public void test() {
                class B {
                    public void test () {
                        class C {
    
                        }
                    }
                }
            }
        }
        @Test
        public void test () {
            int i = 1;
            final int j = 2;
            class A {
                @Test
                public void test () {
                    System.out.println(i);
                    System.out.println(j);
                }
            }
            A a = new A();
            System.out.println(a);
        }
    
        static class B {
            public static void test () {
                //static class A报错，方法里不能定义静态内部类。
                //因为只有在方法调用时才能进行类加载和初始化。
    
            }
        }
    }

## 匿名内部类

简单地说：匿名内部类就是没有名字的内部类，并且，匿名内部类是局部内部类的一种特殊形式。什么情况下需要使用匿名内部类？如果满足下面的一些条件，使用匿名内部类是比较合适的：
只用到类的一个实例。
类在定义后马上用到。
类非常小（SUN推荐是在4行代码以下）
给类命名并不会导致你的代码更容易被理解。
在使用匿名内部类时，要记住以下几个原则：

>1 　匿名内部类不能有构造方法。
> 
>2 　匿名内部类不能定义任何静态成员、方法和类。
> 
>3 　匿名内部类不能是public,protected,private,static。
> 
>4 　只能创建匿名内部类的一个实例。
> 
>5   一个匿名内部类一定是在new的后面，用其隐含实现一个接口或实现一个类。
>
>6 　因匿名内部类为局部内部类，所以局部内部类的所有限制都对其生效。

一个匿名内部类的例子：

        public class 匿名内部类 {
    
    }
    interface D{
        void run ();
    }
    abstract class E{
        E (){
    
        }
        abstract void work();
    }
    class A {
    
            @Test
            public void test (int k) {
                //利用接口写出一个实现该接口的类的实例。
                //有且仅有一个实例，这个类无法重用。
                new Runnable() {
                    @Override
                    public void run() {
    //                    k = 1;报错，当外部方法中的局部变量在内部类使用中必须改为final类型。
                        //因为方外部法中即使改变了这个变量也不会反映到内部类中。
                        //所以对于内部类来讲这只是一个常量。
                        System.out.println(100);
                        System.out.println(k);
                    }
                };
                new D(){
                    //实现接口的匿名类
                    int i =1;
                    @Override
                    public void run() {
                        System.out.println("run");
                        System.out.println(i);
                        System.out.println(k);
                    }
                }.run();
                new E(){
                    //继承抽象类的匿名类
                    int i = 1;
                    void run (int j) {
                        j = 1;
                    }
    
                    @Override
                    void work() {
    
                    }
                };
            }
    
    }
        
## 匿名内部类里的final
使用的形参为何要为final

参考文件：http://android.blog.51cto.com/268543/384844

> 我们给匿名内部类传递参数的时候，若该形参在内部类中需要被使用，那么该形参必须要为final。也就是说：当所在的方法的形参需要被内部类里面使用时，该形参必须为final。
> 
> 为什么必须要为final呢？
> 
> 首先我们知道在内部类编译成功后，它会产生一个class文件，该class文件与外部类并不是同一class文件，仅仅只保留对外部类的引用。当外部类传入的参数需要被内部类调用时，从java程序的角度来看是直接被调用：
> 
> 
    public class OuterClass {
        public void display(final String name,String age){
            class InnerClass{
                void display(){
                    System.out.println(name);
                }
            }
        }
    }

从上面代码中看好像name参数应该是被内部类直接调用？其实不然，在java编译之后实际的操作如下：


    public class OuterClass$InnerClass {
        public InnerClass(String name,String age){
            this.InnerClass$name = name;
            this.InnerClass$age = age;
        }
        
        
        public void display(){
            System.out.println(this.InnerClass$name + "----" + this.InnerClass$age );
        }
    }

  所以从上面代码来看，内部类并不是直接调用方法传递的参数，而是利用自身的构造器对传入的参数进行备份，自己内部方法调用的实际上时自己的属性而不是外部方法传递进来的参数。

>   直到这里还没有解释为什么是final

> 在内部类中的属性和外部方法的参数两者从外表上看是同一个东西，但实际上却不是，所以他们两者是可以任意变化的，也就是说在内部类中我对属性的改变并不会影响到外部的形参，而然这从程序员的角度来看这是不可行的。
> 
> 毕竟站在程序的角度来看这两个根本就是同一个，如果内部类该变了，而外部方法的形参却没有改变这是难以理解和不可接受的，所以为了保持参数的一致性，就规定使用final来避免形参的不改变。

  简单理解就是，拷贝引用，为了避免引用值发生改变，例如被外部类的方法修改等，而导致内部类得到的值不一致，于是用final来让该引用不可改变。

  故如果定义了一个匿名内部类，并且希望它使用一个其外部定义的参数，那么编译器会要求该参数引用是final的。
  
## 内部类初始化

我们一般都是利用构造器来完成某个实例的初始化工作的，但是匿名内部类是没有构造器的！那怎么来初始化匿名内部类呢？使用构造代码块！利用构造代码块能够达到为匿名内部类创建一个构造器的效果。

    public class OutClass {
        public InnerClass getInnerClass(final int age,final String name){
            return new InnerClass() {
                int age_ ;
                String name_;
                //构造代码块完成初始化工作
                {
                    if(0 < age && age < 200){
                        age_ = age;
                        name_ = name;
                    }
                }
                public String getName() {
                    return name_;
                }
                
                public int getAge() {
                    return age_;
                }
            };
        }
        
        
## 内部类的重载

 
　　如果你创建了一个内部类，然后继承其外围类并重新定义此内部类时，会发生什么呢？也就是说，内部类可以被重载吗？这看起来似乎是个很有用的点子，但是“重载”内部类就好像它是外围类的一个方法，其实并不起什么作用：
 

    class Egg {
           private Yolk y;
     
           protected class Yolk {
                  public Yolk() {
                         System.out.println("Egg.Yolk()");
                  }
           }
     
           public Egg() {
                  System.out.println("New Egg()");
                  y = new Yolk();
           }
    }
     
    public class BigEgg extends Egg {
           public class Yolk {
                  public Yolk() {
                         System.out.println("BigEgg.Yolk()");
                  }
           }
     
           public static void main(String[] args) {
                  new BigEgg();
           }
    }
    复制代码
    输出结果为：
    New Egg()
    Egg.Yolk()
 
缺省的构造器是编译器自动生成的，这里是调用基类的缺省构造器。你可能认为既然创建了BigEgg 的对象，那么所使用的应该是被“重载”过的Yolk，但你可以从输出中看到实际情况并不是这样的。
这个例子说明，当你继承了某个外围类的时候，内部类并没有发生什么特别神奇的变化。这两个内部类是完全独立的两个实体，各自在自己的命名空间内。

## 内部类的继承

因为内部类的构造器要用到其外围类对象的引用，所以在你继承一个内部类的时候，事情变得有点复杂。问题在于，那个“秘密的”外围类对象的引用必须被初始化，而在被继承的类中并不存在要联接的缺省对象。要解决这个问题，需使用专门的语法来明确说清它们之间的关联：

    class WithInner {
            class Inner {
                    Inner(){
                            System.out.println("this is a constructor in WithInner.Inner");
                    };
            }
    }
     
    public class InheritInner extends WithInner.Inner {
            // ! InheritInner() {} // Won't compile
            InheritInner(WithInner wi) {
                    wi.super();
                    System.out.println("this is a constructor in InheritInner");
            }
     
            public static void main(String[] args) {
                    WithInner wi = new WithInner();
                    InheritInner ii = new InheritInner(wi);
            }
    }

输出结果为：
this is a constructor in WithInner.Inner
this is a constructor in InheritInner
 
可以看到，InheritInner 只继承自内部类，而不是外围类。但是当要生成一个构造器时，缺省的构造器并不算好，而且你不能只是传递一个指向外围类对象的引用。此外，你必须在构造器内使用如下语法：
enclosingClassReference.super();
这样才提供了必要的引用，然后程序才能编译通过。

有关匿名内部类实现回调，事件驱动，委托等机制的文章将在下一节讲述。