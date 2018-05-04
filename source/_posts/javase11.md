---
title: Java基础11：Java泛型详解
date: 2018-04-29 20:13:10
tags:
    - Java基础
categories:
	- 后端
	- Java
---
本文对java的泛型的概念和使用做了详尽的介绍。


具体代码在我的GitHub中可以找到
> https://github.com/h2pl/MyTech

喜欢的话麻烦点下星哈

文章首发于我的个人博客：
> https://h2pl.github.io/2018/04/29/javase11

更多关于Java后端学习的内容请到我的CSDN博客上查看：
> https://blog.csdn.net/a724888

<!-- more -->

本文参考https://blog.csdn.net/s10461/article/details/53941091

## 泛型概述

泛型在java中有很重要的地位，在面向对象编程及各种设计模式中有非常广泛的应用。

什么是泛型？为什么要使用泛型？

> 泛型，即“参数化类型”。一提到参数，最熟悉的就是定义方法时有形参，然后调用此方法时传递实参。那么参数化类型怎么理解呢？顾名思义，就是将类型由原来的具体的类型参数化，类似于方法中的变量参数，此时类型也定义成参数形式（可以称之为类型形参），然后在使用/调用时传入具体的类型（类型实参）。
> 
> 泛型的本质是为了参数化类型（在不创建新的类型的情况下，通过泛型指定的不同类型来控制形参具体限制的类型）。也就是说在泛型使用过程中，操作的数据类型被指定为一个参数，这种参数类型可以用在类、接口和方法中，分别被称为泛型类、泛型接口、泛型方法。

## 一个栗子

一个被举了无数次的例子：

    List arrayList = new ArrayList();
    arrayList.add("aaaa");
    arrayList.add(100);
    
    for(int i = 0; i< arrayList.size();i++){
        String item = (String)arrayList.get(i);
        Log.d("泛型测试","item = " + item);
    }

毫无疑问，程序的运行结果会以崩溃结束：

java.lang.ClassCastException: java.lang.Integer cannot be cast to java.lang.String

ArrayList可以存放任意类型，例子中添加了一个String类型，添加了一个Integer类型，再使用时都以String的方式使用，因此程序崩溃了。为了解决类似这样的问题（在编译阶段就可以解决），泛型应运而生。

我们将第一行声明初始化list的代码更改一下，编译器会在编译阶段就能够帮我们发现类似这样的问题。

List<String> arrayList = new ArrayList<String>();
...
//arrayList.add(100); 在编译阶段，编译器就会报错

## 特性

泛型只在编译阶段有效。看下面的代码：

    List<String> stringArrayList = new ArrayList<String>();
    List<Integer> integerArrayList = new ArrayList<Integer>();
    
    Class classStringArrayList = stringArrayList.getClass();
    Class classIntegerArrayList = integerArrayList.getClass();
    
    if(classStringArrayList.equals(classIntegerArrayList)){
        Log.d("泛型测试","类型相同");
    }


> 通过上面的例子可以证明，在编译之后程序会采取去泛型化的措施。也就是说Java中的泛型，只在编译阶段有效。在编译过程中，正确检验泛型结果后，会将泛型的相关信息擦出，并且在对象进入和离开方法的边界处添加类型检查和类型转换的方法。也就是说，泛型信息不会进入到运行时阶段。
> 
对此总结成一句话：泛型类型在逻辑上看以看成是多个不同的类型，实际上都是相同的基本类型。



泛型有三种使用方式，分别为：泛型类、泛型接口、泛型方法

## 泛型类

> 泛型类型用于类的定义中，被称为泛型类。通过泛型可以完成对一组类的操作对外开放相同的接口。最典型的就是各种容器类，如：List、Set、Map。
> 
> 泛型类的最基本写法（这么看可能会有点晕，会在下面的例子中详解）：

    class 类名称 <泛型标识：可以随便写任意标识号，标识指定的泛型的类型>{
      private 泛型标识 /*（成员变量类型）*/ var; 
      .....
    
      }

一个最普通的泛型类：

//此处T可以随便写为任意标识，常见的如T、E、K、V等形式的参数常用于表示泛型

    //在实例化泛型类时，必须指定T的具体类型
    public class Generic<T>{
        //在类中声明的泛型整个类里面都可以用，除了静态部分，因为泛型是实例化时声明的。
        //静态区域的代码在编译时就已经确定，只与类相关
        class A <E>{
            T t;
        }
        //类里面的方法或类中再次声明同名泛型是允许的，并且该泛型会覆盖掉父类的同名泛型T
        class B <T>{
            T t;
        }
        //静态内部类也可以使用泛型，实例化时赋予泛型实际类型
        static class C <T> {
            T t;
        }
        public static void main(String[] args) {
            //报错，不能使用T泛型，因为泛型T属于实例不属于类
    //        T t = null;
        }
    
        //key这个成员变量的类型为T,T的类型由外部指定
        private T key;
    
        public Generic(T key) { //泛型构造方法形参key的类型也为T，T的类型由外部指定
            this.key = key;
        }
    
        public T getKey(){ //泛型方法getKey的返回值类型为T，T的类型由外部指定
            return key;
        }
    }

> 12-27 09:20:04.432 13063-13063/? D/泛型测试: key is 123456

> 12-27 09:20:04.432 13063-13063/? D/泛型测试: key is key_vlaue

> 定义的泛型类，就一定要传入泛型类型实参么？并不是这样，在使用泛型的时候如果传入泛型实参，则会根据传入的泛型实参做相应的限制，此时泛型才会起到本应起到的限制作用。如果不传入泛型类型实参的话，在泛型类中使用泛型的方法或成员变量定义的类型可以为任何的类型。

看一个例子：

    Generic generic = new Generic("111111");
    Generic generic1 = new Generic(4444);
    Generic generic2 = new Generic(55.55);
    Generic generic3 = new Generic(false);
    
    Log.d("泛型测试","key is " + generic.getKey());
    Log.d("泛型测试","key is " + generic1.getKey());
    Log.d("泛型测试","key is " + generic2.getKey());
    Log.d("泛型测试","key is " + generic3.getKey());

    D/泛型测试: key is 111111
    D/泛型测试: key is 4444
    D/泛型测试: key is 55.55
    D/泛型测试: key is false

注意：
泛型的类型参数只能是类类型，不能是简单类型。
不能对确切的泛型类型使用instanceof操作。如下面的操作是非法的，编译时会出错。
        if(ex_num instanceof Generic<Number>){   
        } 

## 泛型接口

泛型接口与泛型类的定义及使用基本相同。泛型接口常被用在各种类的生产器中，可以看一个例子：

    //定义一个泛型接口
    public interface Generator<T> {
        public T next();
    }

当实现泛型接口的类，未传入泛型实参时：

    /**
     * 未传入泛型实参时，与泛型类的定义相同，在声明类的时候，需将泛型的声明也一起加到类中
     * 即：class FruitGenerator<T> implements Generator<T>{
     * 如果不声明泛型，如：class FruitGenerator implements Generator<T>，编译器会报错："Unknown class"
     */
    class FruitGenerator<T> implements Generator<T>{
        @Override
        public T next() {
            return null;
        }
    }

当实现泛型接口的类，传入泛型实参时：

    /**
     * 传入泛型实参时：
     * 定义一个生产器实现这个接口,虽然我们只创建了一个泛型接口Generator<T>
     * 但是我们可以为T传入无数个实参，形成无数种类型的Generator接口。
     * 在实现类实现泛型接口时，如已将泛型类型传入实参类型，则所有使用泛型的地方都要替换成传入的实参类型
     * 即：Generator<T>，public T next();中的的T都要替换成传入的String类型。
     */
    public class FruitGenerator implements Generator<String> {
    
        private String[] fruits = new String[]{"Apple", "Banana", "Pear"};
    
        @Override
        public String next() {
            Random rand = new Random();
            return fruits[rand.nextInt(3)];
        }
    }

## 泛型通配符

我们知道Ingeter是Number的一个子类，同时在特性章节中我们也验证过Generic<Ingeter>与Generic<Number>实际上是相同的一种基本类型。那么问题来了，在使用Generic<Number>作为形参的方法中，能否使用Generic<Ingeter>的实例传入呢？在逻辑上类似于Generic<Number>和Generic<Ingeter>是否可以看成具有父子关系的泛型类型呢？

为了弄清楚这个问题，我们使用Generic<T>这个泛型类继续看下面的例子：

    public void showKeyValue1(Generic<Number> obj){
        Log.d("泛型测试","key value is " + obj.getKey());
    }

    Generic<Integer> gInteger = new Generic<Integer>(123);
    Generic<Number> gNumber = new Generic<Number>(456);
    
    showKeyValue(gNumber);
    
    // showKeyValue这个方法编译器会为我们报错：Generic<java.lang.Integer> 
    // cannot be applied to Generic<java.lang.Number>
    // showKeyValue(gInteger);

通过提示信息我们可以看到Generic<Integer>不能被看作为`Generic<Number>的子类。由此可以看出:同一种泛型可以对应多个版本（因为参数类型是不确定的），不同版本的泛型类实例是不兼容的。

回到上面的例子，如何解决上面的问题？总不能为了定义一个新的方法来处理Generic<Integer>类型的类，这显然与java中的多台理念相违背。因此我们需要一个在逻辑上可以表示同时是Generic<Integer>和Generic<Number>父类的引用类型。由此类型通配符应运而生。

我们可以将上面的方法改一下：

    public void showKeyValue1(Generic<?> obj){
        Log.d("泛型测试","key value is " + obj.getKey());

类型通配符一般是使用？代替具体的类型实参，注意， 此处的？和Number、String、Integer一样都是一种实际的类型，可以把？看成所有类型的父类。是一种真实的类型。

可以解决当具体类型不确定的时候，这个通配符就是 ?  ；当操作类型时，不需要使用类型的具体功能时，只使用Object类中的功能。那么可以用 ? 通配符来表未知类型

public void showKeyValue(Generic<Number> obj){
        System.out.println(obj);
    }

    Generic<Integer> gInteger = new Generic<Integer>(123);
    Generic<Number> gNumber = new Generic<Number>(456);

    public void test () {
    //        showKeyValue(gInteger);该方法会报错
        showKeyValue1(gInteger);
    }

    public void showKeyValue1(Generic<?> obj) {
        System.out.println(obj);
    }
    // showKeyValue这个方法编译器会为我们报错：Generic<java.lang.Integer>
    // cannot be applied to Generic<java.lang.Number>
    // showKeyValue(gInteger);
。

## 泛型方法

在java中,泛型类的定义非常简单，但是泛型方法就比较复杂了。

尤其是我们见到的大多数泛型类中的成员方法也都使用了泛型，有的甚至泛型类中也包含着泛型方法，这样在初学者中非常容易将泛型方法理解错了。
泛型类，是在实例化类的时候指明泛型的具体类型；泛型方法，是在调用方法的时候指明泛型的具体类型 。

    /**
     * 泛型方法的基本介绍
     * @param tClass 传入的泛型实参
     * @return T 返回值为T类型
     * 说明：
     *     1）public 与 返回值中间<T>非常重要，可以理解为声明此方法为泛型方法。
     *     2）只有声明了<T>的方法才是泛型方法，泛型类中的使用了泛型的成员方法并不是泛型方法。
     *     3）<T>表明该方法将使用泛型类型T，此时才可以在方法中使用泛型类型T。
     *     4）与泛型类的定义一样，此处T可以随便写为任意标识，常见的如T、E、K、V等形式的参数常用于表示泛型。
     */
        public <T> T genericMethod(Class<T> tClass)throws InstantiationException ,
          IllegalAccessException{
                T instance = tClass.newInstance();
                return instance;
        }

    Object obj = genericMethod(Class.forName("com.test.test"));

## 泛型方法的基本用法

光看上面的例子有的同学可能依然会非常迷糊，我们再通过一个例子，把我泛型方法再总结一下。

    /** 
     * 这才是一个真正的泛型方法。
     * 首先在public与返回值之间的<T>必不可少，这表明这是一个泛型方法，并且声明了一个泛型T
     * 这个T可以出现在这个泛型方法的任意位置.
     * 泛型的数量也可以为任意多个 
     *    如：public <T,K> K showKeyName(Generic<T> container){
     *        ...
     *        }
     */

        public class 泛型方法 {
        @Test
        public void test() {
            test1();
            test2(new Integer(2));
            test3(new int[3],new Object());
    
            //打印结果
    //        null
    //        2
    //        [I@3d8c7aca
    //        java.lang.Object@5ebec15
        }
        //该方法使用泛型T
        public <T> void test1() {
            T t = null;
            System.out.println(t);
        }
        //该方法使用泛型T
        //并且参数和返回值都是T类型
        public <T> T test2(T t) {
            System.out.println(t);
            return t;
        }
    
        //该方法使用泛型T,E
        //参数包括T,E
        public <T, E> void test3(T t, E e) {
            System.out.println(t);
            System.out.println(e);
        }
    }

    

## 类中的泛型方法

当然这并不是泛型方法的全部，泛型方法可以出现杂任何地方和任何场景中使用。但是有一种情况是非常特殊的，当泛型方法出现在泛型类中时，我们再通过一个例子看一下

    //注意泛型类先写类名再写泛型，泛型方法先写泛型再写方法名
    //类中声明的泛型在成员和方法中可用
    class A <T, E>{
        {
            T t1 ;
        }
        A (T t){
            this.t = t;
        }
        T t;

        public void test1() {
            System.out.println(this.t);
        }

        public void test2(T t,E e) {
            System.out.println(t);
            System.out.println(e);
        }
    }
    @Test
    public void run () {
        A <Integer,String > a = new A<>(1);
        a.test1();
        a.test2(2,"ds");
    //        1
    //        2
    //        ds
    }

    static class B <T>{
        T t;
        public void go () {
            System.out.println(t);
        }
    }

## 泛型方法与可变参数

再看一个泛型方法和可变参数的例子：

    public class 泛型和可变参数 {
        @Test
        public void test () {
            printMsg("dasd",1,"dasd",2.0,false);
            print("dasdas","dasdas", "aa");
        }
        //普通可变参数只能适配一种类型
        public void print(String ... args) {
            for(String t : args){
                System.out.println(t);
            }
        }
        //泛型的可变参数可以匹配所有类型的参数。。有点无敌
        public <T> void printMsg( T... args){
            for(T t : args){
                System.out.println(t);
            }
        }
            //打印结果：
        //dasd
        //1
        //dasd
        //2.0
        //false
    
    }
    

## 静态方法与泛型

静态方法有一种情况需要注意一下，那就是在类中的静态方法使用泛型：静态方法无法访问类上定义的泛型；如果静态方法操作的引用数据类型不确定的时候，必须要将泛型定义在方法上。

即：如果静态方法要使用泛型的话，必须将静态方法也定义成泛型方法 。

    public class StaticGenerator<T> {
        ....
        ....
        /**
         * 如果在类中定义使用泛型的静态方法，需要添加额外的泛型声明（将这个方法定义成泛型方法）
         * 即使静态方法要使用泛型类中已经声明过的泛型也不可以。
         * 如：public static void show(T t){..},此时编译器会提示错误信息：
              "StaticGenerator cannot be refrenced from static context"
         */
        public static <T> void show(T t){
    
        }
    }

## 泛型方法总结

泛型方法能使方法独立于类而产生变化，以下是一个基本的指导原则：

无论何时，如果你能做到，你就该尽量使用泛型方法。也就是说，如果使用泛型方法将整个类泛型化，那么就应该使用泛型方法。另外对于一个static的方法而已，无法访问泛型类型的参数。所以如果static方法要使用泛型能力，就必须使其成为泛型方法。
## 泛型上下边界

在使用泛型的时候，我们还可以为传入的泛型类型实参进行上下边界的限制，如：类型实参只准传入某种类型的父类或某种类型的子类。

为泛型添加上边界，即传入的类型实参必须是指定类型的子类型

    public class 泛型通配符与边界 {
        public void showKeyValue(Generic<Number> obj){
            System.out.println("key value is " + obj.getKey());
        }
        @Test
        public void main() {
            Generic<Integer> gInteger = new Generic<Integer>(123);
            Generic<Number> gNumber = new Generic<Number>(456);
            showKeyValue(gNumber);
            //泛型中的子类也无法作为父类引用传入
    //        showKeyValue(gInteger);
        }
        //直接使用？通配符可以接受任何类型作为泛型传入
        public void showKeyValueYeah(Generic<?> obj) {
            System.out.println(obj);
        }
        //只能传入number的子类或者number
        public void showKeyValue1(Generic<? extends Number> obj){
            System.out.println(obj);
        }
    
        //只能传入Integer的父类或者Integer
        public void showKeyValue2(Generic<? super Integer> obj){
            System.out.println(obj);
        }
    
        @Test
        public void testup () {
            //这一行代码编译器会提示错误，因为String类型并不是Number类型的子类
            //showKeyValue1(generic1);
            Generic<String> generic1 = new Generic<String>("11111");
            Generic<Integer> generic2 = new Generic<Integer>(2222);
            Generic<Float> generic3 = new Generic<Float>(2.4f);
            Generic<Double> generic4 = new Generic<Double>(2.56);
    
            showKeyValue1(generic2);
            showKeyValue1(generic3);
            showKeyValue1(generic4);
        }
    
        @Test
        public void testdown () {
    
            Generic<String> generic1 = new Generic<String>("11111");
            Generic<Integer> generic2 = new Generic<Integer>(2222);
            Generic<Number> generic3 = new Generic<Number>(2);
    //        showKeyValue2(generic1);本行报错，因为String并不是Integer的父类
            showKeyValue2(generic2);
            showKeyValue2(generic3);
        }
    }

== 关于泛型数组要提一下 ==

看到了很多文章中都会提起泛型数组，经过查看sun的说明文档，在java中是”不能创建一个确切的泛型类型的数组”的。

    也就是说下面的这个例子是不可以的：
    
    List<String>[] ls = new ArrayList<String>[10];  
    
    而使用通配符创建泛型数组是可以的，如下面这个例子：
    
    List<?>[] ls = new ArrayList<?>[10];  
    
    这样也是可以的：
    
    List<String>[] ls = new ArrayList[10];

下面使用Sun的一篇文档的一个例子来说明这个问题：

    List<String>[] lsa = new List<String>[10]; // Not really allowed.    
    Object o = lsa;    
    Object[] oa = (Object[]) o;    
    List<Integer> li = new ArrayList<Integer>();    
    li.add(new Integer(3));    
    oa[1] = li; // Unsound, but passes run time store check    
    String s = lsa[1].get(0); // Run-time error: ClassCastException.

> 这种情况下，由于JVM泛型的擦除机制，在运行时JVM是不知道泛型信息的，所以可以给oa[1]赋上一个ArrayList而不会出现异常，但是在取出数据的时候却要做一次类型转换，所以就会出现ClassCastException，如果可以进行泛型数组的声明，上面说的这种情况在编译期将不会出现任何的警告和错误，只有在运行时才会出错。
> 
> 而对泛型数组的声明进行限制，对于这样的情况，可以在编译期提示代码有类型安全问题，比没有任何提示要强很多。
> 下面采用通配符的方式是被允许的:数组的类型不可以是类型变量，除非是采用通配符的方式，因为对于通配符的方式，最后取出数据是要做显式的类型转换的。

    List<?>[] lsa = new List<?>[10]; // OK, array of unbounded wildcard type.    
    Object o = lsa;    
    Object[] oa = (Object[]) o;    
    List<Integer> li = new ArrayList<Integer>();    
    li.add(new Integer(3));    
    oa[1] = li; // Correct.    
    Integer i = (Integer) lsa[1].get(0); // OK 

最后

本文中的例子主要是为了阐述泛型中的一些思想而简单举出的，并不一定有着实际的可用性。另外，一提到泛型，相信大家用到最多的就是在集合中，其实，在实际的编程过程中，自己可以使用泛型去简化开发，且能很好的保证代码质量。