第三章：类型定义、流和函数
****************************

定义新类型 p41-43
===================

定义一个类型需要几个部分：

- 类型名(type name, type constructor)
- 值构造器(value constructor, data constructor)
- 组成元素(components)

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


别名 p43-44
=============

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


代数数据类型 p44-49
=====================

\ **代数数据类型(Algebraic Data Type)**\ 就是可以拥有\ *多个*\ 值构造器的类型。

比如下面的\ ``Roygbiv``\ 类型就是一个代数数据类型：

.. literalinclude:: source/chp3/Roygbiv.hs


模式匹配 p50-54
=================

Haskell允许我们将函数组织成一系列方程(equation)等式，然后使用该函数的时候，对比每个方程直到找到匹配(相等)的方程，然后执行方程内的表达式，这一机制称之为\ **模式匹配(pattern match)**\ 。

比如要写一个我们自己的\ ``not``\ 操作符，可以这样写：

.. literalinclude:: source/chp3/myNot.hs

假如我们执行\ ``myNot False``\ 的话，Haskell就会对比第一个方程，然后发现不匹配，于是对比第二个方程，然后匹配成功，于是执行第二个方程内的表达式，也即是，返回\ ``True``\ 。

还有一个更直观的例子，我们可以写一个函数\ ``checkIt``\ 比对输入数值，对\ ``0``\ 和\ ``1``\ 输出\ ``good``\ ，其他数值输出\ ``bad``\ ：

不过问题是整数值的范围很大，我们不可能一个个地写匹配：

::

    checkIt 0 = "good"
    checkIt 1 = "good"
    checkIt 2 = "bad"
    checkIt 3 = "bad"
    checkIt 4 = "bad"
    -- 很多很多。。。

这时你需要一个\ **Wild Card Pattrn**\ 来搭救你，它可以作为模式匹配的通用匹配(相当于\ ``else``\ )，所有和Wild Card Pattrn对比的模式都会匹配。

Wild Card Pattrn需要你使用一个\ ``_``\ 作为匹配符，使用它，我们上面的\ ``checkIt``\ 函数可以这样写：

.. literalinclude:: source/chp3/checkIt.hs

运行：

::

    *Main> :load checkIt
    [1 of 1] Compiling Main             ( checkIt.hs, interpreted )
    Ok, modules loaded: Main.

    *Main> checkIt 0
    "good"

    *Main> checkIt 3
    "bad"

