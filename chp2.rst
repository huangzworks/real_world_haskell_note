第二章：类型和函数
*******************

什么是类型 p17
===============

在Haskell中，\ *所有的*\ 表达式和函数都有类型。

类型系统为我们提供抽象，并隐藏底层细节。


Haskell中的类型 p17-21
=========================

在Haskell中，类型是\ **强类型(strong)**\ 、\ **静态(static)**\ 和可以被自动\ **推导**\ 出的(automaticllly inferred)。

强类型
-------

一个语言的类型为强类型，表示该语言的类型系统\ *不会*\ 容忍任何类型错误。

比如用一个字符串和一个数字相加，给原本接受列表的函数传入数字，这些都是类型错误，而Haskell不会允许有这类错误的语句运行。

另一个强类型的特点是，它\ *不会*\ 对值进行任何的\ **自动转型(Coercion, conversion, casting)**\ 。

比如在很多语言中\ ``1 && True``\ 返回一个\ ``True``\ ，因为\ ``1``\ 会被自动转型为\ ``True``\ ，然后语句变成\ ``True && True``\ 。但是在Haskell中，Haskell不会将\ ``1``\ 自动转型成\ ``True``\ ，它只会报告说两个不同的类型试图进行逻辑比较，这是一个错误的表达式。

如果你需要类型转换，那你必须手动显式进行。

静态类型
----------

一个语言是静态类型的表示它的所有表达式的类型必须在编译的时候被知道，Haskell也一样，这也即是是说，Haskell编译时如果发现类型错误，就会中止编译并报错，当一个Haskell程序被成功编译时，我们可以确信该程序没有类型错误。

类型推导(type inference)
-------------------------------

Haskell编译器在绝大部分时间内可以自动推导出表达式的类型，我们也可以显式地指定每个表达式的类型，但这通常不是必须的。


Haskell的一些常用基本类型 p21
==============================

Char
-----

单字符，表示为Unicode。

Bool
------

布尔变量，包括\ ``True``\ 和\ ``False``\ 。

Int
------

原生整数类型，最大值由机器决定(通常是32bit或64bit)。

Integer
--------

不限长度的整数类型。

Double
-------

浮点数。


类型签名(type signature) p22
=============================

一般来说，Haskell可以推导出表达式的类型，但是，我们也可以用类型签名显式地指定类型。
类型签名的格式是\ ``expression :: type``\ 。

查看一个变量或函数的类型签名可以使用 ``:type``\ 语句。

.. code-block:: haskell

    Prelude> 'a' :: Char
    'a'

    Prelude> 1 :: Int
    1

    Prelude> :type 1    -- 自动推导
    1 :: Num a => a


复合数据类型：列表(list)和元组(tuple) p23
===========================================

复合数据类型既是组合使用其他类型的类型。

Haskell中最常见的复合数据类型是列表和元组。

列表和元组都可以组合数据，但它们也有一些不同，两种类型的对比如下：

=====    =======================    =========     =================
类型     可组合类型                 长度          可用函数
=====    =======================    =========     =================
列表     只能组合相同类型           长度可变      ++, :, head, ...
元组     可以组合相同或不同类型     固定长度      fst, snd
=====    =======================    =========     =================

列表 p23
--------

列表只能组合\ *相同类型*\ 的数据，它是\ *长度可变*\ 的，可以利用\ ``++``\ 等函数进行伸展或收缩，还有一大类其他常用函数可以对列表进行操作。

.. code-block:: haskell

    Prelude> [1, 2]
    [1,2]

    Prelude> [1, 2] ++ [3]
    [1,2,3]

    Prelude> 1 : [2, 3]
    [1,2,3]

    Prelude> [1 ,2] ++ "hello"  -- 列表不能组合不同类型

    <interactive>:1:5:
        No instance for (Num Char)
          arising from the literal `2'
        Possible fix: add an instance declaration for (Num Char)
        In the expression: 2
        In the first argument of `(++)', namely `[1, 2]'
        In the expression: [1, 2] ++ "hello"

元组 p24
---------

\ **元组(tuple)**\ 可以组合\ *不同类型*\ 的数据，它是\ *定长的(长度不变)*\ ，所以也没有像列表那样的对元组进行伸缩处理的函数。

因为元组的以上性质，所以它们通常只单纯用于保存数据，如果需要处理数据，一般使用列表。

.. code-block:: haskell

    Prelude> (1, "hello", 'c')  -- 储存不同类型数据
    (1,"hello",'c')

    Prelude> (1, 2, 3)  -- 也可以储存相同类型的数据
    (1,2,3)

    Prelude> (1, 2, 3) ++ (4)   -- 不可以用列表的处理函数

    <interactive>:1:1:
        Couldn't match expected type `[a0]' with actual type `(t0, t1, t2)'
        In the first argument of `(++)', namely `(1, 2, 3)'
        In the expression: (1, 2, 3) ++ (4)
        In an equation for `it': it = (1, 2, 3) ++ (4)

通常用n-tuple表示不同长度的元组，比如1-tuple表示只有一个元素的元组，而2-tuple表示有两个元素的元组，以此类推。。。

在Haskell中，没有1-tuple，假如你输入\ ``(1)``\ ，那你至获得一个数字值\ ``1``\ 。

.. code-block:: haskell

    Prelude> (1)
    1

    Prelude> :type it
    it :: Integer

    Prelude> (1, 2)
    (1,2)

    Prelude> :type it
    it :: (Integer, Integer)

2-tuple比较特殊，作用在它们之上有两个函数：\ ``fst``\ 和\ ``snd``\ ，它们分别获取元组的头元素和第二元素。

.. warning:: 如果你熟悉Lisp，注意这里的\ ``fst``\ 、\ ``snd``\ 函数和Lisp里面的\ ``car``\ 和\ ``cdr``\ 是不同的，Lisp里的\ ``car``\ 和\ ``cdr``\ 可以作用于任何长度的列表，而Haskell里的\ ``fst``\ 和\ ``snd``\ 只能作用于2-tuple。

.. code-block:: haskell

    Prelude> let greet = ("hello", "huangz")

    Prelude> fst greet
    "hello"

    Prelude> snd greet
    "huangz"

    Prelude> fst (1, 2, "morning")  -- fst和snd只能对2-tuple使用

    <interactive>:1:5:
        Couldn't match expected type `(a0, b0)'
        with actual type `(t0, t1, t2)'
        In the first argument of `fst', namely `(1, 2, "morning")'
        In the expression: fst (1, 2, "morning")
        In an equation for `it': it = fst (1, 2, "morning")

另一方面，如果你熟悉Python，你可能想当然地认为元组的函数和列表的函数是通用的，就像Python里的列表和元组一样。

而实际上，Haskell里的列表和元组的函数\ *不是*\ 通用的。

.. code-block:: haskell

    Prelude> head [1, 2, 3] -- head获取列表头元素
    1

    Prelude> head (1, 2, 3)

    <interactive>:1:6:
        Couldn't match expected type `[a0]' with actual type `(t0, t1, t2)'
        In the first argument of `head', namely `(1, 2, 3)'
        In the expression: head (1, 2, 3)
        In an equation for `it': it = head (1, 2, 3)


多态 p23-25, p36-38
====================

其实对于列表(还有Haskell里面的其他东西)来说，还有一个很有用的地方我们已经使用了但是没有注意到，就是函数里面的\ **多态(polymorphic)**\ 。

比如对于一个列表来说，无论它里面储存的是什么类型的值，我们都可以用\ ``head``\ 取出它的数据：

.. code-block:: haskell

    Prelude> head [1..10]   -- 数值列表
    1

    Prelude> head ["good", "morning"]   -- 字符串列表
    "good"

    Prelude> head "sphinx"  -- 字符串(单字符列表)
    's'

对各种类型的列表，\ ``head``\ 函数都可以返回正确的值。

我们可以试试用\ ``:type``\ 打开\ ``head``\ 的类型签名，看看里面有什么：

.. code-block:: haskell

    Prelude> :type head
    head :: [a] -> a

在看看\ ``++``\ 操作符(它要用括号包裹起来)：

.. code-block:: haskell

    Prelude> :type (++)
    (++) :: [a] -> [a] -> [a]

我们发现两个函数里面的签名都有\ ``a``\ ，但是如果我们查看一个字符串(String)类型专用的函数\ ``words``\ ，则有不一样的发现：

.. code-block:: haskell

    Prelude> :type words
    words :: String -> [String]

和列表不一样的是，\ ``words``\ 的函数签名里没有\ ``a``\ ，只有\ ``String``\ 。

\ ``head``\ 函数、\ ``++``\ 函数和\ ``words``\ 函数有什么不同？

答案是\ ``head``\ 和\ ``++``\ 是多态的，而\ ``words``\ 不是——也即是说，\ ``words``\ \ *只能*\ 处理字符串类型，而\ ``head``\ 和\ ``++``\ 不在乎列表内储存的是什么类型，它只要求传入的参数是一个列表即可。

仔细观察\ ``head``\ 函数的定义(\ ``++``\ 也是类似的)：

.. code-block:: haskell

    Prelude> :type head
    head :: [a] -> a

这里\ ``a``\ 是一个\ **类型变量(type variable)**\ ，它可以是任何类型，就像数学里的代数一样：给它一个字符串类型的列表，它就可以处理\ ``String``\ 类型，给它一个整数值类型的列表，它就可以处理\ ``Int``\ 类型，诸如此类。

整条类型签名的意思就是：\ ``head``\ 函数接受一个\ ``a``\ 类型的列表(\ ``[a]``\ )，然后返回一个\ ``a``\ ，其中\ *返回值的类型和之前列表里面保存的元素的类型一致*\ ，但是它不要求\ ``a``\ 是什么类型，它不在乎。

另一方面，看看\ ``words``\ 函数：

.. code-block:: haskell
    
    Prelude> :type words
    words :: String -> [String]

这里它的签名意思是：\ ``words``\ 接受一个\ ``String``\ 类型值，然后返回一个\ ``String``\ 类型的列表(\ ``[String]``\ )。

这个\ ``String``\ 是一个\ **类型名**\ ，而不是一个类型变量，它指定了\ ``words``\ 函数\ *只能*\ 接受\ ``String``\ 类型的值，所以它不是多态的。

.. note:: 这也说明了，为什么类型名只能以大写字母开头，因为它必须和类型变量区别开来。


编写简单函数，并载入它 p27
===========================

我们可以编写一个函数，然后载入到GHC当中使用：

.. literalinclude:: source/chp2/add.hs

.. note:: 在函数定义中，我们并没有像很多语言那样使用\ ``return``\ 返回函数的值，因为Haskell中，函数是一簇\ **表达式(expression)**\ ，而不是一条条\ **语句(statement)**\ ，表达式的值就是函数的值。

然后用\ ``:load``\ 载入：

::

    Prelude> :load add.hs
    [1 of 1] Compiling Main             ( add.hs, interpreted )
    Ok, modules loaded: Main.

    *Main> add 2 3
    5

.. note:: GHC中的语句和Haskell有部分是不同的，如果你在GHCI中输入\ ``add a b = a + b``\ ，GHCI会返回一个错误。

变量 p28-29
-------------

在Haskell中(很多其他函数式编程语言也是类似)，变量是\ *不可以*\ 被重复赋值的，也即是，将一个\ **变量名(variable name)**\ 和一个表达式(可以是一个值、一个函数或其他什么东西)绑定之后，这个变量名总是代表这个表达式，而不会指向另外一些别的东西。

我们编写一个重复定义某个变量值的程序：

.. literalinclude:: source/chp2/assign.hs

然后尝试载入Haskell里运行：

::

    Prelude> :load assign
    [1 of 1] Compiling Main             ( assign.hs, interpreted )

    assign.hs:6:1:
    Multiple declarations of `Main.luckly_number'
    Declared at: assign.hs:3:1
    assign.hs:6:1
    Failed, modules loaded: none.

条件求值 p29-32
-----------------

Haskell中\ ``if``\ 语句的格式如下：

::

    if -- predicate
    then -- expression if predicate is True
    else -- expression is predicate is False

其中\ ``then``\ 和\ ``else``\ 之后的表达式称之为\ **分支(branch)**\ ，分支的类型\ *必须相同*\ ，否则编译器会报错。

换个角度来说，因为Haskell中每个表达式都有一个值，而函数的值也是一个表达式，所以一个函数不应该返回不同的两种值。

::

    Prelude> if True then 1+1 else 4
    2

    Prelude> if True then 1+1 else "oops~~~"

    <interactive>:1:16:
        No instance for (Num [Char])
        arising from the literal `1'
        Possible fix: add an instance declaration for (Num [Char])
        In the second argument of `(+)', namely `1'
        In the expression: 1 + 1
        In the expression: if True then 1 + 1 else "oops~~~"

另一方面，当我们使用命令式语言时，通常可以省略\ ``else``\ ，因为在这些语言中\ ``else``\ 是一个语句。

但在Haskell中，因为它是一个表达式，所以我们也\ *不能*\ 省略\ ``else``\ 表达式。

::

    Prelude> if True then 1+1

    <interactive>:1:17: parse error (possibly incorrect indentation)

我们写一个与列表函数\ ``drop``\ 一样的函数\ ``myDrop``\ 作为演示：

.. literalinclude:: source/chp2/myDrop.hs

如果你愿意，也可以将\ ``myDrop``\ 写成一行

.. literalinclude:: source/chp2/myDropInOneLine.hs


惰性求值 p32-36
==================

通常语言有两种求值方式，一种是\ **严格求值(strict evaluation)**\ ，另一种是\ **非严格求值(nonstrict evaluation)**\ 。

Haskell使用非严格求值，也称\ **惰性求值(lazy evaluation)**\ 。
