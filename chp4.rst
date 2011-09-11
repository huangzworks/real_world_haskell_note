第四章：函数式编程
*********************

中序函数
=========

我们通常以\ **前序(prefix)**\ 调用函数，像\ ``head ["haha", "nono", "yoyo"]``\ ，但有时使用\ **中序(infix)**\ 会更符合阅读习惯。

比如一个对两个数进行加法的\ ``plus``\ 函数，使用\ ``1 plus 2``\ 比\ ``plus 1 2``\ 更直观。

但是在Haskell中，直接写\ ``1 plus 2``\ 是不行的，Haskell只会认为\ ``1``\ 是函数方法，而\ ``plus``\ 和\ ``2``\ 则是传入给它的参数，最终造成一个错误：

::

    Prelude> let plus a b = a + b
    Prelude> 1 plus 2

    <interactive>:1:1:
        No instance for (Num ((a0 -> a0 -> a0) -> a1 -> t0))
            arising from the literal `1'
        Possible fix:
            add an instance declaration for
            (Num ((a0 -> a0 -> a0) -> a1 -> t0))
        In the expression: 1
        In the expression: 1 plus 2
        In an equation for `it': it = 1 plus 2

要使用中序操作符，我们需要用\ `````\ 包围相应的函数名，这样Haskell才能明白我们的真正意思：

::

   Prelude> 1 `plus` 2
   3

另一方面，我们不但可以用传统的前序方式定义函数，还可以用中序方法来定义。

只需要一次定义(无论前序或中序)，函数都可以被用于前序调用或后续调用。

比如下面两个定义的作用是一样的：

::

    plus a b = a + b

    a `plus` b = a + b


List结构的常用函数
====================

p77-84

List结构是很多函数式编程语言的强力工具之一，在List结构之上通常有一族功能丰富的函数，Haskell也一样。

length
--------

\ ``length``\ 返回列表的长度：

::

    Prelude> :type length
    length :: [a] -> Int

    Prelude> length [1..10]
    10

    Prelude> length []
    0

null
--------

\ ``null``\ 检查一个列表是否为空：

::

    null :: [a] -> Bool

    Prelude> null []
    True

    Prelude> null [1, 2, 3]
    False

head
-----

\ ``head``\ 返回列表的第一个元素：

::

    Prelude> :type head
    head :: [a] -> a

    Prelude> head [1, 2, 3]
    1

    Prelude> head []
    *** Exception: Prelude.head: empty list

last
------

\ ``last``\ 返回列表的\ *最后一个*\ 元素：

::

    Prelude> :type last
    last :: [a] -> a

    Prelude> last []
    *** Exception: Prelude.last: empty list

    Prelude> last [1..10]
    10

tail
------

\ ``tail``\ 返回列表\ *除第一个元素之外的所有元素*\ ：

::

    Prelude> :type tail
    tail :: [a] -> [a]

    Prelude> tail []
    *** Exception: Prelude.tail: empty list

    Prelude> tail [1]
    []

    Prelude> tail [1..10]
    [2,3,4,5,6,7,8,9,10]

init
-----

\ ``init``\ 返回列表\ *除最后一个元素之外*\ 的所有元素：

::

    Prelude> :type init
    init :: [a] -> [a]

    Prelude> init []
    *** Exception: Prelude.init: empty list

    Prelude> init [1]
    []

    Prelude> init [1..5]
    [1,2,3,4]

.. note:: 

    当\ ``head``\ 和\ ``init``\ 这类函数作用在空列表的时候，会抛出一个错误。

.. note::

    当你要检查一个列表是否为空时，你可能会使用\ ``length list == 0``\ 。

    实际上，Haskell的List并不保存自己的长度，也即是，要获得一个List的长度，你必须\ *遍历整个List*\ ——对长List来说，这是个相当耗时的操作。

    如果执行下面代码，Haskell将一直对列表进行迭代：

    ``length [1..]``
    
    而执行\ ``null``\ ，代码会立即返回：

    ``null [1..]``
    
    所以当你要检查一个列表是否为空时，应该使用\ ``null``\ 而不是\ ``length``\ 。

++
----

\ ``++``\ 函数用两个List组成一个List：

::

    Prelude> :type (++)
    (++) :: [a] -> [a] -> [a]

    Prelude> "hello " ++ "moto"
    "hello moto"

concat
-------

\ ``concat``\ 将给定的一个List中的List中的元素提取出来，组合成一个List：

::

    Prelude> :type concat
    concat :: [[a]] -> [a]

    Prelude> concat ["hallo", " moto"]
    "hallo moto"

    Prelude> concat [[1..3], [5..6]]
    [1,2,3,5,6]

reverse
--------

\ ``reverse``\ 反转一个列表：

::

    Prelude> :type reverse
    reverse :: [a] -> [a]

    Prelude> reverse "morning"
    "gninrom"

    Prelude> reverse [1..5]
    [5,4,3,2,1]

and
----

\ ``and``\ 求一个列表中所有元素的\ *并*\ ：

::

    Prelude> :type and
    and :: [Bool] -> Bool

    Prelude> and [True, False, True]
    False

    Prelude> and []
    True

or
---

\ ``or``\ 求一个列表中所有元素的\ *或*\ ：

::

    Prelude> :type or
    or :: [Bool] -> Bool

    Prelude> or [True, False, True]
    True

    Prelude> or []
    False

.. note:: 注意\ ``and``\ 和\ ``or``\ 对空列表的返回值是不同的。

all
----

\ ``all``\ 检查是否列表总所有元素都符合某个属性：

::

    Prelude> :type all
    all :: (a -> Bool) -> [a] -> Bool

    Prelude> all odd [1, 3 ..10]
    True

    Prelude> all odd [1..10]
    False

any
----

\ ``any``\ 检查是否列表中\ *有某个元素*\ 符合某个属性：

::

    Prelude> :type any
    any :: (a -> Bool) -> [a] -> Bool

    Prelude> any odd [1..10]
    True

    Prelude> any odd [2, 4..10]
    False

take
-----

\ ``take``\ 取列表的前\ ``N``\ 个值：

::

    Prelude> :type take
    take :: Int -> [a] -> [a]

    Prelude> take 3 [1..10]
    [1,2,3]

    Prelude> take 3 [1, 2]
    [1,2]

takeWhile
------------

\ ``takeWhile``\ 只要列表的值符合某个属性，就将其保留，并递归直到遇到第一个不符合属性的值为止。

::

    Prelude> :type takeWhile
    takeWhile :: (a -> Bool) -> [a] -> [a]

    Prelude> takeWhile odd ([1, 3, 5] ++ [2, 4, 6])
    [1,3,5]

    Prelude> takeWhile odd [2, 4..10]
    []

drop
-----

\ ``drop``\ 丢弃列表的前\ ``N``\ 个值，然后取剩下的值：

::

    Prelude> :type drop
    drop :: Int -> [a] -> [a]

    Prelude> drop 3 [1..10]
    [4,5,6,7,8,9,10]

    Prelude> drop 3 [1, 2]
    []

dropWhile
----------

\ ``dropWhile``\ 只要列表的值符合某个属性，就将其丢弃，并递归直到遇到第一个不符合属性的值为止。

::

    Prelude> :type dropWhile
    dropWhile :: (a -> Bool) -> [a] -> [a]

    Prelude> dropWhile odd ([1, 3, 5] ++ [2, 4, 6])
    [2,4,6]

    Prelude> dropWhile odd [2, 4..10]
    [2,4,6,8,10]

在列表中搜索
-------------

elem
^^^^^^

\ ``elem``\ 查看指定元素是否是列表的值：

::

    Prelude> :type elem
    elem :: Eq a => a -> [a] -> Bool

    Prelude> 2 `elem` [1..10]
    True

notElem
^^^^^^^^^

\ ``notElem``\ 查看指定元素是否\ *不是*\ 列表的值：

::

    Prelude> :type notElem
    notElem :: Eq a => a -> [a] -> Bool

    Prelude> 2 `notElem` [1, 3.10]
    True

filter
^^^^^^^

\ ``filter``\ 过滤列表，只保留符合给定属性的值：

::
    
    Prelude> :type filter
    filter :: (a -> Bool) -> [a] -> [a]

    Prelude> filter odd [1..10]
    [1,3,5,7,9]

isPrefixOf, isInfixOf, isSuffixOf
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

\ ``Data.List``\ 模块中的\ ``isPrefixOf``\ 、\ ``isInfixOf``\ 和\ ``isSuffixOf``\ 分别检查某个给定值在列表中的前面、中间或后面：

::

    Prelude> :module +Data.List

    Prelude Data.List> :type isPrefixOf
    isPrefixOf :: Eq a => [a] -> [a] -> Bool

    Prelude Data.List> "good" `isPrefixOf` "good morninig, sir"
    True

    Prelude Data.List> :type isInfixOf
    isInfixOf :: Eq a => [a] -> [a] -> Bool

    Prelude Data.List> "morning" `isInfixOf` "good morning, sir"
    True

    Prelude Data.List> :type isSuffixOf
    isSuffixOf :: Eq a => [a] -> [a] -> Bool

    Prelude Data.List> "sir" `isSuffixOf` "good morning, sir"
    True


一次处理多个列表
------------------

zip
^^^^^

\ ``zip``\ 允许在2个列表中，每次抽取列表中的一个元素，进行组合操作：

::

    Prelude Data.List> :type zip
    zip :: [a] -> [b] -> [(a, b)]

    Prelude Data.List> zip [1, 3, 5] [2, 4, 6]
    [(1,2),(3,4),(5,6)]

zipWith
^^^^^^^^^

\ ``zipWith``\ 可以指定\ ``zip``\ 执行的操作：

::

    Prelude Data.List> :type zipWith
    zipWith :: (a -> b -> c) -> [a] -> [b] -> [c]

    Prelude Data.List> zipWith (+) [1, 2, 3] [4, 5, 6]
    [5,7,9]

.. note:: 注意\ ``zip``\ 和\ ``zipWith``\ 只能处理两个列表，要处理三个列表，要使用\ ``zip3``\ 和\ ``zipWith3``\ ，以此类推，最高到\ ``zip7``\ 和\ ``zipWith7``\ 。


匿名函数
===========

p.99-100

有时候我们需要一些“一次性”函数来帮助完成一些问题。

比如有时你需要一个将某个值乘以2的函数，于是你定义：

::

    Prelude> let mul_by_2 value = value * 2

    Prelude> mul_by_2 10
    20


这个方法有一个问题：这个“一次性”函数污染了命名空间，如果这类一次性函数很多的话，就会极大地影响程序的可读性。

我们可以用一个称之为\ **匿名函数(anonymous function / lambda function)**\ 的技术来解决这个问题，匿名函数专门用来定义“一次性”函数，而且它\ *不*\ 和名字绑定，不会污染命名空间。

匿名函数的语法格式如下：

``\para1, para2, ..., paraN -> expression``

符号\ ``\``\ 被看作是lambda，后面跟各个形参\ ``para1, para2, ..., paraN``\ ，\ ``->``\ 之后是函数的表达式。

于是我们可以将之前的\ ``mul_by_2``\ 函数修改成匿名函数：

::

    Prelude> ((\value -> value * 2) 10)
    20

.. note:: 你应该只将“一次性使用”的函数定义为匿名函数，如果一个计算模式多次重复出现，你应该将它定义为一个函数或利用其他组合方式来重用，而不是反复地定义相同(或相类似)的匿名函数，这样可读性只会不增反降。


柯里化(Currying)与偏函数(partial function)
============================================

p.100-103

在计算机科学中，\ **柯里化(Currying)**\ 指的是将一个接受\ *多个*\ 参数的函数变换成一个只接受\ *一个*\ 参数的新函数，当有参数传入这个新函数之后，这个新函数又返回一个新函数，以此类推，直到\ *所有*\ 参数都被传入之后，函数返回之前通过多个参数计算出来的值。

柯里化一个显著用处就是用来实现\ **偏函数(partial function)**\ ：我们可以给一个函数传入比它所需参数数目更少的参数(比如一个函数需要三个参数，但我们只付给两个参数)，这样函数就不会立即计算值(因为所需的参数还没满足)，而是返回一个已经接受了两个参数的新函数。

举个例子，现在我们有一个将三个值组合成一个元组的函数\ ``three``\ ，定义如下：

::

    three a b c = (a, b, c)

我们查看它的类型签名：

::

    Prelude> :type three
    three :: t -> t1 -> t2 -> (t, t1, t2)

现在看看我们将一个参数付给\ ``add_3``\ 之后，类型签名有什么变化：

::

    Prelude> :type three 'a' 
    three('a') :: t1 -> t2 -> (Char, t1, t2)

嗯，函数签名里的\ ``t``\ 不见了，而且元组的类型也被\ ``Char``\ 占住了，肯定有什么发生了——但是我们先不深究，先继续给\ ``three``\ 传值，这次我们将两个参数赋值给\ ``three``\ ：

::

    Prelude> :type three 'a' 'b'
    three 'a' 'b' :: t2 -> (Char, Char, t2)

噢噢，这次连\ ``t1``\ 都不见了，你肯定想知道如果把三个参数都传进\ ``three``\ 会怎么样，马上来做这个：

::

    Prelude> :type three 'a' 'b' 'c'
    three 'a' 'b' 'c' :: (Char, Char, Char)

    Prelude> three 'a' 'b' 'c'
    ('a','b','c')

OK，这次\ ``t``\ 、\ ``t1``\ 、\ ``t2``\ 全都不见了，只剩下三个\ ``Char``\ 在风中飘零，而且，这次我们可以将函数的值求出来了。

看看上面的类型签名，可以发现每次我们添加一个参数，类型签名里面的变量(比如\ ``t``\ )就减少一个：

::

    Prelude> :type three
    three :: t -> t1 -> t2 -> (t, t1, t2)

    Prelude> :type three 'a'
    three 'a' :: t1 -> t2 -> (Char, t1, t2)

    Prelude> :type three 'a' 'b'
    three 'a' 'b' :: t2 -> (Char, Char, t2)

    Prelude> :type three 'a' 'b' 'c'
    three 'a' 'b' 'c' :: (Char, Char, Char)

秘密就隐藏在类型签名里面！让我们仔细地研究它们，从参数最多的开始：

\ ``three 'a' 'b' 'c' :: (Char, Char, Char)``\ 开头的\ ``three 'a' 'b' 'c'``\ 是一个表达式，表示函数\ ``three``\ 接受了\ ``'a'``\ 、\ ``'b'``\ 和\ ``c``\ 三个参数，而后面的\ ``(Char, Char, Char)``\ 表示函数的值是一个三元组，三个元组里面的值都是\ ``Char``\ 类型，最后，在中间的\ ``::``\ 分隔开函数表达式和函数返回值类型。

一切顺利，接着开始分析：

\ ``three 'a' 'b' :: t2 -> (Char, Char, t2)``\ ，这个签名的前半部和上面的签名不同，它有两个参数，另外，在签名后半部分\ ``t2 -> (Char, Char, t2)``\ ，和上面的签名对比，我们可以知道\ ``t2``\ 代表的就是最后一个函数，另外，\ ``->``\ 是一个新符号，它代表什么？看起来，它的意思似乎是“接受一个参数，然后返回函数的值”。

整个函数签名的意思似乎是：函数\ ``three``\ 已经接受了两个参数，只要再给它一个参数，它就可以返回计算值了。

嗯，似乎说得通，把这个问题先放一放，先看看下一个签名：

\ ``three 'a' :: t1 -> t2 -> (Char, t1, t2)``\ ，签名前半部和之前的一样，少了一个参数，关键是在后面：\ ``->``\ 符号两次出现了，之前我们猜测它的意思是“接受一个参数，然后返回一个值”，可这里怎么有两个\ ``->``\ 符号？难道我们猜错了吗？

其实我们并没有猜错，表达式\ ``three 'a'``\ 的确是接受一个参数，然后返回一个值，但是这个值不是计算结果，而是一个函数。

回到前面，我们的\ ``three``\ 接受三个参数：

::
    
    Prelude> :type three
    three :: t -> t1 -> t2 -> (t, t1, t2)

    Prelude> three 'a' 'b' 'c'
    ('a','b','c')

当我们只将一个参数值赋值\ ``three``\ 的时候，\ ``three``\ 返回一个新函数，这个新函数接受两个值作为它的参数：

::

    Prelude> :type three 'a'
    three 'a' :: t1 -> t2 -> (Char, t1, t2)

当我们再将一个参数赋值给\ ``three``\ 的适合，\ ``three``\ 又返回一个新函数，这次这个函数只接受一个值(最后一个，\ ``t2``\ )。假如我们再将最后一个参数也赋值给\ ``three``\ ，那么我们就得到它的计算结果。

实际上：

::

    Prelude> three 'a' 'b' 'c'
    ('a','b','c')

是由三个函数分别构成的：

::

    Prelude> (((three 'a') 'b') 'c')
    ('a','b','c')

\ ``three``\ 首先接受\ ``'a'``\ 作为它的参数，形成\ ``(three 'a')``\ ，这个表达式返回一个新的函数，然后这个函数接受又一个值\ ``'b'``\ ，形成表达式\ ``((three 'a') 'b')``\ ，这个表达式又返回一个新函数，再接受值\ ``c``\ ，这一次，\ ``three``\ 的三个函数都齐备了，于是这个函数(不是\ ``three``\ ，而是接受了两个参数形成的新函数)接收参数\ ``'c'``\ ，并计算出值，然后返回结算结果。

这样以来，为什么\ ``three``\ 的类型签名有三个\ ``->``\ 符号也说得过去了——\ ``three``\ 函数由三个函数组成，它们接受参数、逐次变换并返回新函数，最终组成一个完整的\ ``three``\ 函数，最后求出结果。

::

    Prelude> :type three
    three :: t -> t1 -> t2 -> (t, t1, t2)

这种将一个需要多个参数的函数变换成多个只接受单一参数的函数的过程，称之为柯里化，而那些柯里化生成出来的没有接受到完整参数的函数，称之为偏函数。

偏函数的应用
--------------

偏函数的作用很多，其中一个是为一个需要多个参数的函数指定一个参数，然后生成一个新函数，将这个新函数应用到多个地方。

举个例子，我们之前学习了\ ``take``\ 函数，这个函数用来获取列表的前\ ``N``\ 项，它有两个参数：一个是获取项的数目，另一个是获取的列表对象。

假设现在我们有一个博客程序，这个程序有好几个列表，包括日志列表(post_list)、评论列表(comment_list)、友链接列表(link_list)，等等，如果我们想要多次地提取多个列表的前\ ``10``\ 个项，我们可能会写这样的代码：

| ``take 10 post_list``
| ``take 10 comment_list``
| ``take 10 link_list``

而利用偏函数，我们可以生成一个新函数，称之为\ ``take_10``\ ：

::

    take_10 list = take 10 list

这样我们就可以将上面的语句改写成下面的形式了：

| ``take_10 post_list``
| ``take_10 comment_list``
| ``take_10 link_list``

噢噢。。。我已经听到有人叫起来了，这个函数的定义\ *并不是*\ 偏函数，它只是一个普通的函数抽象，并没有返回一个新函数——的确如此，即使在不支持偏函数的语言，比如Python中，你也可以写这样的代码来获取列表前十个项:

.. code-block:: python

    # python code
    def take_10(list):
        return list[:10]

好吧，既然我的邪恶计划已经败露，那只好动点真格，写一个真正的偏函数：

::

    take_10_partial = take 10

好的，这个是真的偏函数了，\ ``take_10_partial``\ 函数返回一个函数，这个函数接受一个列表作参数，用于获取列表的前10个项：

::

    Prelude> :type take_10_partial
    take_10_partial :: [a] -> [a]

    Prelude> take_10_partial [1..]
    [1,2,3,4,5,6,7,8,9,10]

这样，我们就不必每次都将\ ``10``\ 显式传值给\ ``take``\ 函数了。

当然这只是偏函数的一个小例子，但从这个例子可以看到，通过适当地使用偏函数，可以让我们避免频繁地重复传值，并且更容易地重用函数。

.. seealso:: 维基百科的\ `Partial Function <http://en.wikipedia.org/wiki/Partial_function>`_\ 和\ `Currying <http://en.wikipedia.org/wiki/Currying>`_\ 是关于偏函数和柯里化的很好的参考。

.. note:: Python可以通过functools中的partial函数来实现偏函数的效果，但是Python本身是不支持偏函数的。
