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
