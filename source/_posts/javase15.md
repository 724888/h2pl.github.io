---
title: Java基础15：深入剖析Java枚举类
date: 2018-05-02 21:04:04
tags:
    - Java基础
categories:
	- 后端
	- Java
---
本文介绍了枚举类的基本概念，使用方法，以及底层实现原理。帮助你更好地使用枚举类并且理解枚举类的内部实现细节。

具体代码在我的GitHub中可以找到
> https://github.com/h2pl/MyTech

喜欢的话麻烦点一下星哈谢谢。

文章首发于我的个人博客：
> https://h2pl.github.io/2018/05/02/javase15

更多关于Java后端学习的内容请到我的CSDN博客上查看：
> https://blog.csdn.net/a724888

<!-- more -->

枚举（enum）类型是Java 5新增的特性，它是一种新的类型，允许用常量来表示特定的数据片断，而且全部都以类型安全的形式来表示。
 
 ## 初探枚举类
 
>  在程序设计中，有时会用到由若干个有限数据元素组成的集合，如一周内的星期一到星期日七个数据元素组成的集合，由三种颜色红、黄、绿组成的集合，一个工作班组内十个职工组成的集合等等，程序中某个变量取值仅限于集合中的元素。此时，可将这些数据集合定义为枚举类型。
 
> 因此，枚举类型是某类数据可能取值的集合，如一周内星期可能取值的集合为：
> 　　{ Sun,Mon,Tue,Wed,Thu,Fri,Sat}
> 　　该集合可定义为描述星期的枚举类型，该枚举类型共有七个元素，因而用枚举类型定义的枚举变量只能取集合中的某一元素值。由于枚举类型是导出数据类型，因此，必须先定义枚举类型，然后再用枚举类型定义枚举型变量。
> 　

    enum <枚举类型名> 
    　　{ <枚举元素表> };
    　　
    　　其中：关键词enum表示定义的是枚举类型，枚举类型名由标识符组成，而枚举元素表由枚举元素或枚举常量组成。例如： 
    　　
    enum weekdays 
    　　{ Sun,Mon,Tue,Wed,Thu,Fri,Sat };
    　　定义了一个名为 weekdays的枚举类型，它包含七个元素：Sun、Mon、Tue、Wed、Thu、Fri、Sat。
    　　
> 在编译器编译程序时，给枚举类型中的每一个元素指定一个整型常量值(也称为序号值)。若枚举类型定义中没有指定元素的整型常量值，则整型常量值从0开始依次递增，因此，weekdays枚举类型的七个元素Sun、Mon、Tue、Wed、Thu、Fri、Sat对应的整型常量值分别为0、1、2、3、4、5、6。
> 　　注意：在定义枚举类型时，也可指定元素对应的整型常量值。

    例如，描述逻辑值集合{TRUE、FALSE}的枚举类型boolean可定义如下：
    enum boolean 
    　　{ TRUE=1 ,FALSE=0 };
    该定义规定：TRUE的值为1，而FALSE的值为0。
    　　
    而描述颜色集合{red,blue,green,black,white,yellow}的枚举类型colors可定义如下：
    enum colors 
    　　{red=5,blue=1,green,black,white,yellow};
    　　该定义规定red为5 ，blue为1，其后元素值从2 开始递增加1。green、black、white、yellow的值依次为2、3、4、5。
    　　
　　此时，整数5将用于表示二种颜色red与yellow。通常两个不同元素取相同的整数值是没有意义的。枚举类型的定义只是定义了一个新的数据类型，只有用枚举类型定义枚举变量才能使用这种数据类型。 
 
 ## 枚举类-语法

> enum 与 class、interface 具有相同地位；
> 可以继承多个接口；
> 可以拥有构造器、成员方法、成员变量；
> 1.2 枚举类与普通类不同之处
> 
> 默认继承 java.lang.Enum 类，所以不能继承其他父类；其中 java.lang.Enum 类实现了 java.lang.Serializable 和 java.lang.Comparable 接口；

> 使用 enum 定义，默认使用 final 修饰，因此不能派生子类；

> 构造器默认使用 private 修饰，且只能使用 private 修饰；

> 枚举类所有实例必须在第一行给出，默认添加 public static final 修饰，否则无法产生实例；

## 枚举类的具体使用
这部分内容参考https://blog.csdn.net/qq_27093465/article/details/52180865
### 常量
    
    public class 常量 {
    }
    enum Color {
        Red, Green, Blue, Yellow
    }

### switch

JDK1.6之前的switch语句只支持int,char,enum类型，使用枚举，能让我们的代码可读性更强。

    public static void showColor(Color color) {
            switch (color) {
                case Red:
                    System.out.println(color);
                    break;
                case Blue:
                    System.out.println(color);
                    break;
                case Yellow:
                    System.out.println(color);
                    break;
                case Green:
                    System.out.println(color);
                    break;
            }
        }
        
### 向枚举中添加新方法

如果打算自定义自己的方法，那么必须在enum实例序列的最后添加一个分号。而且 Java 要求必须先定义 enum 实例。

    enum Color {
        //每个颜色都是枚举类的一个实例，并且构造方法要和枚举类的格式相符合。
        //如果实例后面有其他内容，实例序列结束时要加分号。
        Red("红色", 1), Green("绿色", 2), Blue("蓝色", 3), Yellow("黄色", 4);
        String name;
        int index;
        Color(String name, int index) {
            this.name = name;
            this.index = index;
        }
        public void showAllColors() {
            //values是Color实例的数组，在通过index和name可以获取对应的值。
            for (Color color : Color.values()) {
                System.out.println(color.index + ":" + color.name);
            }
        }
    }

### 覆盖枚举的方法
所有枚举类都继承自Enum类，所以可以重写该类的方法
下面给出一个toString()方法覆盖的例子。 

    @Override
    public String toString() {
        return this.index + ":" + this.name;
    }

### 实现接口

所有的枚举都继承自java.lang.Enum类。由于Java 不支持多继承，所以枚举对象不能再继承其他类。

    enum Color implements Print{
        @Override
        public void print() {
            System.out.println(this.name);
        }
    }
    
### 使用接口组织枚举  

 搞个实现接口，来组织枚举，简单讲，就是分类吧。如果大量使用枚举的话，这么干，在写代码的时候，就很方便调用啦。  
     
    public class 用接口组织枚举 {
        public static void main(String[] args) {
            Food cf = chineseFood.dumpling;
            Food jf = Food.JapaneseFood.fishpiece;
            for (Food food : chineseFood.values()) {
                System.out.println(food);
            }
            for (Food food : Food.JapaneseFood.values()) {
                System.out.println(food);
            }
        }
    }
    interface Food {
        enum JapaneseFood implements Food {
            suse, fishpiece
        }
    }
    enum chineseFood implements Food {
        dumpling, tofu
    }
     
### 枚举类集合

java.util.EnumSet和java.util.EnumMap是两个枚举集合。EnumSet保证集合中的元素不重复；EnumMap中的 key是enum类型，而value则可以是任意类型。

EnumSet在JDK中没有找到实现类，这里写一个EnumMap的例子
    
    public class 枚举类集合 {
        public static void main(String[] args) {
            EnumMap<Color, String> map = new EnumMap<Color, String>(Color.class);
            map.put(Color.Blue, "Blue");
            map.put(Color.Yellow, "Yellow");
            map.put(Color.Red, "Red");
            System.out.println(map.get(Color.Red));
        }
    }
    
## 使用枚举类的注意事项
![image](https://img-blog.csdn.net/20170112172420090)

枚举类型对象之间的值比较，是可以使用==，直接来比较值，是否相等的，不是必须使用equals方法的哟。

因为枚举类Enum已经重写了equals方法

    /**
     * Returns true if the specified object is equal to this
     * enum constant.
     *
     * @param other the object to be compared for equality with this object.
     * @return  true if the specified object is equal to this
     *          enum constant.
     */
    public final boolean equals(Object other) {
        return this==other;
    }
    
## 枚举类的底层原理

这部分参考https://blog.csdn.net/mhmyqn/article/details/48087247

> Java从JDK1.5开始支持枚举，也就是说，Java一开始是不支持枚举的，就像泛型一样，都是JDK1.5才加入的新特性。通常一个特性如果在一开始没有提供，在语言发展后期才添加，会遇到一个问题，就是向后兼容性的问题。
> 
> 像Java在1.5中引入的很多特性，为了向后兼容，编译器会帮我们写的源代码做很多事情，比如泛型为什么会擦除类型，为什么会生成桥接方法，foreach迭代，自动装箱/拆箱等，这有个术语叫“语法糖”，而编译器的特殊处理叫“解语法糖”。那么像枚举也是在JDK1.5中才引入的，又是怎么实现的呢？

> Java在1.5中添加了java.lang.Enum抽象类，它是所有枚举类型基类。提供了一些基础属性和基础方法。同时，对把枚举用作Set和Map也提供了支持，即java.util.EnumSet和java.util.EnumMap。

接下来定义一个简单的枚举类

    public enum Day {
        MONDAY {
            @Override
            void say() {
                System.out.println("MONDAY");
            }
        }
        , TUESDAY {
            @Override
            void say() {
                System.out.println("TUESDAY");
            }
        }, FRIDAY("work"){
            @Override
            void say() {
                System.out.println("FRIDAY");
            }
        }, SUNDAY("free"){
            @Override
            void say() {
                System.out.println("SUNDAY");
            }
        };
        String work;
        //没有构造参数时，每个实例可以看做常量。
        //使用构造参数时，每个实例都会变得不一样，可以看做不同的类型，所以编译后会生成实例个数对应的class。
        private Day(String work) {
            this.work = work;
        }
        private Day() {
    
        }
        //枚举实例必须实现枚举类中的抽象方法
        abstract void say ();
    
    }
    
反编译结果

    D:\MyTech\out\production\MyTech\com\javase\枚举类>javap Day.class
    Compiled from "Day.java"
    
    public abstract class com.javase.枚举类.Day extends java.lang.Enum<com.javase.枚举类.Day> {
      public static final com.javase.枚举类.Day MONDAY;
      public static final com.javase.枚举类.Day TUESDAY;
      public static final com.javase.枚举类.Day FRIDAY;
      public static final com.javase.枚举类.Day SUNDAY;
      java.lang.String work;
      public static com.javase.枚举类.Day[] values();
      public static com.javase.枚举类.Day valueOf(java.lang.String);
      abstract void say();
      com.javase.枚举类.Day(java.lang.String, int, com.javase.枚举类.Day$1);
      com.javase.枚举类.Day(java.lang.String, int, java.lang.String, com.javase.枚举类.Day$1);
      static {};
    }
    
> 可以看到，一个枚举在经过编译器编译过后，变成了一个抽象类，它继承了java.lang.Enum；而枚举中定义的枚举常量，变成了相应的public static final属性，而且其类型就抽象类的类型，名字就是枚举常量的名字.
> 
> 同时我们可以在Operator.class的相同路径下看到四个内部类的.class文件com/mikan/Day$1.class、com/mikan/Day$2.class、com/mikan/Day$3.class、com/mikan/Day$4.class，也就是说这四个命名字段分别使用了内部类来实现的；同时添加了两个方法values()和valueOf(String)；我们定义的构造方法本来只有一个参数，但却变成了三个参数；同时还生成了一个静态代码块。这些具体的内容接下来仔细看看。

下面分析一下字节码中的各部分，其中：

    InnerClasses:
         static #23; //class com/javase/枚举类/Day$4
         static #18; //class com/javase/枚举类/Day$3
         static #14; //class com/javase/枚举类/Day$2
         static #10; //class com/javase/枚举类/Day$1
         
从中可以看到它有4个内部类，这四个内部类的详细信息后面会分析。

    static {};
        descriptor: ()V
        flags: ACC_STATIC
        Code:
          stack=5, locals=0, args_size=0
             0: new           #10                 // class com/javase/枚举类/Day$1
             3: dup
             4: ldc           #11                 // String MONDAY
             6: iconst_0
             7: invokespecial #12                 // Method com/javase/枚举类/Day$1."<init>":(Ljava/lang/String;I)V
            10: putstatic     #13                 // Field MONDAY:Lcom/javase/枚举类/Day;
            13: new           #14                 // class com/javase/枚举类/Day$2
            16: dup
            17: ldc           #15                 // String TUESDAY
            19: iconst_1
            20: invokespecial #16                 // Method com/javase/枚举类/Day$2."<init>":(Ljava/lang/String;I)V
            //后面类似，这里省略
    }
    
其实编译器生成的这个静态代码块做了如下工作：分别设置生成的四个公共静态常量字段的值，同时编译器还生成了一个静态字段$VALUES，保存的是枚举类型定义的所有枚举常量
编译器添加的values方法：

    public static com.javase.Day[] values();  
      flags: ACC_PUBLIC, ACC_STATIC  
      Code:  
        stack=1, locals=0, args_size=0  
           0: getstatic     #2                  // Field $VALUES:[Lcom/javase/Day;  
           3: invokevirtual #3                  // Method "[Lcom/mikan/Day;".clone:()Ljava/lang/Object;  
           6: checkcast     #4                  // class "[Lcom/javase/Day;"  
           9: areturn  
    这个方法是一个公共的静态方法，所以我们可以直接调用该方法（Day.values()）,返回这个枚举值的数组，另外，这个方法的实现是，克隆在静态代码块中初始化的$VALUES字段的值，并把类型强转成Day[]类型返回。
    
造方法为什么增加了两个参数？


有一个问题，构造方法我们明明只定义了一个参数，为什么生成的构造方法是三个参数呢？

    从Enum类中我们可以看到，为每个枚举都定义了两个属性，name和ordinal，name表示我们定义的枚举常量的名称，如FRIDAY、TUESDAY，而ordinal是一个顺序号，根据定义的顺序分别赋予一个整形值，从0开始。在枚举常量初始化时，会自动为初始化这两个字段，设置相应的值，所以才在构造方法中添加了两个参数。即：
    
    另外三个枚举常量生成的内部类基本上差不多，这里就不重复说明了。
    
> 我们可以从Enum类的代码中看到，定义的name和ordinal属性都是final的，而且大部分方法也都是final的，特别是clone、readObject、writeObject这三个方法，这三个方法和枚举通过静态代码块来进行初始化一起。

> 它保证了枚举类型的不可变性，不能通过克隆，不能通过序列化和反序列化来复制枚举，这能保证一个枚举常量只是一个实例，即是单例的，所以在effective java中推荐使用枚举来实现单例。

## 总结

枚举本质上是通过普通的类来实现的，只是编译器为我们进行了处理。**每个枚举类型都继承自java.lang.Enum，并自动添加了values和valueOf方法。**

而每个枚举常量是一个静态常量字段，**使用内部类实现**，该内部类继承了枚举类。**所有枚举常量都通过静态代码块来进行初始化，即在类加载期间就初始化**。

另外通过把clone、readObject、writeObject这三个方法定义为final的，同时实现是抛出相应的异常。这样保证了每个枚举类型及枚举常量都是不可变的。**可以利用枚举的这两个特性来实现线程安全的单例。**

