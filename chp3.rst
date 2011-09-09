第三章：类型定义、流和函数
****************************

定义新类型 p41-43
===================

定义一个类型需要几个部分：

1. 类型名(type name, type constructor)
2. 值构造器(value constructor, data constructor)
3. 组成元素(components)

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


结构 p51-p4
==============

之前我们说可以构造一个新类型，比如:

::

    data BookInfo = Book Int String [String]
                    deriving (Show)

创建一个新数据项可以调用类似语句\ ``Book ... ... ...``\ ，用值构造器\ ``Book``\ 组合各个成分，生成新的值，称之为\ **构造(construction)**\ 。

反过来想，我们也希望可以有一种方法，可以重新获取值里面的各个成分。

用模式匹配可以做到这一点：

::

    bookId (Book id title authors) = id
    bookTitle (Book id title authors) = title
    bookAuthors (Book id title authors) = authors

举个例子，当我们执行\ ``bookId (Book 123 "a book" ["author_A, "author_B"]``\ ，模式匹配将各个成分一一比对：将\ ``123``\ 放入\ ``id``\ 项，将\ ``a book``\ 放入\ ``title``\ ，将\ ``["author_A", "author_B"]``\ 放入\ ``authors``\ ，然后抽取出\ ``bookId``\ 所需要的部分——\ ``id``\ ，并将其返回，于是我们就取得了值的\ ``id``\ 成分，这一过程称之为\ **分解(deconstruction)**\ 。

完整代码：

.. literalinclude:: source/chp3/deconstruction.hs

运行：

::

    Prelude> :load deconstruction
    [1 of 1] Compiling Main             ( deconstruction.hs, interpreted )
    Ok, modules loaded: Main.

    *Main> let clrs = Book 1111 "Introduction to Algorithms" ["c", "l", "r", "s"]

    *Main> clrs
    Book 1111 "Introduction to Algorithms" ["c","l","r","s"]

    *Main> bookId clrs
    1111

    *Main> bookTitle clrs
    "Introduction to Algorithms"

    *Main> bookAuthors clrs
    ["c","l","r","s"]

如果我们只想抽取出其中一样成分，而对其他成分没有兴趣的话，我们还可以用\ ``Wild Card Pattrn``\ ：

.. literalinclude:: source/chp3/deconstruction_wc.hs

.. note:: 如果你熟悉面向对象的话，那把构造想成是新建一个对象实例，而分解则是对象的访问方式(getter)。


Record Syntax p55-56
=======================

上面说明了可以用模式匹配获取值的成分，但这一方法有点麻烦，因为它要求各个访问方法和值的构造一一对应——而值的成分越复杂，我们需要写的额外代码就越多：

.. literalinclude:: source/chp3/deconstruction_wc.hs

其实我们还有一种更好的办法，可以在定义类型的时候连访问方法一并定义：

.. literalinclude:: source/chp3/record_syntax.hs

上面的两种方法效果是几乎一样，只有点小不同：

::

    Prelude> :load record_syntax
    [1 of 1] Compiling Main             ( record_syntax.hs, interpreted )
    Ok, modules loaded: Main.

    *Main> let note = Book 10086 "huangz's note" ["huangz"]

    -- 输出和之前的方式有点不同
    *Main> note 
    Book {bookId = 10086, bookTitle = "huangz's note", bookAuthors = ["huangz"]}

    *Main> bookId note
    10086

    *Main> bookTitle note
    "huangz's note"

    -- 另外，构造值的时候，可以通过指定成分名字而打乱成分的顺序
    *Main> let hp = Book { bookId = 2552, bookAuthors = ["j.k loli"], bookTitle = "mary poter" }

    *Main> hp
    Book {bookId = 2552, bookTitle = "mary poter", bookAuthors = ["j.k loli"]}

.. note:: 注意当按顺序创建值时，不需要用\ ``{}``\ 包围参数。

多态类型 p57-58
=================

之前我们看过了一些多态的函数，比如\ ``head``\ :

::

    *Main> :t head
    head :: [a] -> a

这里的\ ``a``\ 就是类型变量。

实际上，我们可以通过在定义类型时加入类型变量，让所定义的类型支持多态，比如下面的一个二叉树：

.. literalinclude:: source/chp3/tree.hs

其中\ ``a``\ 为类型变量(字母\ ``a``\ 只是一个习惯，使用其他字母代替也是可以的)。

运行：

::

    Prelude> :load tree
    [1 of 1] Compiling Main             ( tree.hs, interpreted )
    Ok, modules loaded: Main.

    -- 一棵整数值树
    *Main> let num_tree = Node 10 Empty Empty

    *Main> num_tree
    Node 10 Empty Empty

    *Main> :type num_tree
    num_tree :: Tree Integer

    -- 一棵单字符树
    *Main> let c_tree = Node 'f' (Node 'a' Empty Empty) (Node 'z' Empty Empty)

    *Main> c_tree
    Node 'f' (Node 'a' Empty Empty) (Node 'z' Empty Empty)

    *Main> :type c_tree
    c_tree :: Tree Char

注意当我们执行\ ``:type num_tree``\ 和\ ``:type c_tree``\ 时，返回的值各有不同。


错误报告 p60-61
=================

抛出错误可以使用\ ``error``\ 方法，它中断编译并返回错误信息：

.. literalinclude:: source/chp3/error.hs

\ ``guess``\ 函数只有在收到\ ``10086``\ 的时候才不会出错。

::
    
    *Main> guess 1
    "*** Exception: bad~ bad~ bad~

    *Main> guess 50
    "*** Exception: bad~ bad~ bad~

    *Main> guess 10086
    "luckly"


局部变量 p61-63
===============

let p.61
---------

\ ``let``\ 结构可以让你建立局部变量，格式如下：

::

    let ...
    in ...

以下是一个关于借钱的\ ``lend``\ 函数：

.. literalinclude:: source/chp3/lending.hs

遮蔽 p.62
-----------

\ ``let``\ 可以互相嵌套，如果内层和外层有同样的名字时，内层的名字覆盖外层的名字，这一现象称之为\ **遮蔽(shadowing)**\ 。

例如在下面的表达式中，将打印出\ ``("foo", 1)``\ 。

::

    let x = 1
        in ((let x = "foo" in x), x)

where p.63
---------------

\ ``where``\ 结构和\ ``let``\ 类似，都可以定义局部变量，但是\ ``where``\ 将局部变量的赋值放到表达式后面进行，而\ ``let``\ 放在前面。

下面的\ ``lend``\ 函数和上面用\ ``let``\ 定义的作用一样：

.. literalinclude:: source/chp3/where.hs


局部函数 p63-64
================

\ ``let``\ 和\ ``double``\ 不但可以用来定义变量，还可以用来定义函数(其实它们都是表达式)：

::

    Prelude> let double num = num * 2 in double 5
    10


case结构 p.66-67
==================

\ ``case``\ 结构格式：

::

    case value of 
        pattern_1 -> expression_1
        pattern_2 -> expression_2
        ...
        pattern_n -> expression_n
        _ -> default_expression

下面是一个识别问候语，并返回相应问候语的程序：

.. literalinclude:: source/chp3/case.hs

运行：

::

    *Main> :load case
    [1 of 1] Compiling Main             ( case.hs, interpreted )
    Ok, modules loaded: Main.

    *Main> greet "hello"
    "world"

    *Main> greet "long time no seeeeeeeeeeee~"
    "hello"


守卫 p.68-70
==============

Haskell还提供了另一种和模式匹配\ ``case``\ 以及\ ``if``\ 很相似、但结构更清晰的匹配方法，称之为\ **守卫(guard)**\ 。

我们用守卫重写上面的问候语程序：

.. literalinclude:: source/chp3/guard.hs

可以看到，守卫的每个匹配由\ ``|``\ 分割，每个匹配需是一个返回布尔值的表达式(比如\ ``value == "hello"``\ ，而结果表达式则放到等号之后(比如\ ``world``\ )。


if、case、守卫以及模式匹配
============================

\ ``if``\ 结构、\ ``case``\ 结构、守卫以及模式匹配的作用都非常相似，值得我们仔细地研究一下它们的微小区别，以及它们适用的地方。

if
---

首先，\ ``if``\ 的结构最简单：

::

    if predicate
    then expression_1
    else expression_2

如果\ ``predicate``\ 为\ ``True``\ ，则执行\ ``expression_1``\ ；如果为\ ``False``\ ，则执行\ ``expression_2``\ 。

很明显，\ ``if``\ 结构适用于\ *只有两种情形的匹配*\ ，一旦情况超过两种，\ ``if``\ 语句就需要嵌套使用，可读性就会大大降低。

比如下面一个例子，用\ ``if``\ 写起来就非常麻烦：

::

    check value = if value == 10 
                  then "value == 10"
                  else if value == 3
                  then "value == 3"
                  else if value == 5
                  then "value == 5"
                  else "value not equals to 10, 3 or 5"

case
------

\ ``case``\ 语句的结构如下：

::

    case value of
        value_1 -> expression_1
        value_2 -> expression_2
        ...
        value_n -> expression_n
        _ -> default_expression

\ ``case``\ 结构将\ ``value``\ 和结构体内的各个值对比(\ ``value_1``\ ，\ ``value_2``\ 。。。)，当某一个值对比成功时，则执行相应的表达式。

如果所有对比都不成功，就执行(可能有的)Wild Card Pattrn。

可以看出，\ ``case``\ 最适合的是\ *值之间对比*\ 的情况。

比如说，用\ ``case``\ 来写上面\ ``check``\ 函数最适合不过了：

::
    
    check value = case value of
                    10 -> "value == 10"
                    3  -> "value == 3" 
                    5  -> "value == 5"
                    _  -> "value not equals to 10, 3 or 5"

\ ``case``\ 的缺点(也是它的优点)是不能在对比式中写表达式，所以它做不到像\ ``if``\ 语句那样的事情：

::

    if value * 5 
    then ...
    else ...

当然这个缺点可以用\ ``let``\ 或者\ ``where``\ 来克服，只是这样一来就不如\ ``case``\ 或守卫方便了：

::

    let new_value = value * 5
    in case new_value of
        ... -> ...

守卫
-----

守卫的格式是用\ ``|``\ 分割每条匹配：

::

    | predicate_1 = expression_1
    | predicate_2 = expression_2
    | ...
    | otherwise

守卫按顺序地检查每一条判断语句，找到合适的就执行相应的表达式。

守卫可以看作是\ ``if``\ 的多匹配版本，它和\ ``if``\ 一样可以在判断语句内执行表达式计算。

\ ``check``\ 语句的守卫版本：

::

    check value 
        | value == 5  = "value == 5"
        | value == 10 = "value == 10"
        | value == 3  = "value == 3"
        | otherwise   = "value not equals to 5, 10 or 3"

模式匹配
---------

模式匹配和上面的三种对比结构不尽相同，它是以函数定义的方法来匹配对比式，最大的好处是模式匹配写的语句非常直白和易读。

用模式匹配写的\ ``check``\ 函数可能是四种匹配方法中最易读的。

::

    check 10 = "value == 10"
    check 5  = "value == 5"
    check 3  = "value == 3"
    check _  = "value not equals to 10, 5 or 3"

而另一方面，模式匹配的功能不如前面的三种语句，比如你没有办法在模式匹配里比对范围，也不能在对比式中写表达式。

想想如果我们的\ ``check``\ 函数不是比对三个值(\ ``3``\ 、\ ``5``\ 、 \ ``10``\ )，而是一个范围形函数，用模式匹配是没有办法写完这种匹配的(除非你是机器人。。。)：

::
    
    check 1 = "bad"
    check 2 = "bad"
    ...
    check 10086 = "good"    -- 只有10086是"好"数
    check 10087 = "bad"
    check 10089 = "bad"
    ...


小结
-----

如果匹配只有两种情况，使用\ ``if``\ 结构最方便。

如果匹配情况很多，而且需要在对比式中写表达式(比如\ ``value * 2 > 10086``\ )的话，你应该使用守卫。

如果匹配情况很多，但全都是简单的对比(\ ``value == 10086``\ 这样的语句的话，你应该使用\ ``case``\ 。

模式匹配可以用于定义匹配情况比较少的函数，但它不适合情况较多或具有范围性的匹配。
