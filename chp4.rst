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

    如果执行下面代码，Haskll将一直对列表进行迭代：

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

\ ``Data.List``\ 模块中的\ ``isPrefixOf``\ 、\ ``isInfixOf``\ 和\ ``isSuffixOf``\ 分别检查某个给定值在列表中的前、中间或后面：

::

    Prelude> :module +Data.List

    Prelude Data.List> :type isPrefixOf
    isPrefixOf :: Eq a => [a] -> [a] -> Bool

    Prelude Data.List> "good" `isPrefixOf` "good morning , perter"
    True

    Prelude Data.List> :type isInfixOf
    isInfixOf :: Eq a => [a] -> [a] -> Bool

    Prelude Data.List> "morning" `isInfixOf` "good morning , peter"
    True

    Prelude Data.List> :type isSuffixOf
    isSuffixOf :: Eq a => [a] -> [a] -> Bool

    Prelude Data.List> "peter" `isSuffixOf` "good morning , peter"
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
