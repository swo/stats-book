# Functions

It may seem strange to start a book about statistics with something as abstract as functions, but many of the important objects in statistics are actually functions. If you are not entirely comfortable with the formalism of mathematical functions, fundamental concepts in statistics may become very confusing.

As an example, in statistics, you often see notation like $X=x$. You might be tempted to think that $X$ is a variable representing a number, and $x$ is another variable representing a number, and the equal sign means that the two variables represent the same number. However, in probability and statistics, the notation $X=x$ refers to something entirely different: $X$ represents a kind of function called a _random variable_, $x$ is a number, and the whole statement is not an assertion that the two sides of the equation are equal but instead a reference to the set of _events_ that the function $X$ maps to the value $x$. If this sounds incredibly bewildering, I agree, and helping unpack that is the purpose of the next few chapters.

## Functions map things to other things

In mathematical terms, a _function_ is relationship between sets, linking each element of one set to an element of another set. For example, say I have a function $f$ that links each number to that number plus one: $f(1) = 2$, $f(2) = 3$, and so on. Take careful note: the equation $f(1) = 2$, when translated into words, means that the function $f$ maps the input $1$ to the output $2$. It does not mean that the function equals $2$. A function is a relationship between sets, not a number.

In computer programming, a "function" refers to a sort of computational factory that takes some input and returns some output. This kind of "function" is not necessarily a mapping like a mathematical function is. For example, a random number generator "function" is designed to return a different, unpredictable number every time is it called. Some programming languages define _pure_ functions, which are analogous to mathematical functions in that they are guaranteed to deliver the same output whenever given the same input, but this is unusual. Do not confuse mathematical functions with the conceptually distinct computer programming concept that happens to have the same name.

## Functions can map different kinds of things, including functions

The function $f$ above is relatively simple: it takes a single real number as input and returns another real number. We characterize the function $f$ like this: $f : \mathbb{R} \to \mathbb{R},$ where $\mathbb{R}$ represents the set of real numbers. A slightly more complex function adds two numbers: $\mathrm{add}(1, 2) = 3$ Technically, this function still takes a single thing as input, only now that "thing" is an ordered pair of numbers. Ordered pairs of real numbers are also called the _Cartesian product_ of the set of real numbers with itself, that is, $\mathbb{R} \times \mathbb{R}$, or just $\mathbb{R}^2$. We characterize this function like: $\mathrm{add} : \mathbb{R}^2 \to \mathbb{R}$.

Functions can map from things that aren't numbers. In linear algebra, every square matrix has a determinant, which is a real number. Thus, "determinant" is a function: $\mathrm{det} : \{\text{square matrices}\} \to \mathbb{R}$. Functions can also map to things that aren't numbers. Again in linear algebra, one matrix has multiple eigenvectors. Thus, "eigenvectors" is a function: $\mathrm{eigenvectors} : \{\text{matrices}\} \to \{\text{multiple vectors}\}$.

Importantly, functions can map from functions and to functions. For example, the minimum of the function $f(x) = x^2$ is zero. We characterize the "minimum" function like: $\mathrm{min} : (\mathbb{R} \to \mathbb{R}) \to \mathbb{R},$ where $(\mathbb{R} \to \mathbb{R})$ means the set of functions that map from real number to real numbers. Or, note that the mirror of some function $f(x)$ around $x=0$ is a new function $g(x) = f(-x)$. Thus, "mirror around $x=0$" is a function: $\mathrm{mirror} : (\mathbb{R} \to \mathbb{R}) \to (\mathbb{R} \to \mathbb{R})$.

## Functions are written in different ways

We are used to writing functions using the _prefix_ (or "Eulerian") style, like $f(1) = 2$. In a few cases with well-known functions, we drop the parentheses, such as in $\sin \pi = 1$.

However, there are other styles of writing functions. In _infix_ notation, the function (or "operator") goes between the two inputs, such as in $1 + 2$, rather than $+(1, 2)$. We use _around-fix_ notation for the absolute value, like in $|x|$, and we use _postfix_ notation for the factorial function, such as $4!$. And there are plenty more. The binomial "choose" function $\binom{n}{k}$ maps a pair of integers to an integer. Summation, such as $\sum_{x=0}^n f(x)$, can be thought of as mapping a function and two integers (the lower and upper limits) to a real number (i.e., the value of the sum).

The important thing is to understand what each symbol on the page is. If it not a variable, then it is likely a function, or a part of the notation needed to encode a function. If it is a function, what is it mapping from and to?

## Different functions are written in the same way

In computer science, _polymorphism_ refers to the fact that the same "function" (in the computer science sense) will, when handed inputs of different types, perform different computations. For example, in many programming languages, `+` is used to signal numeric addition as well as string concatenation: `1 + 2` returns `3`, but `"Cui " + "bono?"` gives `"Cui bono?"`. Somehow the plus "function" knew to add in one case and to concatenate in the other.

In mathematics, polymorphism is mostly called "different notation". For example, the plus symbol ($+$) can be used to add two real numbers, but it can also be used to "add" two matrices. Adding two numbers and adding two matrices are analogous operations, but they are not identical. In statistics, we will encounter this situation often, where a series of symbols on the page could make perfect sense as an operation on numbers, but when in fact it means something very different.

The most important example of this confusion comes from the meaning of the equal sign ($=$). If I write $x=2$, it is most likely a definition: I'm asserting that the value of $x$ is $2$. But if I write $1=2$, and ask you, "Is this true?", you will say no. Many programming languages distinguish between the assignment operator `=` and the equality test operator `==`, so that `x=1` is a command "set $x$ to $1$!", while `x==2` is a question "is $x$ equal to 2?", to which the program will response `TRUE` or `FALSE`.

To help ease some confusion, I will put little symbols on top of the equal signs to clarify what the equal sign means. For example, $f(x) \defeq x^2$ means that I'm defining the function $f$, while $x^2 = x \cdot x$ means that I'm showing you the steps in a proof, and $x \stackrel{?}{=} 2$ means that I'm asking a question.
