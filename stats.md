# Things to include

- Poisson as horse kicks
- Simulation in general
- Bayesian as the mystical: the only way to say the probability about the truth is to assert what you think is the truth
- Frequentist as a weird subset of the Bayesian
- Confidence intervals as confidence about how, if this is right, the future will unfold
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
