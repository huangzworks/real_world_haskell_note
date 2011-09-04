第三章：类型定义、流和函数
****************************

定义新类型 p41-43
===================

定义一个类型需要几个部分：

1.类型名(type name, type constructor)
2.值构造器(value constructor, data constructor)
3.组成元素(components)

举一个例子，一个书籍类型的定义可能是这样的：

.. literalinclude:: source/chp3/BookStore.hs

其中\ ``data``\ 关键字之后的\ ``BookInfo``\ 是类型名，\ ``Book``\ 是值构造器，而之后的语句则是组成元素。

你可能会奇怪为什么类型名的作用和值构造器的作用似乎类似，其实是不一样的，类型名用于类型的定义，而值构造器负责生成该类型的值。

如果你熟悉面向对象编程的话，你可以将类型名比作类名(比如一个Python中的类\ ``Queue``\ )，而将值构造器看作对象生成器(比如Python中的\ ``__init__``\ )。

::

    Prelude> :load BookStore
    [1 of 1] Compiling Main             ( BookStore.hs, interpreted )
    Ok, modules loaded: Main.

    *Main> :type Book   -- 查看值构造器所使用的参数
    Book :: Int -> String -> [String] -> BookInfo

    *Main> let sicp = Book 123123 "SICP" ["ha", "gjs"]  -- 用值构造器(Book)生成值
    *Main> sicp
    ok 123123 "SICP" ["ha","gjs"]

    *Main> :type sicp   -- 值的类型是BookInfo
    sicp :: BookInfo

    *Main> :info BookInfo   -- 用:info查看BookInfo类型的详细信息
    data BookInfo = Book Int String [String]
        -- Defined at BookStore.hs:3:6-13
    instance Show BookInfo -- Defined at BookStore.hs:4:27-30

那么，类型名和值构造器是否可以使用相同的名字？
答案是可以，而且这种用法非常常见。

.. literalinclude:: source/chp3/AnotherBookStore.hs

运行：

::

    Prelude> :load AnotherBookStore
    [1 of 1] Compiling Main             ( AnotherBookStore.hs, interpreted )
    Ok, modules loaded: Main.

    *Main> let tij = Book 245 "Thinking in Java" ["Bruce Eckel"]
    *Main> tij
    Book 245 "Thinking in Java" ["Bruce Eckel"]

    *Main> :type tij
    tij :: Book

    *Main> :info Book
    data Book = Book Int String [String]
        -- Defined at AnotherBookStore.hs:3:6-9
    instance Show Book -- Defined at AnotherBookStore.hs:4:23-26


别名
=====

我们可以用\ ``type``\ 关键字给一个已有的类型一个\ **别名(synonyms)**\ ，主要为了增强程序的可读性。

比如我们可以用特定的名字替换之前的\ ``BookInfo``\ 类型的组成元素的名字。

.. literalinclude:: source/chp3/BookStore_version_2.hs

运行：

::

    *Main> :load BookStore_version_2
    [1 of 1] Compiling Main             ( BookStore_version_2.hs, interpreted )
    Ok, modules loaded: Main.

    *Main> :info BookInfo
    data BookInfo = Book Id Title Authors
        -- Defined at BookStore_version_2.hs:7:6-13
    instance Show BookInfo -- Defined at BookStore_version_2.hs:8:27-30

