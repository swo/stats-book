# Things to include

- Poisson as horse kicks
- Simulation in general
- Bayesian as the mystical: the only way to say the probability about the truth is to assert what you think is the truth
- Frequentist as a weird subset of the Bayesian
- Variance (shape) as more important than mean (location). If you have variance, it's pretty easy to measure the mean and get a sense of things. If you have the other way, it's a lot more murky.
- Inference vs. decision-making under uncertainty. How are these two things different? (e.g., what's the "cost" of making an incorrect scientific conclusion?)


# Why a book?

## Construction

In a mathematical introduction, a random variable is a function that maps
events to some measurable space. This mathematical approach is powerful but not
intuitive. I think the contructivist approach is better: if you can say how
this thing would arise, I think you are in a better place as a scientist and
modeler (but not necessarily as a mathematician).

## History

I don't like that statistics textbooks present results like their are from
stone tablets: "And professor said, 'This is the correct test to use for this
kind of data.'" This approach insults the curiosity of students (who might also
want to learn some history), it blinds students to the possibility that we have
the approaches we have because of historical accident and the imperfections of
our forebears, and dulls their ability to reason and think statistically.

# Summary statistics

The mean is also called the *expectation value*, which gives a contemporary
English speaker a strange idea of what it is. The expectation value is *not* "a
value that you might expect". That is the *mode*. In certain cases, the mean
and the mode are the same, but this is often not true. This is why it is so
critical to look at the distribution of your data *before* selecting summary
statistics.

## The (arithmetic) mean

Everyone knows the average: take your numbers, sum them, and divide by the
number of numbers.

Why is this a good idea? Early thinkers in statistics---who thought about it
before it had a name---were curious about the same thing. The arithmetic mean
was computationally simple (i.e., you could do it will quill and parchment, OK,
pen and paper) and it seemed to "work", but why?

It turns out that the arithmetic mean has some nice properties for, you guessed
it, the normal distribution. In fact, we'll show that it is a certain kind of
"best way" to guess the true, population mean from our sample mean. (It's the
maximum likelihood estimator.)

## The "average"

In typical speech, we say something like, "The average family has two
children", by which we mean that a typical family has two children. This is
confusing because we also use the word "average" to refer to the arithmetic
mean. These two things are similar only in special cases, including (you
guessed it!) the normal distribution.

The arithmetic mean of number of children in families is somewhere between 2
and 3 (let's say 2.5), but it's clear that no "average family" has 2.5
children. Similarly, it's confusing that the mean salary in the US is whatever,
even thought that is above what whatever percent of people get paid.

## Mode, median, and percentiles

Typical can mean "common", so we might say, in a sense, that an "average"
family has two children. Of the number of children you can have (zero, one,
two, etc.), two is the most common, so that's "average". Technically, the most
common value is the *mode*. No one really talks about the mode except in stats
textbooks.

A more interesting number is the middle point. We might say that an average
American makes whatever because half of people make more and half of people
make less. This is the *median* (from Latin *medius*, meaning "middle").

It even feels natural to combine the median and mode ideas (have our median
cake and eat it a la mode?). We want a sense of what are "middling" numbers,
and we want a sense of what are "common" numbers. So you might ask what range
is covered by the most middle half of numbers.

Children are often measured against a growth chart, which shows *percentiles*:
if you are in the 25th percentile, you are taller than 50% of people. (The
median is just another name for the 50th percentile.) The range between the
25th and 75th percentiles, which covers the middle half of people, is the
*interquartile range*, because the 25th, 50th, and 75th percentiles are also
called the *quartiles*, because they divide the numbers into four quarters
(bottom quarter, bottom-middle, top-middle, and top).

## Mean, median, and mode are usually different

Roll a dice many times. What are the mean, median, and mode? Mean is easy: each
number is equally likely to come up, so we just take the mean of 1, 2, 3, 4, 5,
6, which is 3.5. The median is a little tricky here: it's between 3 and 4, and
when we hit this situation we normally define the median as the arithmetic mean
of the two middle values. So the median is also 3.5 here, but only because of
some convention. The mode is also confusing, since all numbers are equally
likely, which means that they are all equally the mode.

For the normal distribution, the mean, median, and mode are all the same. So
it's only in this very potentially unusual case that our intuition is correct
that that the "average" value, in the sense of something common (i.e., the
mode), is the same as the "average" value, in the sense of something middling
(i.e., the median), is the same as the arithmetic mean.

Historical box for Quetelet: the idea of an "average person" is directly
traceable to a particular proto-statistician, who is remarkable for having
believed that almost *everything* was normally distributed. At the time, they
only had very rudimentary methods for determining if something was normally
distributed (basically, eyeballing it), and there were very appealing
aesthetic/philosophical reasons to believe that almost everything was normally
distributed, so he believed that too.

# *t*-test

## Equal variance

The (old school) *t*-test is two sample, assuming equal variances. We're
interested in the difference in the means between the two populations.

The null hypothesis is that we're drawing $n_1 + n_2$ samples from a population
that has this equal variance, and that the labels on the two "populations" are
just fictitious.

Our estimator $s_p^2$ for the pooled variance is just the average of the variances of
the two "populations", weighted by $n_i - 1$ (which is a better estimator than
weighting by just $n_i$):
$$
s_p^2 = \frac{(n_1 - 1) s_1^2 + (n_2 - 1) s_2^2}{n_1 + n_2 - 2}.
$$

The thing we're observing is the difference between the mean of $n_1$ samples
from a (potentially ficitious) variable $X_1$ and $n_2$ from $X_2$:
$$
\overline{X}_1 - \overline{X}_2 = \frac{1}{n_1} \sum_{i=1}^{n_1} X_{1i} - \frac{1}{n_2} \sum_{i=1}^{n_2} X_{2i}.
$$
It would be nice if our statistic was distributed like $\mathcal{N}(0, 1)$, so
we compute the variance of this observation:
$$
\begin{aligned}
\mathrm{Var}\left[ \overline{X}_1 - \overline{X}_2 \right]
  &= \frac{1}{n_1^2} \sum_i \mathrm{Var}[X_1] + \frac{1}{n_2^2} \sum_i \mathrm{Var}[X_2] \\
  &= \frac{1}{n_1^2} n_1 s_p^2 + \frac{1}{n_2^2} n_2 s_p^2 \\
  &= \left( \frac{1}{n_1} + \frac{1}{n_2} \right) s_p^2.
\end{aligned}
$$

So the statistic for this test is just the observation over its variance:
$$
t = \frac{\overline{X}_1 - \overline{X}_2}{s_p \sqrt{\frac{1}{n_1} + \frac{1}{n_2}}}.
$$

The confusing thing is that $\overline{X}_1$, $\overline{X}_2$, and $s_p$ are
all random variables. We know how to take the sum (or difference) of two random
variables (i.e., how to figure out the distribution of the numerator), but
it's not immediately obvious how to find the distribution of the whole thing,
which has a different random variable in its denominator.

### Computational approach

- Compute the observed $t$ statistic
- Compute the observed sizes, means, and standard deviations for the two sample populations
- Many times, generate two sets of random variates. One set of variates is drawn from a normal distribution with the first sample mean and variance.
- For each iteration, compute the simulated $t$ statistic.
- The empirical $p$-value is the fraction (not true! need $r+1/n+1$) of simulated statistics that are greater than the observed statistic.

## Unequal variance (Welch's)

Do the math for this one!

# anova

Say you have some (equally-sized) groups. Each group was drawn from a normal
distribution (all with the same variance). Are the data consistent with the
model in which all those groups have the same mean?

The statistic is $F \equiv \frac{\mathrm{MS}_B}{\mathrm{MS}_W}$, where $MS_B$
is the mean of the squares of the residuals(?) between the group means and the
grand mean ("between") and $MS_W$ is the mean of the squares of the residuals
between the data points and the group means ("within").

Again, focus on what's the population we're sampling from. It's easy to think
about a finite population, where you can just do all the possible combinations
and compare their $F$ statistics. Then move on to say that, if you believe that
the particular variances and means you measured are the exact, true
distribution that you're sampling from, ask what happens when you sample from
that infinite population.

## z-test example

What's the nonparametric equivalent of this? It's just saying what the
empirical cdf is! Then say, if you really truly believe your mean and standard
deviation, then you can do that.

In other words, you say you are absolutely sure what population you are drawing
from. The same is actually true of the *t*-test, except that the *z*-test is
asking about a single value, distributed like $N(\mu, \sigma^2)$, while the *t*-test
is about the mean of the $n$ points, which is distributed like $N(\mu, \sigma^2/n)$.

# Paired differences

## Historical example and motivation

Darwin's thing with the pots, as described in Fisher's *Design of Experiments*

We'll make a tower of the kinds of assumptions made to test Darwin's hypothesis.

## Sign test

Assume that it's meaningful if a hybrid plant is taller than a self-fertilized
plant, but don't assign any meaning beyond that. Then the data are effectively
dichotomized: you get some number of cases in which one is taller and some
number of cases in which the other is taller.

This is now just a binomial test.

## Rank test (Mann-Whitney *U*)

Assume that the *ranks* of the differences are meaningful.

## Fisher's weird sum test

Not sure if there's any name for this. Assume that the actual values of the differences are meaningful.

## Welch's *t*-test

Assume that the two populations are normally distributed and, and therefore
that that the variances of the populations are meaningful. Then you can infer
where this set of differences would stand in an infinite set of such
differences.

For early statisticians, this was really appealing, mostly from a computational
point of view: you could actually compute the mean and standard deviation with
pen and paper in a reasonable amount of time, but you definitely couldn't do
all $2^n$ different ways of taking sums. Fisher does it for one example in his
book, and I'm sure it was pretty crazy. He makes it clear that he went to great
lengths to do it, and his conclusion is that the results are basically the
same, so you should probably be doing the easier thing and not worry about it.
Nowadays it's gotten pretty easy to do the other thing!, so it's

# Wilcox test and Mann-Whitney test

There a few different names for these things:

- One-sample test: is this distribution symmetric about zero (or whatever)?
- Two-sample unpaired (independent; Mann-Whitney): does one of these distributions "stochastically dominate" the other (i.e., is it that a random value drawn from population $A$ is more than 50% probable to be greater than a random value from $B$)?
- Two-sample paired (dependent): are the differences between paired data points symmetric about zero?

## Wilcoxon

1. For each pair $i$, compute the magnitude and sign $s_i$ of the difference. Exclude tied pairs.
1. Order the pairs by the magnitude of their difference: $i=1$ is the pair with the smallest magnitude. Now $i$ is the rank.
1. Compute the $W = \sum_i i s_i$.

Thus, the bigger differences get more weight.

(There might be a way to do a visualization of this: as you walk along the data
points, you get a good bump for every rank that is in the "high" data set, and
you get a bad hit for every rank that is not. Then it settles out pretty
quickly, and you want to know the meaning of the final intercept.)

For small $W$, the distribution has to be computed for each integer $W$. For
larger values ($\geq 50$), a normal approximation works.

Compare the sign test, which does not use ranks, and which assumes the median
is zero, but not that the distributions are symmetric. That's just a binomial
test of the number of pluses or minuses you get. It's like setting the weights,
which in $W$ are the ranks, all equal.

## Mann-Whitney

1. Assign ranks to every observation.
1. Compute $R_1$, the sum ranks that belong to points for sample 1. Note that $R_1 + R_2 = \sum_{i=1}^N = N(N+1)/2$.
1. Compute $U_1 = R_1 - n_1(n_1+1)/2$ and $U_2$. Use the smaller of $U_1$ or $U_2$ when looking at a table.

At minimum $U_1 = 0$, which means that sample 1 had ranks $1,2,\ldots,n_1$. Note that $U_1 + U_2 = n_1 n_2$.

For large $U$, there is a normal distribution approximation.

### Generation

Say you have $N$ total points and $n_1$ in sample 1. Find all the ways to draw
$n_1$ numbers from the sequence $1, 2, \ldots N$. Compute $U$ for each of
those. Voila.

Note that, if you fix $n_1$, then you don't have to subtract the $n_1(n_1+1)/2$
to get the right $p$-value.

# Cochrane-Armitage test

A $\chi^2$ tests for *any* difference between the cell values and the expected.
This test asks whether there is some kind of pattern. Essentially, this is a
weighted binomial.

Each flip $y_i$ gets some associated weight $w_i$. The naive statistic is
$\sum_i w_i y_i$. It would be nice to have this be zero-centered:
$$
\sum_i \left\{ w_i y_i - \mathbb{E}\left[ w_i y_i \right] \right\} = \sum_i w_i (y_i - \overline{p}),
$$
where $\overline{p} = (1/N)\sum_i y_i$.

It would also be nice for this to have variance 1, so we can divide by the square root of
$$
\mathrm{Var}\left[ \sum_i w_i (y_i - \overline{p}) \right] = \overline{p} (1-\overline{p}) \sum_i w_i^2
$$
to produce the statistic
$$
T = \frac{\sum_i w_i (y_i - \overline{p})}{\sqrt{\overline{p} (1-\overline{p}) \sum_i w_i^2}}.
$$

You could also conceive of this being a table with two rows and some number of
columns. We bin the trials by their weights: all trials with the same weight
are in the same column. Successes go in the top row; failures in the bottom.
Now write $t_c$ as the weight of the trials in the $c$-th column, $n_{1c}$ is
the number of successful trials with weight $t_c$ (i.e., in column $c$), and
$n_{2c}$ is the number of failures. Then some math shows that you can rewrite $T$ as
$$
T = \frac{\sum_c w_c (n_{1c} n_{2\bullet} - n_{2c} n_{1\bullet})}{\sqrt{(n_{1\bullet} n_{2\bullet} / n_{\bullet\bullet}^2) \sum_c n_{\bullet c} w_c^2}}
$$
where $n_{r\bullet}$ are the row margins, $n_{\bullet c}$ are the column
margins, and $n_{\bullet\bullet}$ is the total number of trials.

*N.B.*: The wiki page gives a different answer, but I don't trust it, since the
variance formula doesn't assume independence of the $y_i$. A fact sheet about
the PASS software that shows the formula in terms of the $y_i$ seems to make a
mistake by using $i$ as an index both for individual trials and for the weight
categories.

The confusing thing here is how to pick the weights. This test is mostly used
to look for linear trends: imagine that each $y_i$ is associated with some
$x_i$, so that the weights would be $x_i$ or $x_i - \overline{x}$. Why you pick
these exact weights has to do with the *sensitivity* of the test.  There could,
of course, be a nonlinear trend, like a U-shape, that would lead to a zero
expectation for this statistic. The $\chi^2$ test can find that, but
Cochrane-Armitage with these weights cannot.

To see why you use those weights for a linear test, imagine that
$p_i \propto x_i$, and zero-center the $x_i$ such that $p_i = m x_i + \overline{p}$.

Then the question is what $w_i$ maximize $\mathbb{E}[T]$? You can quickly see
that this is equivalent to maximizing $\sum_i w_i x_i / \sqrt{\sum_i w_i^2}$, and
taking a derivative with respect to $w_j$ shows that, at the extremum,
$x_j \sum_i w_i^2 = w_j \sum_i w_i x_i$, which $w_i = x_i$ for all $i$ satisfies.
So those weights are the best way to get a large statistic if you think that
there actually is a linear test.

# Estimators

## Motivating example: uniform distribution

Consider a uniform distribution from zero up to some number $B$. What's the
maximum of this distribution? Well, if you know it, it's easy: it's just $B$.
It's also easy if you can sample a zillion times from the distribution: you are
very likely at some point to get a value very close to $B$, so you can just use
that as your estimate.

But what if you only drew one point? Then clearly the maximum of the drawn
values, just that point, is a pretty bad estimate for the upper limit. If you
draw 3 points, then the maximum is a little better, but you can feel pretty
sure that estimating the *population* maximum using your *sample* maximum is
biased: you're always going to underestimate the population maximum.

When we use our data to make a guess about a population parameter, that's an
*estimator*. (Good name.) We say that an estimator that we expect to not be
"systematically"[^systematically] above or below the true value is *unbiased*.
Estimators are typically written with a hat (because you
use a cone hat to communicate with the mothership?), so $\hat{B}$ is an
estimator for $B$. Of course, there isn't just one estimator for a value. I
know plenty of people who are perfectly happy to guess that 3 is the right
answer in statistics, so for them we might write $\hat{B} = 3$. (This is
clearly a bad estimator, but we'll get to what "bad" means later.)

[^systematically]: Why the scare quotes? Like in all frequentist statistics,
  we're stuck with assuming that we know the truth, finding the best answer
  knowing the full truth, and then pretending we didn't know the truth in the
  first place. So "systematically" is going to mean: assume you know the true
  value, evaluate the behavior of the estimator knowing the truth, and then
  forget you know the truth.

Estimators usually get subscripts to differentiate them from one another, so
I'll write our naive estimator as:
$$
\hat{B}_1 = \max_i X_i,
$$
where I called it "1" because it was our first guess, and I called the variables
we're drawing from the uniform distribution as $X_i$.

$\hat{B}_1$ is clearly *biased*: we will always get a smaller value than the
true $B$. Mathematically, we might write $\mathbb{E}[\hat{B}_1] < B$.

Because it feels natural to expect that the expected value of your estimator
will be the true value, an estimator $\hat{B}$ for which $\mathbb{E}[\hat{B}] = B$
is called *unbiased*.

### Unbiased estimators

Let's try to salvage our naive estimator $\hat{B}_1$ and make an unbiased
estimator $\hat{B}_\mathrm{ub}$ instead.

Where to start? It's likely that there are many unbiased operators, so we need
to pick the form of the operator we want to look for. It seems likely that all
our observed $X_i$ only have two interesting things about them: their maximum,
and how many of them there are. Like we said before, if we have very many $X_i$,
we expect that their maximum (I'll write it as $M \equiv \max_i X_i$) approaches
$B$:
$$
\lim_{n \to \infty} M = B,
$$
where $n$ is the number of the $X_i$ I drew.

It's also sufficient to just keep the maximum $M$ and ignore the values of all
the other points. If my first draw was $1.0$, then I don't learn that much if I
draw $0.1$ the next five times, because I know that $B > 1.0$, and so it's just
as likely that I drew $0.1$ and $1.0$. If I draw many values below $1.0$, I
only learn that the maximum is probably not far above $1.0$, which is already
encoded in the number of points $n$.

So I want $\hat{B}_\mathrm{ub}$ to be some function of $n$, which is fixed, and
$M$, which is a random variable, such that $\mathbb{E}[\hat{B}_\mathrm{ub}] = B$.
That will require knowing the distribution of $M$.

The cumulative distribution function, the probability that the observed maximum is
less than some $m$, is just the probability that there is no point that is above $m$:
$$
F_M(m) = \mathbb{P}[M \leq m] = \mathbb{P}[X_i \leq m \text{ for all } i] = \left( \frac{m}{B} \right)^n.
$$
Then we compute the probability density function:
$$
f_M(m) = \frac{d}{dm} F_M(m) = \frac{n}{B} \left( \frac{m}{B} \right)^{n-1},
$$
from which we compute the expected value of $M$:
$$
\mathbb{E}[M] = \int_0^B m \, f_M(m) \, \mathrm{d}m = \frac{n}{n+1} B.
$$

Interesting, the expected value of $M$ is just a multiple of $B$. Consider that
if $n=1$, you just draw one point, the expected value of the maximum, which is
just that value you drew, is $\tfrac{1}{2} B$. Makes sense: you're likely to
get something right in the middle.

If you draw 2 points, the expected maximum if $\tfrac{2}{3}B$, somewhat closer
to $B$. It's easy to see that as $n$ increases, $\mathbb{E}[B]$ approaches $B$,
just as we reasoned about before doing any math.

Now, by linearity of expectation, I know that
$\mathbb{E}\left[\tfrac{n+1}{n} M \right] = B$, so lo! I have found an unbiased estimator:
$$
\hat{B}_\mathrm{ub} = \frac{n+1}{n} M.
$$

### Maximum likelihood estimator

It's nice that we found an unbiased estimator, which we think is "good" in the
sense that we're not systematically off in one direction or the other. In one
way this is comforting, but it isn't foolproof. Imagine you're working with a
bimodal distribution: it tends to give small numbers or big numbers. Then an
unbiased estimator splits the difference, potentially estimating values that
aren't even possible!

For this reason, it's useful to think about *maximum likelihood* estimators (or
MLEs, if you're into that sort of acronym). "Maximum likelihood" means that,
given the *observed* value, you find the *true* value that, if it were true,
would be most likely, out of all the other true values, to give rise to your
data.[^mle]

[^mle]: Did that sound crazy? If so, get excited about the Bayesian section of
  this book. In there we'll show that there's a mathematically precise way to
  show that this kind of thinking---saying that the most likely state of nature
  given our data is the state of nature that, of all states of nature, was most
  likely to produce the data we observed---is coherent only under some pretty
  strong assumptions about the universe.

In other words, given the observed $M$, what $B$ would have given
rise to that $M$ with the greatest probability? Mathematically we write
$$
\hat{B}_\mathrm{ML} = \max_B \mathbb{P}[M | B],
$$
where "MLE" stands for "maximum likelihood".[^mle2] This should be a piece of
cake, since we already found the probability density function for $M$, which is
a function of $B$. It's easy to see, just by inspection, that the value between
zero and $B$ for which $m$ maximum $f_M(m)$ is just $B$. In other words,
$\hat{B}_\mathrm{ML} = M$.

[^mle2]: The promised Bayesian result is that the $B$ that maximizes
  $\mathbb{P}[M | B]$, the probability of the data given the state of nature,
  is also the $B$ for which $\mathbb{P}[B | M]$, the "probability of the state
  of nature" given the data, is maximum, although that's only true under a
  specific, and pretty hard-to-believe, criterion. I put more scare quotes here
  because, as mentioned before, if probability is a frequency, it doesn't make
  sense to talk about the probability of a state of nature.

You may have noticed that this is the same estimator that I previous denigrated
as "naive" and "biased". To be clear, this is the maximum likelihood estimator:
you know that $\hat{B}_\mathrm{ML}$ can't be any less than $M$, since the upper
bound must be at least as high as the biggest data point we observed, and some
careful thought shows that $\hat{B}_\mathrm{ML}$ can't be any greater than $M$,
since hypothetically increasing $B$ above $M$ just decreases the probability
that you would have observed $M$ as the maximum value.[^hypo]

[^hypo]: Imagine hypothetically increasing $B$ to a zillion times $M$. Clearly,
  observing that small of an $M$ is given that large of a $B$ is unlikely, and
  there's no "cut point" so that an infinitesimal increase is reasonable but a
  zillion-fold increase is not.

So this example tells an interesting lesson: it's not the case that an
estimator that is "good" in one sense (e.g., unbiased) will be "good" in
another sense (e.g., maximum likelihood). We'll show that there's a special
case in which that's true. (Can you guess what it is? No really, try. Or, don't
try, and just say the first probability distribution that comes to mind.)

**German tank problem** as an exercise.

## The tyranny of the normal, part XLIV

You get some data points from a normal distribution (I hope you guessed it),
and you're interested in the mean and standard deviation of that distribution
(because those are the only things to know about).

What is the maximum likehood estimator for the mean? In other words, given your
data points $x_i$, what $\mu$, among all the other $\mu$, would have given rise
to these particular data with the greatest probability?
$$
\begin{aligned}
\hat{\mu}_\mathrm{ML}
  &= \mathrm{argmax}_\mu \, \prod_i \mathbb{P}[X_i = x_i] \\
  &= \mathrm{argmax}_\mu \, \prod_i \frac{1}{\sqrt{2 \pi \sigma^2}} \exp\left\{ -\frac{(x_i - \mu)}{2\sigma^2} \right\} \\
  &= \mathrm{argmax}_\mu \, \left(2\pi\sigma^2\right)^{-\frac{n}{2}} \exp\left\{ \sum_i -\frac{(x_i-\mu)^2}{2\sigma^2} \right\}
\end{aligned}
$$

At this point, it's nice to pull a little trick: the value $x$ that maximum a
function $f(x)$ is the same value that maximizes $\log f(x)$. In other words:
$$
\mathrm{argmax}_x f(x) = \mathrm{argmax}_x \log f(x).
$$
This turns the nasty exponent into a sum:
$$
\hat{\mu}_\mathrm{ML} = \mathrm{argmax}_\mu \left\{ -\frac{n}{2} \left(2 \pi \sigma^2\right) - \frac{1}{2\sigma^2} \sum_i (x_i-\mu)^2 \right\}.
$$
It's pretty clear that we'll need to do something about $\sigma$ at some point:
if $\sigma$ is too big, then the first term blows up, and the whole thing goes
negative, which is not great for the argmax. If $\sigma$ is too small, then
second term blows up. Whatever we pick $\sigma$ to be, it's clear that that choice
is independent of the one we should make for $\mu$, since we should just pick a
$\mu$ that minimizes $\sum_i (x_i - \mu)^2$.

Is this starting to look familiar? The $\mu$ that minimizes this sum is the one
that solves:
$$
0 = \frac{d}{d\mu} \sum_i (x_i - \mu)^2 = \sum_i -2 (x_i - \mu) = -2 \left( \sum_i x_i - \sum_i \mu \right),
$$
which implies that $\sum_i x_i = n\mu$, that is, $\mu = \tfrac{1}{n} \sum_i x_i$.
It's just our old, dear friend, the arithmetic mean.

### Gauss-Laplace synthesis

If you're not shocked by what just happened, you have no heart. If you *are*
shocked, then you're in good company: the realization that the normal
distribution is the distribution for which the arithmetic mean is the maximum
likelihood estimator was part of the "Gauss-Laplace synthesis".
In 1809, Gauss published a book about "least squares estimation", a method for picking a
"best fit" estimate to data by minimizing the squares of the deviations from
the arithmetic mean (i.e., minimizing $\sum_i (x_i - \mu)^2$), was a "good"
guess for the "true" value of the mean, where "good" meant that it was
relatively easy to do my hand and seemed to work right.

In the same book, Gauss worked with the normal distribution, which had
previously been cooked up by Laplace, and showed how you could use it as a
model for measurement errors. (Gauss's work with the normal distribution so
overshadowed Laplace's original description that we now call the normal
distribution "Gaussian", and "Laplacian" refers to a different distribution.)

In 1810, Laplace showed that the normal distribution arises as the sum of many
random variables **see somewhere**. Later that year, he read Gauss's book from
1809, and he was **get the quote**. In that moment, Laplace realized that the
reason that the arithmetic mean always seemed so nice, and the reason that
least squares seemed to work so well, was because the normal distribution's
fundamental property causes it to arise in so many places, and **clean up this
section**.

### End of historical note

As you might guess, the arithmetic mean is also the unbiased estimator for the population mean:
$$
\mathbb{E}[\mathrm{\mu}] = \mathbb{E}\left[\frac{1}{n} \sum_i X_i \right] = \frac{1}{n} \sum_i \mathbb{E}[X_i] = \mu.
$$

**Is this really all that special, then?**

## Variance

One estimator is used so often that it's often not even explained as an
estimator, or even called an estimator, which is very confusing. Imagine if
someone said that the definition of a maximum of a set of points was
$\tfrac{n+1}{n}$ times the biggest value. Crazy, right? If you agree, then
you're well prepared.

The definition of sample variance is the average square deviation from the mean:
$$
s^2 \equiv \frac{1}{n} \sum_i (x_i - \overline{x})^2,
$$
where $\overline{x}$ is just the normal arithmetic mean. Because we're used to
estimators, it's a nice question to ask, is this a "good" estimator of the true
variance $\sigma^2$?

**Some math** will show that $\mathbb{E}[s^2] = \tfrac{n-1}{n} \sigma^2$, that
is, that the sample variance is a biased (underestimating) estimator for the
true variance. Happily, it requires merely multiplying by $\tfrac{n}{n-1}$
(called "Bessel's correction"), so that the unbiased estimator is:
$$
\hat{\sigma^2} = \frac{1}{n-1} \sum_i (x_i - \overline{x})^2.
$$

This estimator is so commonly used that it is often simply referred to as
"sample variance", leaving students to wonder why the variance is one thing for
"true distributions" and another thing for samples. To be clear, the sum of
square deviations divided by $n-1$ is an unbiased *estimator* for the
population variance.

Unfortunately, the words "sample variance" are used to refer to the actual
sample variance (sum of square deviations divided by $n$) as well as to this
estimator. There's often no way to tell. I'm sorry. You should probably guess
that people mean the $n-1$ denominator *estimator*, and you should probably
guess that most people won't know the difference.[^comfort]

[^comfort]: Comfortingly, as $n$ grows, the difference between the sample
  variance and the "sample variance" becomes negligible.

# Confidence intervals

Confidence intervals are very slippery things. It's tempting to say that "I am
95% confident" that the true value of a quantity lies within the 95% confidence
interval. In frequentist statistics, "I am *X*% confident" has no meaning. The
probability that the true value lies within an interval is either 0 or 1, since
if you repeat the world-experiment many times, the true value will always be
the same.  In other words, "confidence" is a Bayesian notion of probability.
The interval that you are 95% confident that something falls in is therefore a
Bayesian concept (and it gets the confusing name of "credible interval"). So
forget that "confidence interval" has anything to do with confidence.

Here's how things actually work:

1. You get some data that has some parameters (e.g., a sample mean and sample variance).
1. You *guess* that your observed sample mean and variance are the *true* mean and variance.
1. You ask, "If someone else sampled from this true distribution many times, and they got all kinds of sample means and variances, what method could they use to construct, from the values they observed, an interval that would, in 95% of cases, include the true value?"
1. Then you forget that you are omniscient and know the true value and instead use the methodology that these ignorant people would use, but you use it on your own data.

Now the crazy Bayesian switch comes in: you conflate the frequency of cases
with your confidence that you are in the 95% of cases.

*N.B.*: For the *t*-distribution, there's this "pivotal quantity" thing, which
means that the true $\mu$ and $\sigma$ drop out, which is very luck, and it
means that we *don't* need to make a parametric assumption about how things
work.

## *t*-distribution

Let's think about how to construct that method. Say you knew the true variance
$\sigma^2$. Then we know that the sample means are drawn from $\mathcal{N}(0, \sigma^2/n)$.
So it's pretty easy to see that $(\overline{x} - \mu) / (\sigma^2) \sim \mathcal{N}(0, 1)$,
from which the familiar $1.96$, etc. come.

What if you *don't* know the true variance? The means are still drawn from $\mathcal{N}(0, \sigma^2/n)$,
but now the sample variance is also a random variable.

We know the confidence interval is some function of the sample mean and
variance, and let's guess that it's symmetric about the sample mean and is some
linear function of sample variance:
$$
\mathrm{CI}_\pm(\overline{x}, s) = \overline{x} \pm A s.
$$
We want to find $A$ such that
$$
\mathbb{P}\left[ \mathrm{CI}_- < \mu < \mathrm{CI}_+ \right] = 95\%,
$$
or, if we're willing to trust in symmetry,
$$
2.5\% = \mathbb{P}\left[ \mathrm{CI}_- > \mu \right] = \mathbb{P}\left[ \frac{\overline{x} - \mu}{A} - s > 0 \right].
$$
We know the distribution of the first thing:
$$
(\overline{x}-\mu)/A \sim \mathcal{N}\left(0, \frac{\sigma^2}{n A^2}\right).
$$
Some math shows that
$$
\frac{(n-1) s^2}{\sigma^2} \sim \chi^2(n-1).
$$

Call the first thing $K$ and the second $L$. We're interested in the
distribution of $M \equiv K - L$:
$$
f_M(m) = \int_0^\infty f_K(m + l) f_L(l) \,\mathrm{d}l,
$$

where the limits come from the fact that variance is positive. You're probably
not excited to do this integral, which was considered a major achievement
(well, it was the thought leading up to the integral, which we've just
outlined, but whatever). This major achievement was made by William Sealy Gosset,
who made it while he was a researcher for Guinness ensuring the quality of their beer. Guinness had a policy of not allowing its employee to publish their results, so Gosset signed his paper "a student", so the result of that integral is now called Student's *t*-distribution:
$$
f_t(x; \nu) = \frac{\Gamma(\frac{\nu+1}{2})}{\sqrt{\nu\pi} \Gamma\left(\frac{\nu}{2}\right)}
  \left(1+ \frac{x^2}{\nu}\right)^{-\frac{\nu+1}{2}},
$$
where the (badly named) "degrees of freedom" $\nu$ is $n-1$ for our purposes. I
write this out fully because it is one of the things we will *not* derive in
this book.

# Bayesian

One of the biggest sticking points about a Bayesian analysis is that it requires specification of a prior.
It can be thought of as an advantage or a disadvantage, but I think it's better to think of it as a responsibility.
Let me tell you an allegory.

Once, a young statistician lived in her parents' house. She paid no rent and simply never considered her orientation in the world.
Some year later, she left the home and had to do statistics in the wide world.
Where would she live? How would she pay rent?
These decisions brought power, since she was free to do things she couldn't do at home.
She could live a life that was more accurate to the real world.
This allegory is too long and rambly. But there's something in here.

Frequentist statistics is correct so long as you use it exactly for what it is designed to do.
The trouble is that we *want* statistics to answer the kinds of questions that *only* Bayesian statistics can answer.
For example, how likely is it that this hypothesis is true?
If you perfectly adhere to the frequentist interpretation, then you are in good shape.
But if you deviate, if you start to say, "Oh, the p-value is kind-of like the probability my hypothesis is false."
Then you have SCREWED UP son.
