第一章：起步
************

算数
====

Haskell中的算数默认使用中序格式(infix form)，也可以将操作符用括号包围，然后使用前序格式(prefix form)。

::

    Prelude> 2 + 2
    4

    Prelude> (+) 2 2
    4

负数
=====

当负号操作符\ ``-``\ 有两个操作符是，Haskell实现会读出歧义，所以必须用括号包围。

比如当执行\ ``f -2``\ 时，Haskell不知道你的意思是变量\ ``f``\ 减去常量\ ``2``\ 还是执行函数\ ``f``\ 的调用，参数为\ ``-``\ 和\ ``2``\ 。

::

    Prelude> -2
    -2

    Prelude> 2 + -2

    <interactive>:1:1:
        Precedence parsing error
                cannot mix `+' [infixl 6] and prefix `-' [infixl 6] in the same infix expression

    Prelude> 2 + (-2)
    0

逻辑操作符于值比对
===================

Haskell使用\ ``True``\ 表示真，\ ``False``\ 表示假(大小写必须正确)。

逻辑操作符：\ ``&&``\ 表示并，\ ``||``\ 表示或，\ ``not``\ 表示反。

::

    Prelude> True && True
    True

    Prelude> False || True
    True

    Prelude> not True
    False

和其他很多语言不同的是，Haskell中\ *不*\ 以非零或空字符表示假，\ *也不*\ 用非空字符和大于0的数值表示真。

:: 

    Prelude> True && 1

    <interactive>:1:9:
        No instance for (Num Bool)
        arising from the literal `1'
        Possible fix: add an instance declaration for (Num Bool)
        In the second argument of `(&&)', namely `1'
        In the expression: True && 1
        In an equation for `it': it = True && 1

Haskell的对比符和其他语言相似，像是\ ``==``\ 和\ ``>=``\ ，唯一比较特立独行的是不等符号，Haskell使用\ ``/=``\ 表示不相等。

::

    Prelude> 1 == 1
    True

    Prelude> 1 > 2
    False

    Prelude> 3 <= 2.5
    False

    Prelude> 1 /= 1
    False

操作符优先级
=============

和大多数语言一样，Haskell使用括号来包裹需要优先计算的表达式。

默认的操作符也遵守一般的数学符号优先级(比如\ ``*``\ 优先\ ``+``\ ，等等)，一共分为1至9个优先级，优先级高的操作符先计算。

下面的例子表明\ ``+``\ 操作符优先级为6，而\ ``*``\ 操作符优先级为\ ``7``\ 。

::

    Prelude> :info (+)
    class (Eq a, Show a) => Num a where
      (+) :: a -> a -> a
      ...
        -- Defined in GHC.Num
    infixl 6 +

    Prelude> :info (*)
    class (Eq a, Show a) => Num a where
      ...
      (*) :: a -> a -> a
      ...
        -- Defined in GHC.Num
    infixl 7 *


绑定变量、未绑定变量及预定义变量
=================================

使用未绑定变量会出错。

::

    Prelude> luckly_number

    <interactive>:1:1: Not in scope: `luckly_number'

绑定变量使用\ ``let``\ 语句。

::

    Prelude> let luckly_number = 10086

    Prelude> luckly_number
    10086

在库里面，有时也定义了一些预定义变量，比如\ ``Prelude``\ 里的\ ``pi``\ 。

::

    Prelude> pi
    3.141592653589793


列表
=====

用方括号包裹一簇元素的类型称之为列表(list)，列表可以是空的或者是非空的，但\ *必须拥有相同类型的值*\ 。

::
    
    Prelude> let one_two_three = [1, 2, 3]

    Prelude> let empty_list = []

    Prelude> [1, 2, "error"]

    <interactive>:1:5:
    No instance for (Num [Char])
        arising from the literal `2'
    Possible fix: add an instance declaration for (Num [Char])
    In the expression: 2
    In the expression: [1, 2, "error"]
    In an equation for `it': it = [1, 2, "error"]

列表的一个有用功能可以指定迭代的起始值、结束值和步长，让列表自动生成值，称之为enumeration。

::

    -- 生成1至10内所有数值
    Prelude> [1..10]
    [1,2,3,4,5,6,7,8,9,10]

    -- 生成1至20内所有奇数
    Prelude> [1, 3 .. 20]   
    [1,3,5,7,9,11,13,15,17,19]

    -- 生成10至1内所有数值
    Prelude> [10, 9 .. 1]
    [10,9,8,7,6,5,4,3,2,1]

.. warning:: 使用浮点数进行enumeration要小心，比如语句\ ``[1.0 .. 1.8]``\ 将返回\ ``[1.0, 2.0]``\ ，因为Haskell对\ ``1.8``\ 进行了舍入操作。

拼接列表使用\ ``++``\ 操作符：

::

    Prelude> [1, 2] ++ [3, 4]
    [1,2,3,4]

将单个元素加入到列表使用\ ``:``\ 操作符：

.. warning:: \ ``:``\ 操作符的第二个操作对象必须是列表，调用诸如\ ``[1, 2] : 3``\ 这样的语句将抛出错误。

::

    Prelude> 1 : [2, 3]
    [1,2,3]


字符串和单个字符
==================

Haskell使用双引号\ ``"``\ 包裹字符串(text string)，用单引号\ ``'``\ 包裹单字符(character)。

::

    Prelude> "hello world"
    "hello world"

    Prelude> 'c'
    'c'

实际上，字符串也是一个列表，里面每个元素都是一个单字符：

::

    Prelude> let greet = ['h', 'e', 'l', 'l', 'o']

    Prelude> greet
    "hello"

所以列表上的各种操作，字符串也可以使用：

::

    Prelude> greet ++ " world"
    "hello world"

    Prelude> 'h' : "ello"
    "hello"


其他
====

Haskell的类型名必须以\ *大写字母开头*\ ，而变量名则必须以\ *小写字母开头*\ :

::

    Prelude> let BadVariableName = 1

    <interactive>:1:5: Not in scope: data constructor `BadVariableName'

用\ ``:type``\ 语句可以查看变量的类型：

::

    Prelude> :type 1
    1 :: Num a => a

用\ ``:module +``\ 载入模块，在GHC中也可以用快捷方式\ ``:m +``\ 。

::

    Prelude> :module +Data.Ratio
    Prelude Data.Ratio> 

GHC使用一个特殊变量\ ``it``\ 储存最后一个表达式的值。

::

    Prelude Data.Ratio> 1 + 1
    2

    Prelude Data.Ratio> it
    2
