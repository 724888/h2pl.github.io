---
title: Java基础2：基本数据类型与常量池
date: 2018-04-23 11:05:07
tags:
	- Java基础
categories:
	- 后端
	- Java
---

本节主要介绍基本数据类型的大小，自动拆箱装箱，基本数据类型的存储方式，以及常量池的原理。

具体代码在我的GitHub中可以找到
> https://github.com/h2pl/MyTech

喜欢的话麻烦点下星哈

文章首发于我的个人博客：
> https://h2pl.github.io/2018/04/23/javase2

更多关于Java后端学习的内容请到我的CSDN博客上查看：

https://blog.csdn.net/a724888
<!-- more -->

## 基本数据类型的大小

    int 32位 4字节  
    short 16位
    float 32位
    double 64位
    long 64位
    char 16位
    byte 8位
    boolean 1位
    自动拆箱和装箱的意思就是，计算数值时，integer会自动转为int进行计算。
    而当int传入类型为integer的引用时，int数值又会被包装为integer。


```
//8位
byte bx = Byte.MAX_VALUE;
byte bn = Byte.MIN_VALUE;
//16位
short sx = Short.MAX_VALUE;
short sn = Short.MIN_VALUE;
//32位
int ix = Integer.MAX_VALUE;
int in = Integer.MIN_VALUE;
//64位
long lx = Long.MAX_VALUE;
long ln = Long.MIN_VALUE;
//32位
float fx = Float.MAX_VALUE;
float fn = Float.MIN_VALUE;
//64位
double dx = Double.MAX_VALUE;
double dn = Double.MIN_VALUE;
//16位
char cx = Character.MAX_VALUE;
char cn = Character.MIN_VALUE;
//1位
boolean bt = Boolean.TRUE;
boolean bf = Boolean.FALSE;
```


## 自动拆箱和装箱

    //基本数据类型的常量池是-128到127之间。
    // 在这个范围中的基本数据类的包装类可以自动拆箱，比较时直接比较数值大小。
    public static void main(String[] args) {
        //int的自动拆箱和装箱只在-128到127范围中进行，超过该范围的两个integer的 == 判断是会返回false的。
        Integer a1 = 128;
        Integer a2 = -128;
        Integer a3 = -128;
        Integer a4 = 128;
        System.out.println(a1 == a4);
        System.out.println(a2 == a3);

        Byte b1 = 127;
        Byte b2 = 127;
        Byte b3 = -128;
        Byte b4 = -128;
        //byte都是相等的，因为范围就在-128到127之间
        System.out.println(b1 == b2);
        System.out.println(b3 == b4);

        //
        Long c1 = 128L;
        Long c2 = 128L;
        Long c3 = -128L;
        Long c4 = -128L;
        System.out.println(c1 == c2);
        System.out.println(c3 == c4);

        //char没有负值
        //发现char也是在0到127之间自动拆箱
        Character d1 = 128;
        Character d2 = 128;
        Character d3 = 127;
        Character d4 = 127;
        System.out.println(d1 == d2);
        System.out.println(d3 == d4);


        Integer i = 10;
        Byte b = 10;
        //比较Byte和Integer.两个对象无法直接比较，报错
        //System.out.println(i == b);
        System.out.println("i == b " + i.equals(b));
        //答案是false,因为包装类的比较时先比较是否是同一个类，不是的话直接返回false.
        int ii = 128;
        short ss = 128;
        long ll = 128;
        char cc = 128;
        System.out.println("ii == bb " + (ii == ss));
        System.out.println("ii == ll " + (ii == ll));
        System.out.println("ii == cc " + (ii == cc));
        //这时候都是true，因为基本数据类型直接比较值，值一样就可以。
        
总结：注意基本数据类型的拆箱装箱，以及对常量池的理解。


## 基本数据类型的存储方式
    上面自动拆箱和装箱的原理其实与常量池有关。
    3.1存在栈中：
    public void(int a)
    {
    int i = 1;
    int j = 1;
    }
    方法中的i 存在虚拟机栈的局部变量表里，i是一个引用，j也是一个引用，它们都指向局部变量表里的整型值 1.
    int a是传值引用，所以a也会存在局部变量表。
    
    3.2存在堆里：
    class A{
    int i = 1;
    A a = new A();
    }
    i是类的成员变量。类实例化的对象存在堆中，所以成员变量也存在堆中，引用a存的是对象的地址，引用i存的是值，这个值1也会存在堆中。可以理解为引用i指向了这个值1。也可以理解为i就是1.
    
    3.3包装类对象怎么存
    其实我们说的常量池也可以叫对象池。
    比如String a= new String("a").intern()时会先在常量池找是否有“a"对象如果有的话直接返回“a"对象在常量池的地址，即让引用a指向常量”a"对象的内存地址。
    public native String intern();
    Integer也是同理。

下图是Integer类型在常量池中查找同值对象的方法。

    public static Integer valueOf(int i) {
        if (i >= IntegerCache.low && i <= IntegerCache.high)
            return IntegerCache.cache[i + (-IntegerCache.low)];
        return new Integer(i);
    }
    private static class IntegerCache {
        static final int low = -128;
        static final int high;
        static final Integer cache[];
    
        static {
            // high value may be configured by property
            int h = 127;
            String integerCacheHighPropValue =
                sun.misc.VM.getSavedProperty("java.lang.Integer.IntegerCache.high");
            if (integerCacheHighPropValue != null) {
                try {
                    int i = parseInt(integerCacheHighPropValue);
                    i = Math.max(i, 127);
                    // Maximum array size is Integer.MAX_VALUE
                    h = Math.min(i, Integer.MAX_VALUE - (-low) -1);
                } catch( NumberFormatException nfe) {
                    // If the property cannot be parsed into an int, ignore it.
                }
            }
            high = h;
    
            cache = new Integer[(high - low) + 1];
            int j = low;
            for(int k = 0; k < cache.length; k++)
                cache[k] = new Integer(j++);
    
            // range [-128, 127] must be interned (JLS7 5.1.7)
            assert IntegerCache.high >= 127;
        }
    
        private IntegerCache() {}
    }
所以基本数据类型的包装类型可以在常量池查找对应值的对象，找不到就会自动在常量池创建该值的对象。

而String类型可以通过intern来完成这个操作。

JDK1.7后，常量池被放入到堆空间中，这导致intern()函数的功能不同，具体怎么个不同法，且看看下面代码，这个例子是网上流传较广的一个例子，分析图也是直接粘贴过来的，这里我会用自己的理解去解释这个例子：


```
[java] view plain copy
String s = new String("1");  
s.intern();  
String s2 = "1";  
System.out.println(s == s2);  
  
String s3 = new String("1") + new String("1");  
s3.intern();  
String s4 = "11";  
System.out.println(s3 == s4);  
输出结果为：

[java] view plain copy
JDK1.6以及以下：false false  
JDK1.7以及以上：false true
```

![image](https://img-blog.csdn.net/20180422231916788?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2E3MjQ4ODg=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70)

![image](https://img-blog.csdn.net/20180422231929413?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2E3MjQ4ODg=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70)
JDK1.6查找到常量池存在相同值的对象时会直接返回该对象的地址。

JDK 1.7后，intern方法还是会先去查询常量池中是否有已经存在，如果存在，则返回常量池中的引用，这一点与之前没有区别，区别在于，如果在常量池找不到对应的字符串，则不会再将字符串拷贝到常量池，而只是在常量池中生成一个对原字符串的引用。

那么其他字符串在常量池找值时就会返回另一个堆中对象的地址。



下一节详细介绍String以及相关包装类。

具体请见：https://blog.csdn.net/a724888/article/details/80042298

关于Java面向对象三大特性，请参考：

https://blog.csdn.net/a724888/article/details/80033043

