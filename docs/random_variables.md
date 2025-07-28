# Random variables

The math in the last chapter is perfectly good for computing the probability of flipping a coin and getting a certain number of heads in a row, or for computing the probability of a winning poker hand, but not much more.

This chapter introduces _random variables_. Mathematically, random variables link outcomes with numbers. Intuitively, this link mirrors scientific measurement, the act of associating an outcome of an experiment with a number. Moving away from counting individual outcomes and events to looking at numbers will provide both useful mathematical abstraction as well as a more intuitive way to think about a scientific experiment.

## A random variable is a function

A _random variable_ is a function, common written $X$, that maps from the sample space, the set of all possible outcomes of an experiment, to the real numbers:

$$
X : \Omega \to \mathbb{R}
$$

As mentioned above, I think of a random variable as a mathematical analog to scientific measurement: outcomes are the actual experimental outcomes, and a random variable maps that outcome to the number you would see on your measurement device.

Before learning probability, I thought of "random variables" as random number generators: I might "draw" ten values from a "normally-distributed random variable". However, as discussed in [Functions](functions.md), a random number generator is not a function in the mathematical sense. It is important to remember that, technically speaking, a random variable is a function.

It is also important to remember that "random variable" does not mean "a numerical variable that takes on a random value". It would be very hard to prove any theorems about random variables if "random" meant that, every time you looked at the page, "$X$" meant something different! In common speech we might say that a random variable "takes on" some value, but I advise you to shy away from that during this book, because it encourages you to think about "random variables" not as functions but instead as random number generators.

## Random variables are classified by how many values they map to

Random variables come in two major flavors, _discrete_ and _continuous_. A discrete random variable $X$ associates outcomes $\omega \in \Omega$ with a finite set of numbers $x_i$, while a continuous random variable maps events to an infinite number of numbers.

Note that the distinction between discrete and continuous random variables only has to do with the values they map _to_, not with the sample space they map _from_. If the sample space is discrete, we can clearly only have a discrete random variable. For example, when flipping a coin, there are only two outcomes, heads $H$ or tails $T$. You could imagine a random variable $X$ encoding "number of heads flipped":

$$
\begin{aligned}
X[H] &= 1 \\
X[T] &= 0
\end{aligned}
$$

There are other random variables you could define from this, say this silly example:

$$
\begin{aligned}
X[H] &= 5\pi \\
X[T] &= -33
\end{aligned}
$$

But you clearly cannot map from a finite number of inputs to an infinite number of outputs.

In contrast, you can have an infinite space of outcomes and map it to a discrete set of values. For example, imagine I'm measuring the time required for a radioactive atom to decay. The outcomes are all possible times required for decay, which is an infinite number of possibilities. But I could define a simpler, discrete random variable that asks, "Did it take less than 1 second, between 1 and 2 seconds, or more than 2 seconds?" and then map those three swaths of outcomes to three, but only three, different numbers.

## Random variables abstract over outcomes

The whole point of random variables is that we don't need to talk about individual outcomes. Enumerating the outcomes of a trial is easy when talking about flipping coins, or rolling a die, or drawing a card from a deck, but it's basically impossible to enumerate an infinite set of outcomes _without_ referring to them by means of numbers. In other words, the only sensible way to talk about infinite sets of outcomes is to instead talk about the values that a random variable maps those outcomes to!

From this point forward, we will only refer to events by the values that a random variable maps those events to. For example, if $X$ represents the number of heads flipped on one coin toss, then $X = 0$ refers to the _event_ where the coin landed tails, and $X = 1$ refers to the _event_ where the coin landed heads.

!!! tip

    Take careful note that $X=1$ is an *event*, a probability theory object. Reading probability equations can become very confusing if you don't know what is a number and what is random variable!

Because the probability function maps events to numbers, we can now write:

$$
\mathbb{P}[X = 0] = \tfrac{1}{2}
$$

Take careful note of all the pieces in this equation:

- $X$ is a function mapping events to numbers
- $X = 0$ is the event composed of all the outcomes for which $X$ takes on the value zero
- $\mathbb{P}$ is a function mapping events to numbers between zero and one

Note that the same symbol $=$ is used to mean two different things in this equation! In the first case, $=$ turns a random variable (which is itself a function) and a number (0) to produce an event, while the second equals is an assertion that the two sides of the equation are the same number. To further emphasize that, consider this equation:

$$
(X = 5) = \varnothing
$$

It is impossible to flip five heads on a single coin flip, so the set of events that $X$ maps to the number five is the empty set. You will never see anyone else write an equation like this, but I put it there to scare you, to make you less sure of what an equal sign means.

Again, the nice thing is that, although the probabilities of the outcomes heads and tails both remain $\tfrac{1}{2}$, we no longer need to think about exactly what outcomes there are, what probabilities they have, and to what number the random variable maps each outcome. Instead, we can just examine the random variable, which has abstracted over everything else. A very pedantic person might have argued that, when you flip a coin, "heads" is actually a grouping of an infinite number of distinct outcomes: the coin might fall with the face on the coin pointing north, or west, or north-north-west; or the coin might have fallen into between the cushions of the couch and actually been standing almost straight up. Discrete sample spaces are clearly a mathematical fiction. Nevertheless, discrete random variables allow me to deal with a finite number of interesting _events_, and continuous random variables allow me to abstract over whatever was happening in nature and simply say, I guess this or that number with some probability.

The previous chapter was not a waste, however, because the rules for manipulating probabilities work just as well for events like "$X =
1$" as they did for outcomes like "flipped heads". The philosophical and technical definition of probability still holds. For example, $\mathbb{P}[(X = 1) \cup (X = 0)]$, the probability of the events that $X$ maps to either zero or one, is the sum of the probabilities the two constituent, disjoint events $\mathbb{P}[X=1]$ and $\mathbb{P}[X=0]$.

## Cumulative distribution functions

Now that we have random variables, we can ask how they are "distributed". If you are like me in days of yore, you think of random variables as random number generators that produce values to be visualized as a histogram, whose mathematical analog is the _probability density functions_ (pdf's). In fact, it's mathematically more straightforward to define the _cumulative distribution functions_ (cdf's) and use that to define the pdf.

The cdf of a random variable $X$, canonically written $F_X$, is a function that maps from real numbers to the numbers between zero and one. It is the probability of the event that $X$ maps to any value equal to or less than the given input value: $$\begin{gathered}
F_X : \mathbb{R} \to [0, 1] \\
F_X(x) \defeq \mathbb{P}[X \stackrel{\mathrm{rv]}{\leq} x}
\end{gathered}$$ Again, I put the "rv" of the less-than-or-equal sign to emphasize that $X$ is a function, $x$ is a number, and $X \leq x$ is an event. Note also that the cdf is a function of numbers $x$, which I emphasize by using regular parentheses around $x$ in $F_X(x)$.

It follows that, for a discrete random variable, which takes on specific values $x_i$, the cdf is just the sum of the probabilities of those specific values smaller than the given $x$: $$F_X(x) = \mathbb{P}[X \leq x] = \sum_{j \,:\, x_j \leq x} \mathbb{P}[X = x_j]$$ A discrete random variable therefore has maximum and minimum values:

$$
\begin{gathered}
\text{if } x < x_\mathrm{min} \text{, then } F_X(x) = 0 \\
\text{if } x \geq x_\mathrm{max} \text{, then } F_X(x) = 1
\end{gathered}
$$

<figure id="fig:discrete-cdf">

<figcaption>Cumulative distribution function and probability mass
function for a discrete random variable.</figcaption>
</figure>

A continuous random variable can also have a minimum and maximum. However, there are continuous random variables that can take on any real number. In those cases, the cdf approaches zero and one as $x$ goes out toward infinity: $$\begin{gathered}
\lim_{x \to -\infty} F_X(x) = 0 \\
\lim_{x \to \infty} F_X(x) = 1
\end{gathered}$$

<figure id="fig:continuous-pdf">

<figcaption>Cumulative distribution function and probability density
function for a continuous random variable.</figcaption>
</figure>

## Probability density functions

For a discrete random variable, it is straightforward to define its _probability mass function_ or "pmf", canonically written $f_X$, which is just the probability that it takes on each discrete value $x_i$:

$$
\begin{gathered}
f_X : \mathbb{R} \to [0, 1] \\
f_X(x_i) \defeq \mathbb{P}[X = x_i]
\end{gathered}
$$

The analog for continuous random variables is the _probability density function_, abbreviated "pdf": $$\begin{gathered}
f_X(x) : \mathbb{R} \to [0, 1] \\
f_X(x) \defeq \frac{d}{dx} F_X(x)
\end{gathered}$$

Note that the pdf of a continuous random variable $f_X(x)$ is not $\mathbb{P}[X =
x]$. This may seem like a pedantic diversion, but I actually think it's important to avoid confusion. For a continuous random variable, $\mathbb{P}[X = x]$ is basically zero for any value of $x$. For example, say $X$ takes on values between 0 and 1 uniformly. Then it follows that:

$$
\begin{aligned}
\mathbb{P}[0 \leq X \leq 1] &= 1 \\
\mathbb{P}[0.495 \leq X \leq 0.505] &= 0.1 \\
\mathbb{P}[0.4995 \leq X \leq 0.5005] &= 0.01
\end{aligned}$$ and so on. We normally don't say that
$\mathbb{P}[X = 0.500\ldots] = 0$, since that makes it sound like it's
impossible for $X$ to take on the value $0.5$. Nevertheless, it should
be clear that, from any practical point of view, the probability of
getting exactly $0.500\ldots$ from your experiment is essentially zero.
On the other hand, It does make sense to write ask about the *density*
of $X$ at 0.5, i.e., $f_X(0.5)$.

The word "density" in probability density function emphasizes that the
pdf, when integrated, gives a probability: $$\label{eq:integrated_pdf}
\int_{x_0}^{x_1} f_X(x) \dd x = F_X(x_1) - F_X(x_0) = \mathbb{P}[x_0 < X \leq x_1]
$$

In other words, the little-$f$ pdf $f_X$ is the derivative of the big-$F$ cdf $F_X$.

It follows from the definition of the cdf and some fundamental calculus that $$\int_{-\infty}^\infty f_X(x) \dd x = 1$$ In other words, all probability density must be somewhere. This also requires that $$\lim_{x \to \pm \infty} f_X(x) = 0$$ so that probability density can't be "hiding" infinitely far away from the origin.

The definitions I've given are simple ones, and they need to be refined to deal with more complicated functions. For example, if the cdf has discontinuities, you need careful with the limits on the integrals.

### Independent, identically-distributed random variables

If a random variable $X$ has the same cdf as another random variable $Y$ (and therefore also the same pdf), we say that $X$ is "distributed like" $Y$: $$\text{if } F_X(x) = F_Y(x) \text{ for all } x, \text{ then } X \sim Y.$$ Many cdf's are named. For example, you might say that a random variable $X$ is distributed like a normal random variable, with mean $\mu$ and variance $\sigma^2$: $$X \sim \mathcal{N}(x; \mu, \sigma^2).$$ This is shorthand for saying $$f_X(x) = f_\mathcal{N}(x; \mu, \sigma^2) \defeq
  \frac{1}{\sqrt{2\pi\sigma^2}} \exp \left\{-\frac{1}{2} \frac{(x-\mu)^2}{\sigma^2} \right\}$$

Critically, to say that $X \sim Y$ does not imply that $X$ and $Y$ are the same function. In fact, they might be defined in terms of completely different sample spaces. The random variable $X$ might be looking at stock prices and $Y$ might be looking at the time between solar flares. All that is required is that $X$ and $Y$ deliver the same numbers with the same probabilities.

Because frequentist statistics is concerned with repeatable trials, we will often consider _independent, identically-distributed_, abbreviated "iid", random variables. _Identically-distributed_ means that all the random variables in the collection have the same cdf. _Independent_ means that the probabilities of "and" events multiply: $$\text{$X$ and $Y$ are independent if and only if }
    \mathbb{P}[(X \rveq x) \cap (Y \rveq y)]
    = \mathbb{P}[X \rveq x] \times \mathbb{P}[Y \rveq y]$$ It follows that, if the events in the sample spaces that $X$ and $Y$ map _from_ are independent, then $X$ and $Y$ will be independent. So if $X$ is defined with respect to one iteration of an experiment, and $Y$ is defined with respect to another, physically independent iteration of that experiment, then $X$ and $Y$ are independent.

In the context of iid random variables, it is actually common to write "$X$" as referring to a whole set of random variables. Thus, $$X \stackrel{\text{iid}}{\sim} \mathcal{N}(\mu, \sigma^2)$$ actually means that there is some set of random variables $X_1$, $X_2$, $\ldots$; that $f_{X_i}(x) = f_\mathcal{N}(x; \mu, \sigma^2)$ for every $i$; and that $X_i$ and $X_j$ are independent for all $i \neq j$.

In day-to-day speech, we might say, "I draw $n$ values from this random variable $X$". Mathematically, this means, "Consider $n$ iid random variables distributed like $X$".

## Sums and products of random variables

If you know the cdf and pdf for a random variable $X$, and you also know these values for another random variable $Y$, you might be interested in the behavior of these two variables together. Say, for example, that I draw two random numbers from a normal distribution using a random number generation. What is the probability that their sum is above or below some threshold?

If $X$ and $Y$ are random variables, we define a new random variable $Z = X \stackrel{\mathrm{rv}}{+} Y$, where again, I put that little "rv" in there to remind you that the plus sign in $X + Y$, where $X$ and $Y$ are functions like random variables, cannot mean the same thing as the plus sign in $x + y$, where $x$ and $y$ are just numbers.

The meaning of $X + Y$ feels intuitive, like in my example about drawing numbers from a random number generator. But how do we define $X + Y$ mathematically? Imagine first that $X$ and $Y$ are independent, discrete random variables. Then it should be that $\mathbb{P}[Z = z]$ is the probability of $X = x_i$ and $Y = y_j$ for all the cases where $x_i + y_i = z$. Note that this, given some $z$, this constrains $y_j$ to by $z - x_i$: $$\begin{aligned}
f_Z(z) &= \sum_i \mathbb{P}[X=x_i] \mathbb{P}[Y=z-x_i] \\
  &= \sum_i f_X(x_i) f_Y(z - x_i).
\end{aligned}$$ A similar definition holds for when $Z = X + Y$ is continuous. Rather than summing over all the outcomes in which $X$ takes on certain values, we integrate: $$f_Z(z) = \int f_X(x) f_Y(z - x) \,dx$$

For a product of random variables $Z = XY$, we need to use $f_Y(z/x)$, and for a ratio of random variables $Z = X/Y$, we need to use $f_Y(zx)$. Note that, in each of these cases, the notations like $X + Y$, $XY$, and $X/Y$ refer to a new random variable and also give us a hint about how to compute its pdf.

## Don't expect the expected value

The _expected value_ $\expect{X}$ of a random variable $X$ is the probability-weighted average of the values it takes on. For a discrete random variable, you simply sum. For a continuous random variable, you need to integrate: $$\expect{X} \defeq \begin{dcases}
  \sum_i x_i f_X(x_i) & \text{ for discrete random variables} \\
  \int x f_X(x) \,dx & \text{ for continuous random variables}
\end{dcases}$$ Thus, just like "maximum", "expected value" is a function that maps random variables to numbers: $$\mathbb{E} : \text{random variables} \to \mathbb{R}$$ I use square brackets with $\mathbb{E}$ to emphasize that this is a function that maps from something other than numbers.

The name "expected value" is misleading. We previously noted that, for continuous random variables, the probability of getting any particular number is essentially zero, so there's no particular number you should "expect". For discrete random variables, where there is finite probability of getting each particular number, the expected value actually need not be any of the values that $X$ maps to. In our coin flip example, the random variable $X$ measuring the number of heads flipped has expectation value: $$\expect{X} = 0 \times \mathbb{P}[T] + 1 \times \mathbb{P}[H] = \tfrac{1}{2}.$$ You certainly don't ever expect to flip $0.5$ heads!

A better way to think of the expected value is as a measure of _central position_. There are of course multiple ways to quantify central position beyond the expected value, which is analogous to the mean or average. You can certainly map random variables to their medians and modes, but those mappings are substantially more complex and not as useful for our purposes.

## Variance

If the expected value is a measure of central position, then _variance_ $\mathbb{V}$ is the corresponding measurement of spread or _scale_. It is a function of random variables that returns a nonnegative number: $$\mathbb{V} : \text{random variables} \to [0, \infty).$$ For a random variable $X$, the variance is the expected value of the square of the deviation of the random variable from its own expected value: $$\var{X} \defeq \expect{(X - \expect{X})^2}$$ Because all those nested brackets are confusing, people often replace the notation $\expect{X}$ with the notation $\mu$ so that the definition of variance reads $\var{X} = \expect{(X - \mu)^2}$.

Although $\mu$ is just a number when we say $\mu = \mathbb{E}[X]$, the same notation "$\mu$" cannot refer to a number when we write $X - \mu$. We can subtract numbers from the values that a function maps to, but we cannot subtract numbers from raw functions, any more than I can subtract a number from the operation of multiplication. In other words, $f(x) - 2$ makes sense, but $f - 2$ does not. Thus, "$\mu$" in $X - \mu$ is actually a trivial random variable that maps its whole sample space to $\mu$, so that $\mathbb{P}[\text{``}\mu\text{''} = \mu] = 1$. Similarly, $(X - \mu)^2 = (X - \mu) \stackrel{\mathrm{rv}}{\times} (X - \mu)$ is another new random variable. Given random variables $X$ and $Y$, we saw earlier how to compute the pdf of a new random variable $XY$, so we also know how to find the pdf for a random variable $X^2 = X \times X$.

## Covariance

Starting with the definition of the expected value, you can easily show that it is a _linear_ function: $$\expect{aX + bY} = a \,\expect{X} + b \,\expect{Y}$$ Note that, just as $\mu$ transformed from a number to a random variable when we wrote $X + \mu$, so the number $a$ in this equation transforms into a random variable when we write $aX$.

Variance, however is not linear. You can easily show that, for some number $a$, $$\var{aX} = \expect{(aX - \expect{aX})^2} = \expect{a^2(X - \expect{X})} = a^2 \, \expect{X}.$$ With some more algebra, you can show that $$\var{X + Y} = \var{X} + \var{Y} + 2 \,\cov{X, Y},$$ where $\cov{X, Y}$, the _covariance_ of $X$ and $Y$ is $$\cov{X, Y} \defeq \expect{(X - \expect{X})(Y - \expect{Y})}.$$ To avoid the nested brackets, this is sometimes written $$\cov{X, Y} = \expect{(X - \mu_X)(Y - \mu_Y)}.$$ In words, the covariance is the expected value of the product of the deviations between the values that $X$ and $Y$ map to and the expected values of those random variables. Note that covariance is a function of two random variables: $$\mathrm{Cov} : (\text{random variables})^2 \to \mathbb{R}.$$

If $X$ and $Y$ are independent, then their covariance is zero. (The reverse is not necessarily true.) Some algebra will also show that $$\expect{XY} = \expect{X} \, \expect{Y} + \cov{X, Y}.$$ Thus, for independent random variables, which we will deal with a lot, the expected value of the produce of two random variables is simply the product of their expectation values. These properties of the expected value will come in very handy in future sections.

You may be more familiar with _correlation_ than covariance. The most common definition of correlation, Pearson's correlation coefficient, typically written $\rho$, is just a rescaling of the covariance to values between $-1$ and $+1$: $$\begin{gathered}
\rho : (\text{random variables})^2 \to [-1, 1] \\
\rho[X, Y] \defeq \frac{\cov{X, Y}}{\sqrt{\var{X} \var{Y}}},
\end{gathered}$$ It turns out that dividing by that factor rescales the covariance, which can be any number, to a single range, $-1$ to $+1$. Thus, the correlation between two random variables does not depend on their scaling: $$\begin{gathered}
    \cov{aX, bY} = ab \,\cov{X, Y} \\
    \rho[aX, bY] = \rho[X, Y]
\end{gathered}$$

## Higher moments

The expected value and the variance are two in a series of properties of random variables called _moments_. Just as the variance has a square in it, _skewness_ has a cube and _kurtosis_ has a fourth power. The pdf's of random variables with positive skewness have an asymmetric tail, trailing out to the right; negative skewness means a tail to the left. Kurtosis measures the "fatness" or "heaviness" of the tails.
