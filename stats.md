---
header-includes:
    - \usepackage{bm}
---

# Things to include

- Poisson as horse kicks. Or as drops with cells (a la Weitz, etc.)
- Simulation in general
- Bayesian as the mystical: the only way to say the probability about the truth is to assert what you think is the truth
- Frequentist as a weird subset of the Bayesian
- Variance (shape) as more important than mean (location). If you have variance, it's pretty easy to measure the mean and get a sense of things. If you have the other way, it's a lot more murky.
- Inference vs. decision-making under uncertainty. How are these two things different? (e.g., what's the "cost" of making an incorrect scientific conclusion?)
- Simpson's paradox: why two-way associations are confusing
- Random number generation
- Most textbooks are boring, and they just present a parade of stuff. I want to use those things that are probably familiar as entry points for learning. E.g., the difference between descriptive statistics and inferential statistics is what those statistics are used for. In one, they are used a estimators of population parameters. In the other, they are summed over the ask about the likelihood of data.
- ABC as super hacky thing!
- Finite population correction: $\sigma_{\overline{X}} = \frac{\sigma}{\sqrt{n}} \sqrt{\frac{N - n}{n - 1}}$
- Wilk's theorem for likelihood ratio tests

## Game plan

- What do I want people to be able to end up doing at the end? Probably come up with their own tests, and derive anything about it.
- For tests, two goals: first to understand where the "classic" tests come from, and second, and more important, to show how you can manipulate them.
- Maybe put the derivations in an appendix or something.

## Audience

- People who know something about numbers
- Probably practicing scientists, like graduate students, who are interested in the conceptual origins of some stuff
- *Not* for people with no statistics, or people who are interested in the deep maths
- Something about statistical thinking, rather than turning the crank
- Maybe with a focus on the biological sciences, since we are the ones that are often dealing with complex data and situations, or at least because that's my area of expertise
- Something between the babying Stats 101 and the hardcore, math-focused statistics textbook. Neither a plug-and-chug practitioner's guide to statistical tests nor a derivation of everything in mathematically robust terms.

Inspirations include Learn You a Haskell and think Stats.

## Titles

- Stats for people who already know something about numbers
- Stats on the fly
- Learn you a stats for great good
- An engineering approach to statistics

# GEE notes

The estimator for the covariance matrix of the estimator for the parameters
$\bm{\theta}$ has typical element
$$
\widehat{\mathrm{Cov}}[\hat{\bm{\theta}}]_{i,j} =
  \left[ \left( -\frac{\partial^2 \mathcal{L}}{\partial \theta_u \, \partial \theta_v} \right) \right]^{-1}_{i,j}.
$$
The inverse is a matrix inverse. This is weird notation.

For example, consider the easy case with just one parameter, so that
$$
\widehat{\mathrm{Var}}[\hat{\theta}] = 
  -\left( \frac{\partial^2 \mathcal{L}}{\partial \theta^2} \right)^{-1}.
$$

Then try the easy example where we're looking at the sample mean, which is
the estimator $\hat{\mu}$ for some population with unknown mean $\mu$ and
known variance $\sigma^2$. Then the log likelihood is
$$
\mathcal{L}(\theta) = \sum_i \left\{ -\frac{1}{2} \log (2 \pi \sigma^2) -
  \frac{(x_i - \mu)^2}{2 \sigma^2} \right\}
$$
and the second derivative is just
$$
\frac{\partial^2 \mathcal{L}}{\partial \mu^2} = -\frac{n}{\sigma^2},
$$
from which it's clear that
$\widehat{\mathrm{Var}}[\hat{\mu}] = \sigma^2/n$. This is just the result
that we got from our more straightforward approach, where we asked about
the variance of the estimator, before we had called it that.

Note, however, that this estimate depends on $\sigma^2$, the *true*
population variance. In an exercise, you'll compute the estimator
covariance matrix for the estimator of $\bm{\theta} = (\mu, \sigma^2)$.
That will show that there is some estimated covariance between
$\hat{\mu}$ and $\hat{\sigma}^2$, but you find that each of
$\widehat{\mathrm{Var}}[\hat{\mu}]$, 
$\widehat{\mathrm{Var}}[\hat{\sigma}^2]$, and
$\widehat{\mathrm{Cov}}[\hat{\mu}, \hat{\sigma}^2]$ depend on the
true values, not on the estimates themselves. This isn't unreasonable:
each of these thing is a well-defined random variable that will have a
real, honest, true distribution, and we're deriving its properties.
Clearly the true properties of these random variables should depend on
the true values, but it leaves us in a pickle when we're doing estimation:
when computing the standard errors on our estimators, we need to use
our points estimates as the true values!

**Relationship between "sampling distribution" and estimator. "Standard
error" as SD of sampling distribution OR estimate of standard deviation.**

# Why a book?

## Personal

This is all the stuff that I felt like I didn't know after a few stats classes
in college. It's gaps that didn't get filled in.

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

# Intellectual tools

To understand the stuff in this book, you'll need three major toolkits:
algebra, probability, and optimization. These aren't what statistical thinking
is about, but they are really handy ways to talk about what we'll learn.

# Probability

This part will have some math jargon, but you can handle it.

In probability, we're interested in a *sample space* of *outcomes*. If I'm
drawing a card from a shuffled deck, the outcomes are each of the 52 cards I
could draw. Outcomes get combined into *events*, like "drew a red card". Every
outcome has an associated *probability*, usually written $P$, always in the
range $[0, 1]$, and each event has a probability that is the sum of the
probabilities of its constituent outcomes. Of the 52 cards in the deck, 26 are
red, and the probability of drawing any particular card is $\tfrac{1}{52}$, so
the probability of drawing a red card is $\tfrac{26}{52} = \tfrac{1}{2}$.

There is a sophisticated mathematical theory about outcomes, events, and
probabilities called *measure theory*. The simple definitions I gave here are
not sufficient for a complete theory of probability[^measure], but they will work well
enough for our purposes.

[^measure]: For example, what's the probability of flipping heads on a fair an
  infinite number of times? To say "zero" makes it sound like it's impossible,
  but to say anything other than zero is even more confusing.

The really interesting quantity here is "probability". In math world,
probability is just an abstract concept. In the real world, it's something that
we think about every day. For the first part of the book, we'll use the
*frequentist* definition of probability: if an event has probability $p$, it
means that, if we repeated whatever situation led to the possibility of that
event very many times, the proportion of situations leading to that event would
approach $p$. For example, if I flip a fair coin very many times, I expect the
proportion of heads to approach $\tfrac{1}{2}$, so the "probability" of heads
is $\tfrac{1}{2}$.

This frequentist definition will lead us into confusing problems later on,
which will lead to the other major definition of probability, *Bayesian*
probability[^bayes1], which is a subject of a later chapter.

[^bayes1]: The fundamental notion in Bayesian probability is that "probability"
  should mean something about confidence. Intuitively, we say that
  "probability" of heads is $\tfrac{1}{2}$ not because we're thinking of an
  infinite number of flips, but because we think that heads is 50% "likely".
  (Confusing, "likelihood" has a specific technical definition that we will get
  to later.) The problem in frequentist probability is that some things cannot
  be expressed as frequencies of many repeated trials. See the Bayesian chapter
  for more.

## Manipulating probabilities

A core concept that presented a lot of theoretical confusion in the development
of statistics is *conditional probability*: what is the probability of $A$
"given that" $B$ is true?

This feels like a natural concept: given that I drew a Jack from the deck,
what's the probability I drew the Jack of Hearts? Clearly $\tfrac{1}{4}$.
What's the chance I drew the Queen of Spades? Clearly zero.[^freq]

[^freq]: Those who took note of the frequentist definition will say that I'm
  not being accurate with my language, and they'd be right. I should say,
  "Among trials in which a Jack is drawn, in what proportion was the Jack of
  Hearts drawn?" This idea of "the chance that" is clearly more in the Bayesian
  vein.

Mathematically, we write $A | B$ to mean "$A$ given that $B$". The definition
of conditional probability is
$$
\mathbb{P}[A | B] \equiv \frac{\mathbb{P}[A \cap B]}{\mathbb{P}[B]}.
$$
I think the best way to read this is: rather than considering the entire
universe of possible events, go into the smaller universe of events $B$, and
calculate probabilities there. Then the denominator is just the "size" of the
universe, and the numerator is the "size" of the event of interest within the
scope of the universe I'm thinking about.

**independence**

## Random variables

We can associated this space of outcomes and events with *random variables*,
which are functions of the event space that return numbers. For the coin flip,
the only interesting random variable is: if the flip is heads, the value is
one; if tails, then zero. For a dice roll, the easy-to-think-of random variable
is the number of dots that came up: if the dice rolls one, the value is 1; if
two, then 2; etc. You could think up other variables: maybe you get 1 on even
dice rolls and 0 on odds.

To a scientist, this sounds really abstract, which it is, but it lets us write
something that feels more natural: for a random variable $X$, what's the
probability that $X$ is less than some particular value $x$? I'll write this
$\mathbb{P}[X < x]$. This is called the *cumulative distribution function*, of
cdf, of $X$. Traditionally it's written as $F_X$:
$$
F_X(x) \equiv \mathbb{P}[X < x].
$$

If $X$ is a finite, discrete function (that can take on only particular
values), then $F_X$ is zero for the smallest $x$ supported by $X$ (although
it's less than 1 for the highest $x$). For a function that can take on
arbitrarily large or small values, we can see that
$$
\lim_{x \to -\infty} F_X(x) = 0 \text{ and } \lim_{x \to \infty} F_X(x) = 1.
$$

In the finite, discrete case, like a dice roll, it's straightforward to compute
the cumulative distribution function from the *probability mass function*,
which is just the probability that $X$ takes on any particular value. For other
kinds of random variables, the corresponding concept is the *probability
distribution function*, or pdf, traditionally written $f_X$, which is actually
derived from the cumulative distribution function:
$$
f_X(x) \equiv \frac{d}{dx} F_X(x), \text{ or equivalently } F_X(x) = \int_{-\infty}^x f_X(x') dx'.
$$

## Detritus

I'll need an introduction to some basic ideas: events, unions, conditional
probability, expected values, variance, pdf, cdf. I think that's most of what
you need to get the basic gist. (As an aside, you might need some really
complicated stuff to answer the finer point questions, like what's the space of
rational "coin flips"?)


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

This is the Behrens-Fisher problem. It stumped Fisher! He came up with a weird
statistic with a weird distribution (Behrens-Fisher), but it didn't really
stick, since he couldn't calculate confidence intervals (?).

Instead, people went for the Welch-Satterthwaite equation, which approximates
the interesting distribution using a more handy one by matching the first and
second moments. (Maybe worth discussing those? Or just say mean and variance?)

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

Better to say that we're sampling from any distribution that has zero median.
You could even say you're sampling from *all* distributions. That's confusing,
mathematically, because there are infinitely many distributions, and it's not
obvious how you should sample from that functional space, but it works out,
because all those distributions will have the same distribution of pluses and
minuses.

This is now just a binomial test.

## Rank test (Mann-Whitney *U*)

Assume that the *ranks* of the differences are meaningful.

Now you're sampling from any distribution that is symmetric about zero. That means it has zero median also.

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

**Walsh averages and confidence intervals**, from [here](http://www.stat.umn.edu/geyer/old03/5102/notes/rank.pdf)

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

# Statistical power: Cochrane-Armitage test

We never want to run just any test: we want to use the test that is most
capable of distinguishing between the scenarios we're interested in. Usually
this is a matter of choosing the test that has the right assumptions: the
one-sample *t*-test is more powerful than the Wilcoxon test if the data come
from a truly normally-distributed population.

In other cases, you might have more flexibility. There's a somewhat obscure
test that is, I think, a great illustration of this.

Imagine that you have some data with a dichotomous outcome for some categorical
predictor value. One classic example is drug dosing: you think that, as the
dosage of the drug goes up, you have more good outcomes than bad outcomes. Did
a greater proportion of people on board the Titanic survive as you go up from
crew to Third Class to Second to First? Did the proportion of some kind of
event increase over years? Technically, this means you have a $2 \times k$
table of counts, with two outcomes and $k$ predictor categories.

Outcome Dose 1 Dose 2 Dose 3
------- ------ ------ ------
Good    1      5      9
Bad     9      4      1

You could use a $\chi^2$ test with equal expected frequencies across the
columns. In other words, there might be more "good" than "bad" outcomes, but
you don't expect that proportion to differ meaningfully across categories. You
would pool the data across categories, use the observed proportion of good
outcomes as you best guess of the true proportion $f$, and compare the actual
data with you expectation that a fraction $f$ of the counts in each column are
"good".

In our examples, we think the data have some *particular* kind of pattern. The
$\chi^2$ test doesn't look for any particular pattern; it just looks for any
deviation from the null. The test statistic for the $\chi^2$ distribution is
based around the sum of the square deviations from the expected values, usually
written $\sum_i (O_i - E_i)^2$, with some stuff in the denominator to make the
distribution of the statistic easier to work with. If the sum of the squared
deviations is too large, then we have evidence that the observed values are not
"sticking to" the expected frequencies.

The trick I'm going to show you is to keep the same null hypothesis---that
outcome doesn't depend on dose---but adjust the test so that it's more
sensitive to particular kinds of dependencies.

This is a fair approach because we're still just trying to say, "OK, say you
(the nameless antagonist) were right, and there really was no pattern in the
data. Then I'm free to make up any test statistic, so long as, if you're right,
we can show that the observed data were likely to have arisen by chance."

To start constructing the test, think about each flip as a weighted binomial
trial. We'll use these weights to adjust the test statistic to be more
sensitive to what we suspect the true pattern in the data is, but we'll need to
derive the distribution of the test statistic so that we can satisfy the
nameless antagonist.

Say each flip $y_i$, which is in some category $x_i$, gets some associated weight $w_i$. A really simple statistic would be
$\sum_i w_i y_i$, the sum of the weights of the "successful" trials. It would be nice to have this be zero-centered:
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
answer in statistics, so for them we might write $\hat{B} = 3$. This is
clearly a bad estimator, but what does "bad" mean?

[^systematically]: Why the scare quotes? Like in all frequentist statistics,
  we're stuck with assuming that we know the truth, finding the best answer
  knowing the full truth, and then pretending we didn't know the truth in the
  first place. So "systematically" is going to mean: assume you know the true
  value, evaluate the behavior of the estimator knowing the truth, and then
  forget you know the truth.

To answer that, let's consider some of the properties of different estimators.
To keep the different estimators straight, let's put subscripts on them. I'll
call the clearly bad estimator $\hat{B}_\mathrm{bad} = 3$ and I'll call our
naive estimator
$$
\hat{B}_1 = \max_i X_i,
$$
where I called it "1" because it was our first guess. I also called the
variables we're drawing from the uniform distribution as $X_i$.

### Consistent estimators

One reason that $\hat{B}_\mathrm{bad}$ seems bad is that it doesn't change. It
won't ever get more "right", no matter how much data we collect. On the other
hand, $\hat{B}_1$ will get better. In fact, the more data we take, the closer
we expect $\hat{B}_1$ to get to the true maximum.

Estimators whose expected value approach the true value as the number of points
approaches infinity is called *consistent*. Call $M$ the true value and $n$ the
number of points we drew. Then $\hat{B}_1$ is consistent because
$$
\lim_{n \to \infty} \hat{B}_1 = M.
$$
In other words, if you specify an error threshold (e.g., you want an estimate
within 10% of the true value), then I can tell you what $n$ you need to pick in
order to get an estimate within that threshold (with some finite probability).
In contrast, with $\hat{B}_\mathrm{bad}$, there's no $n$ you can pick that will
get you arbitrarily close to the true value.

### Unbiased estimators

Clearly, though, $\hat{B}_1$ is not perfect. No matter how many $n$ we draw,
$\hat{B}_1$ will always be less than $M$. We therefore say that $\hat{B}_1$ is
*biased*. Mathematically, we might write $\mathbb{E}[\hat{B}_1] < B$.
Because it feels natural to expect that the expected value of your estimator
will be the true value, an estimator $\hat{B}$ for which $\mathbb{E}[\hat{B}] = B$
is called *unbiased*.[^blue]

[^blue]: Another standard for "good" estimators is the *best linear unbiased*
  estimator (BLUE). "Linear" means that the estimator is a linear function of
  the data. (You could maybe imagine that there is some wacky, convoluted
  function that's a better estimator, but we stick with linear.) The final
  qualifier, "best", means that the variance of the estimator is the minimum of
  all other linear unbiased estimators. Here "variance of the estimator" is
  computed in the same sense that the expected value of the estimator is
  computed for determining bias. In other words, "best unbiased" means its
  centered on the true value with the smallest variance possible.


Let's try to salvage our naive estimator $\hat{B}_1$ and make an unbiased
estimator $\hat{B}_\mathrm{ub}$ instead.

Where to start? It's likely that there are many unbiased operators, so we need
to pick the form of the operator we want to look for. It seems likely that all
our observed $X_i$ only have two interesting things about them: their maximum,
and how many of them there are. For example, if my first draw was $1.0$, then I
don't learn that much if I draw $0.1$ the next five times, because I know that
$M > 1.0$, and, because it's a uniform distribution, I was just as likely to
draw $0.1$ as $1.0$. If I draw many values below $1.0$, I only learn that the
maximum is probably not far above $1.0$, which is already encoded in the number
of points $n$.

So I want $\hat{B}_\mathrm{ub}$ to be some function of $n$, which is fixed, and
$M$, which is a random variable[^wtf], such that $\mathbb{E}[\hat{B}_\mathrm{ub}] = M$.
That will require knowing the distribution of $M$.

**swo** I mixed a lot of this up. I called $B$ the true value, which got
confusing. I should just use $M$ and $\hat{M}$.

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

## Estimators about estimators

### Jackknife

You have $n$ data points and compute an estimator $\hat{\theta}$ for some
population parameter $\theta$. If you don't know how the population is
structured, then it's not clear what you expect the variance of $\hat{\theta}$
to be. How sure can you be of this value? In terms of inference, can you make
any inference with it?

Compute the *jackknife replicates*[^jackname] $\hat{\theta}_j$, which are the estimators
computed using all the data points except the $j$-th one.

That seems like a weird thing to have done, but you can use them to compute two handy things:

1. An estimate of the variance of the estimator. This can help you for description---by giving a confidence interval(?)---and for inference---by giving you a sense of the "random" ranges you would expect from two samples.
1. An estimate of the bias in the estimator. This is helpful if you don't want want your estimator to be biased but you don't know how to fix it.

[^jackname]: The "jackknife" method is so called because Tukey compared the
  method, which is "rough-and-ready", to another rough-and-ready tool, the
  pocket knife, also known as a jackknife. Although this name has the
  disadvantage of giving you no clue what it is about, it had the advantage of
  having more brevity and vivacity than "delete-1 resampling", which is
  probably the more accurate name.

#### Jackknife variance estimator

The variance estimator is
$$
\widehat{\mathrm{Var}}_\mathrm{jk}[\hat{\theta}] := \frac{n-1}{n}  \sum_j \left( \hat{\theta}_j - \hat{\theta}_{(\cdot)} \right)^2,
$$
where $\hat{\theta}_{(\cdot)}$ is the average of the jackknife replicates:
$$
\hat{\theta}_{(\cdot)} := \frac{1}{n} \sum_j \hat{\theta}_j.
$$
In other words, it's the variance of the jackknife replicates with some rescaling:
$$
\mathrm{Var}[\hat{\theta}_j] = \frac{1}{n-1} \sum_j \left( \hat{\theta}_j - \hat{\theta}_{(\cdot)} \right)^2 \implies
  \widehat{\mathrm{Var}}_\mathrm{jk}[\hat{\theta}] = \frac{(n-1)^2}{n} \mathrm{Var}[\hat{\theta}_j].
$$

The reason for that scaling factor is beyond the scope of this book (Efron &
Stein 1981?), but the exercise gives you a sense of why it has to be true for a
specific case.

Some other work, also beyond the scope of this book, shows that the jackknife
estimate of variance is biased: it tends to overestimate the true variance.
This makes the jackknife a conservative tool.

**Exercise**. Let $\theta$ be the mean. Show that the scaling factor is what we think. Hints:

- Show that $\hat{\theta}_{(\cdot)}$ is the sample mean.
- Show that $\hat{\theta}_j - \hat{\theta}_{(\cdot)} = (n \overline{x} - x_j) / (n - 1)$.
- Show that that value is equal to $(\overline{x} - x_j) / (n - 1)$.

That exercise is from McIntosh's bioRxiv about jackknife resampling.

#### Jackknife bias estimator

The jackknife estimate of bias is $(n-1) \left( \hat{\theta}_{(\cdot)} - \theta \right)$.
This is the sum of the deviations of the jackknife replicates from the observed
value $\hat{\theta}$. Again, the reason that you would take the average
deviation and scale it up to the sum is beyond the scope.

However, if you have an expectation about the bias in an estimator, you can
make an unbiased estimator by subtracting out that bias:
$$
\hat{\theta}_\mathrm{jk} := \hat{\theta} - \widehat{\mathrm{Bias}}_\mathrm{jk}[\theta].
$$

**Exercise**. Show that the jackknife estimate of bias for the variance gives
you the familiar unbiased variance estimator.

**Exercise**. Something about the maximum estimator?

#### Pros and cons of the jackknife

It's a piece of cake to implement. There are only $n$ replicates to do, so it's
tractable. Those replicates are deterministic, so you only run it once.

The cons are that it doesn't always work. For example, a jackknife estimate of
the variance of a median (**swo check Knight**) is not consistent. It's also
overly conservative: it's biased toward higher variances. You can rescue some
properties if you move to a delete-$d$ resampling and pick $d$ from the correct
range.

### Bootstrap

What do you do when you want to compute the variance of some statistic that's not easy to compute? Or you don't know what distribution you're sampling from? Then you permute your own data. How do we relate:

- permutation tests
- bootstrapping (and jack-knifing, etc.)
- nonparametric (which I know is different)

# What does it mean to "sample"?

Does it make sense to compute a confidence interval when you're sampled all the
50 United States?

**Finite correction factor** to point out that there's a difference between
simple random sampling and something else. Then need to explain what simple
random sampling is!

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

# Contingency tables

These are nice examples for how to do statistical thinking.

## Barnard's test

The classic example is whether a certain treatment causes more of the outcome
of interest than just doing nothing. In medicine, that means splitting your
participants into a placebo group and a treatment group and asking what
fraction of each gets well. In a biology experiment, you might split your mice
into a treatment group and a control group and ask what proportion of the mice
in each group get cancer.

In statistics jargon, this is called a $2 \times 2$ contingency table:

Group       Outcome $p$ Outcome not-$p$ Row sums
----------- ----------- --------------- --------
A           $a$         $c$             $m$
B           $b$         $d$             $n$
Column sums $r$         $s$             $N$

Because we picked $m$ and $n$, the sizes of the two groups, those are fixed
parameters. The question is whether the way that $m$ gets distributed into $a$
and $c$ (and that way that the $n$ get put into the $b$ and $d$) is consistent
with there being a common probability $p$ of the outcome of interest.

So we might say that $a$ is distributed like a binomial distribution with $m$
draws and probability $p_a$ of success, and $b$ is distributed like a binomial
with $n$ draws and a probability of $p_b$ of success. The null hypothesis is
that $p_a = p_b$. What's the likelihood of the data given the null?

If we didn't assume the null, and gave the two binomials their own
probabilities, the likelihood of the data would be:
$$
P(a, b | p_a, p_b) = \mathrm{Bin}(a; m, p_a) \times \mathrm{Bin}(b; n, p_b).
$$
But, given that the probabilities are the same, we can collapse it:
$$
\begin{aligned}
\mathcal{P}[a, b | p_a = p_b = p] &= \mathrm{Bin}(a; m, p) \times \mathrm{Bin}(b; n, p) \\
  &= \binom{m}{a} p^a (1-p)^{m-a} \times \binom{n}{b} p^b (1-p)^{n-b} \\
  &= \binom{m}{a} \binom{n}{b} p^{a+b} (1-p)^{m+n-(a+b)} \\
  &= \frac{m! \, n!}{a! \, b! \, c! \, d!} p^r (1-p)^s.
\end{aligned}
$$

This result is a little confusing[^confuse], for two reasons:

1. The probability $p$ of the outcome of interest might be interesting to design a later experiment, but it's *not* interesting for designing a test. We certainly don't want to deliver a result like, "Well, if the null hypothesis is true, *and* $p$ happens to be exactly such-and-such, then your $p$-value is so-and-so." The value $p$ is called a *nuisance parameter* since we don't actually care about its value.
1. We're usually not interested in the likelihood of exactly this data, but rather in the likelihood of data *at least this extreme*. We usually measure "extremeness" using a statistic---a single number---so it's clear that "more extreme" means "bigger" (or "smaller" or "bigger or smaller", depending on if it's a one-sided or two-sided test). Here, we have two numbers, $a$ and $b$, so there aren't two "sides" to the distribution: there are four!

[^confuse]: I trotted out this test because these two confusions are actually
  great learning opportunities.

To resolve the first point, we say that the null hypothesis $p_a = p_b = p$
doesn't restrict us to a particular value of $p$. In other words, the null
hypothesis, which functions as a sort of Annoying Skeptic, is free to pick $p$
to make our results as uninteresting as possible. Mathematically, this means
that, when computing the $p$-value, we should optimize over all values of $p$,
choosing the one that makes our results as uninteresting as possible (i.e.,
which maximizes the $p$-value).

We can't really "resolve" the second point, since it demonstrates that our
previous way of thinking about extremeness was not sufficient for all cases. As
Barnard notes in his original paper[^barnard], there are actually many ways to
choose the pairs $(a, b)$ that produce a $p$-value more than our threshold.
This gets into some fancy footwork to articulate exactly how you should pick
this area, but the basic results are pretty intuitive: when $a/m$ and $b/n$ are
similar, you tend to be under the rejection threshold; when they are far apart,
you tend to be over.

[^barnard]: Barnard conceived of the $(a, b)$ as points "in a plane lattice
  diagram of points with integer co-ordinates", that is, that $a$ is like the
  $x$-axis and $b$ is like the $y$-axis. Then the possible outcomes of the
  experiment are the points in the rectangle bounded by the horizontal lines
  $a = 0$ and $a = m$ and the vertical lines $b = 0$ and $b = n$. He then said
  that you should pick the non-extremal points (i.e., the values of $(a, b)$
  for which you would not reject the null) such that they "consist of as many
  points as possible, and should like away from that diagonal of the rectangle
  which passes through the origin. Formulated mathematically, these latter
  requirements mean that the [points for which you would reject the null] must
  in a certain sense be convex, symmetrical and minimal."

The interesting point here is that, whatever fancy footwork you pick to choose
that region, and no matter how "reasonable" your footwork is, it's still
footwork that doesn't obviously follow from the simple definition of a
hypothesis test. We'll encounter this problem again in Bayesian statistics,
when we find that the Bayesian analog of a confidence interval is not unique:
there are many ranges of values that are compatible with our ignorance.

## Fisher's test to the rescue(?)

If you've worked with contingency tables, you're probably saying, "I've never
heard of this crazy Bernard's test, with its weird multi-sided rejection space
and its requirement to maximize over $p$. We have Fisher's exact test, which is
the exactly right test to use here!"

Looking at the same contingency table, Fisher's test asks, given the row
marginals $m$ and $n$, the first column marginal $r$, and the grand total $N$,
what is the probability of a table at least this extreme?

This is just a combinatoric problem: if you're as likely to assign items in $m$
to $a$ as to $c$ (and, analogously, to assign items from $n$ to $b$ or $d$),
then "what's the probability of this table" is equivalent to asking "given the
marginals, how many ways are there to choose this table?". More specifically,
how many ways are there to choose $a$ items from a bank of $m$ items and $b$
items from a bank of $n$, given that we chose $r = a + b$ items from the total
$N$? Mathematically:
$$
\mathbb{P}[a | m, n, r, s] = \frac{\binom{m}{a} \binom{n}{b}}{\binom{N}{r}} = \frac{m! \, n! \, r! \, s!}{N! \, a! \, b! \, c! \, d!}.
$$

Computing the $p$-value is easier here than with Barnard's test because we need
to keep the row *and column* marginals the same. In Barnard's test, we just
kept the row marginals constant, because we considered those as fixed
parameters, corresponding to things like the number of patients we assigned to
each of the placebo and treatment groups. It doesn't make sense to allow the
Annoying Skeptic to fiddle with those values.

In Banard's test, we *did* allow the Annoying Skeptic to fiddle with the column
marginals, since it wasn't clear, before the experiment began, that $r$ would
have the outcome of interest. In other words, we didn't know that $r$ people in
both the placebo and treatment groups would get well.

Fisher's test, however, *does* keep the column marginal constant. This makes it
a lot easier to compute the $p$-value. First, the nuisance parameter $p$
doesn't appear in the likelihood, so we don't need to do the weird
maximization. Second, we only need to vary one value, $a$ (or, equivalently,
$b$), since, if you know the marginals, there is only one axis along which to
change the values in the table. In other words, if you know
$$
\begin{aligned}
a + c &= m \\
b + d &= n \\
a + b &= r,
\end{aligned}
$$
then that's three equations with four unknowns ($a$, $b$, $c$, $d$), so
specifying any one of $a$, $b$, $c$, or $d$ specifies all the others. (You
might be looking for a fourth equation $c + d = s$, but you can get that by
adding the first two equations and subtracting the third.)

Here's an example:

Group       Success Failure Row sums
----------- ------- ------- --------
A           1       9       10
B           11      3       14
Column sums 12      12      14

There's only one way to make this table more "extreme" without changing the
marginals: you can take the one group A success and make it a group A failure
and simultaneously make a group B failure into a group B success. Similarly,
there's only one way to make this table less extreme: turn a group A failure
into success, and turn a group B success into failure.

So keeping the column sums constant made it way easier to compute the
$p$-value: count this table and all the tables with a more extreme upper-left
or bottom-right and see if your summed probability hits the rejection
threshold.

However, this simplicity came at a cost, which you may have noticed: does it
make sense to keep the columns constant? Experimentally, this means that you're
restricting the Annoying Skeptic to only consider cases in which, say, the
number of patients who got well *in both groups* is equal to the experimentally
observed value. This is a little weird. It suggest that your experimental design was like this:

1. Pick $m$, $n$, and $r$.
1. Assign $m$ patients to placebo and $n$ to treatment.
1. Wait until $r$ patients *across both groups* have gotten well.
1. Stop the experiment.

This is almost certainly not reflective of how typical experiments are run[^tea].

[^tea]: It is, however, the way the famous "lady tea tasting" experiment was
  designed. The myth is that Fisher didn't believe it when a high-class lady
  told him that she could detect whether tea was added to a cup with milk in it
  or whether the milk was added to the tea. He designed an experiment with $m$
  cups prepared one way, $n$ prepared the other, and told her to detect the
  $r = m$ cups that were prepared the first way. A Barnard-style experiment, in
  which the same $m$ and $n$ cups

**Fisherian small data**

**What happens if I use the "wrong" test? Chi-square as an example of wrongness**

# Regression

Hardin pages 56-57 talks about the difference between the normal
(subject-specific) and the generalized (population-average) estimating
equations. E.g., second-hand smoking: what's the odds of a kid having a
respiratory illness given that mom smokes? SS parameters give the OR for *each
individual child* having the illness, so it's what we would expect would happen
if particular moms stopped smoking. PA parameters give the OR *across the
population*, so it explains the difference in prevalence we expect in the two
groups. The first one is:
$$
\mathrm{OR}^\mathrm{SS} = \frac{P(Y_{it}=1 | X_{it}=1, \nu_i) / P(Y_{it}=0 | X_{it}=1, \nu_i)}{P(Y_{it}=1 | X_{it}=0, \nu_i) / P(Y_{it}=0 | X_{it}=0, \nu_i)}
$$
and the second is
$$
\mathrm{OR}^\mathrm{PA} = \frac{P(Y_{it}=1 | X_{it}=1) / P(Y_{it}=0 | X_{it}=1)}{P(Y_{it}=1 | X_{it}=0) / P(Y_{it}=0 | X_{it}=0)}.
$$
The difference, in case you didn't catch it, is whether you condition on the
random effect $\nu_i$. The SS estimate is for these particular people; the PA
estimate marginalizes over the random effects.

# Bayesian

One of the biggest sticking points about a Bayesian analysis is that it requires specification of a prior.
It can be thought of as an advantage or a disadvantage, but I think it's better to think of it as a responsibility.
Let me tell you an allegory.

Once, a young statistician lived in her parents' house. She paid no rent and
simply never considered her orientation in the world.  Some year later, she
left the home and had to do statistics in the wide world.  Where would she
live? How would she pay rent?  These decisions brought power, since she was
free to do things she couldn't do at home.  She could live a life that was more
accurate to the real world.  This allegory is too long and rambly. But there's
something in here.

Frequentist statistics is correct so long as you use it exactly for what it is
designed to do.  The trouble is that we *want* statistics to answer the kinds
of questions that *only* Bayesian statistics can answer.  For example, how
likely is it that this hypothesis is true?  If you perfectly adhere to the
frequentist interpretation, then you are in good shape.  But if you deviate, if
you start to say, "Oh, the p-value is kind-of like the probability my
hypothesis is false." Then you have SCREWED UP son.

# Appendix

## Random number generation

In many places in this book, we've relied on the ability to generate "random"
numbers. However, computers (in the sense of logical machines) have no way to
generate truly random numbers. Instead, we have clever methods that get us
something that's a pretty good approximation of random numbers.

It's worth noting that a lot of the historical, conceptual directions in
statistics are due to the fact that doing any kind of Monte Carlo methodology
without computers is really onerous. Before we had today's technology
(pseudorandom number generators, to be discussed below), we had tables of
random numbers, the most notable being the hefty *A Million Random Digits with
100,000 Normal Deviates* (where "normal deviate" means "random number drawn
from a standard normal distribution), published by the (coincidentally-named)
RAND Corporation.[^rand] RAND published this book because they had a lot of
engineers and researchers using Monte Carlo methods. Before the tables of
random numbers, you had to generate the random numbers yourself, which was
basically infeasible.[^buffon]

[^rand]: You can still get this book [on RAND's
  website](https://www.rand.org/pubs/monograph_reports/MR1418.html) or [in
  paperback](https://www.amazon.com/Million-Random-Digits-Normal-Deviates/dp/0833030477/).
  The numbers were generated using an electronic device, specifically designed
  to shuffle a sort-of random table of numbers, attached to a computer. See the
  text about hardware random number generators.

[^buffon]: In 1777, Georges-Louis Leclerc, Comte de Buffon posed a math problem
  that included probability and geometry: if you throw needles (or matchsticks)
  onto a surface with parallel stripes whose widths are equal to the length of
  the needles, what fraction of the needles touch two stripes? It turns out
  that the answer has $\pi$ in it. So in 1901, Mario Lazzarini published that
  he had tossed a needle 3,408 times and, using the analytical solution,
  back-calculated $\pi$ as $\tfrac{355}{113}$. This estimate of $\pi$ was
  already known, and the fact that Lazzarini came up with exactly that value is
  taken as strong evidence that he faked the experiment. In other words, we
  have a pretty strong prior against believing that someone in 1901 even
  bothered to throw a needle 3,000 times, much less the many more times than
  that that would be required for random number generation for more interesting
  Monte Carlo problems!

As mentioned, now we have *pseudorandom number generators*[^pseudo]. These rely
on some input *seed*, which is the (hopefully) truly random thing, and from
that seed it generates a deterministic list of numbers that, in the absence of
knowing the seed, appear random.[^seed] Usually this seed comes from one of the
many "entropy sources" that a computer has access to, things like the time
between keystrokes, the time at which a process was started, time between
network pings, etc.

[^pseudo]: There is such a thing as a "hardware" random number generator, which
  is some kind of device that measures something that we think is truly noisy
  in the real world, like thermal noise or (what we believe are truly random)
  quantum phenomena like beamsplitting.

[^seed]: It may seem weird that, given a seed, you get a deterministic set of
  numbers.  Most software with (pseudo)random number generators pick a seed
  using whatever entropy they have access to when you boot up the program, so
  you never notice that the seed is different each time you run a simulation.
  You can, however, always *pick* the seed, which is nice, because it lets you
  repeat code with a Monte Carlo method in it and always get the same result,
  which is nice for testing and debugging.

The pseudorandom number generator in most software now is the Mersenne Twister.
This algorithm is remarkable for having a long *period* of $2^{19937} - 1$.
(All pseudorandom number generators, started with with some seed, will
eventually end up repeating their output. The period is the number of outputs
you get before closing the loop.) The random things produced by the generators
are typically mapped into uniformly distribution varibles over $[0, 1]$.

### Generating non-uniformly-distributed numbers

Drawing numbers from $[0, 1]$ usually isn't that interesting. We want to draw
numbers from other distributions. There are two main approaches:

1. Clever transformations
1. Various forms of *rejection sampling*

The idea with clever transformations is to generate random numbers from the
uniform distribution and somehow turn them into random numbers distributed
according to some other distribution.

Rejection sampling is a big class of approaches, including such notables as
"Metropolis-Hastings" and "Markov chain Monte Carlo" (MCMC). They are very
useful for the practical scientist.

**inverse transform, ziggurat, rejection, Metropolis-Hastings and other Monte carlo mcmc stuff**

Clever transformations are nice when you can do them, but it's unlikely you'll
derive one for yourself. Basically, if a run-of-the-mill random number
generation function in some software purports to be able to sample numbers from
some distribution, it's doing this transformation. I don't think there's
anything really practical to be gained from knowing these transformations, but
they're fun, so I put them here.

#### Clever transformations

If you can write the cdf of your distribution of interest, say $F_X(x)$ and you
invert it (i.e., solve for $x$ in terms of $F_X$), then you can use a nice
trick called *inverse transform sampling*.


##### Normal distribution: Box-Muller transformation

To generate normally-distributed numbers from uniformly distributed numbers,
consider this trick.

Think about a pair of independent, normally-distributed variables $Z_1$ and
$Z_2$. Their joint pdf will be
$$
\begin{aligned}
f_{Z_1,Z_2}(z_1, z_2) &=
  \frac{1}{\sqrt{2\pi}} \exp\left\{ -\frac{z_1^2}{2} \right\} \times
  \text{same thing for $z_2$} \\
  &= \frac{1}{2\pi} \exp\left\{ -\frac{1}{2} \left( z_1^2 + z_2^2 \right) \right\}.
\end{aligned}
$$
The trick is to think of $z_1$ and $z_2$ as Cartesian coordinates like $x$ and
$y$, from which it's very natural to replace $z_1^2 + z_2^2$ with $r^2$ and
define some $\theta$ such that $z_1 = r \sin \theta$ and $z_2 = r \cos \theta$.
My claim is that we'll be able to generate $r$ and $\theta$ from independent,
uniform random variables.

Because $f_{Z_1,Z_2}$ is symmetric with respect to $z_1$ and $z_2$ (i.e., you
could swap that subscripts and come out with the same expression), it must be
that there isn't anything special about having sine versus cosine. In other
words, there mustn't be anything special about $\theta = 0$ versus $\theta =
\pi$. The origin can't matter. Thus, it must be that $\theta$ is uniformly
distributed over $[0, 2\pi]$. Any other distribution would end up treating
$z_1$ and $z_2$ differently, which would break their independence.

Generating $r$ is a little more tricky. Let's look at the cumulative
distribution function of the random variable $R$:
$$
\begin{aligned}
\mathbb{P}[R < r] &= \int_0^{2\pi} \int_0^r f_{Z_1, Z_2}
    \,\mathrm{d}z_1 \, \mathrm{d}z_2 \\
  &= \int_0^{2\pi} \int_0^r \frac{1}{2\pi} \exp\left\{-\frac{1}{2} r'^2\right\}
    r' \,\mathrm{d}{r'} \,\mathrm{d}\theta \\
  &= \int_0^r \exp\left\{-\frac{1}{2} r'^2\right\}
    r' \,\mathrm{d}{r'} \,\mathrm{d}\theta \\
  &= \int_0^{\tfrac{1}{2} r^2} \exp\left\{-s\right\} \,\mathrm{d}s,
    \text{where $s = \tfrac{1}{2} r'^2$} \\
  &= 1 - \exp\left\{ -\frac{1}{2} r^2 \right\}.
\end{aligned}
$$
If we define $r = \sqrt{-2 \log u}$, then $\mathbb{P}[R < r] = 1 - u$, which is
just the cdf for a uniformly distributed variable $U$ on $[0, 1]$. So we generate
$r$ using that formula.

It may seem a little strange that we can generate independent $z_1$ and $z_2$
using $r$ and $\theta$. You might think that if I know $z_1$, then I can guess
something about $r$ or $\theta$ and use that information to make a guess about
the value of $z_2$. However, because the Cartesian and polar coordinate systems
encode exactly the same information, that argument is like saying that, because
I told you $x$, you might be able to guess $y$, which is clearly impossible.

# Chebyshev's inequality

What's the relationship between confidence intervals and variance? We all
know the relationship for the normal distribution.

As a lemma, consider a random variable $X$ that only takes on nonnegative
values. Then
$$
\mathbb{E}[X] = \sum_{k=0}^\infty k \, f_X(k) \geq \sum_{k=1}^\infty f_X(k) = \mathbb{P}[X \geq 1].
$$
(To see the middle inequality, note that you can drop $k=0$, and then, for
all the $k \geq 1$, you can replace $k$ with $1$, which makes that term in
the sum smaller than it might be.) We'll use the reversed version:
$\mathbb{P}[X \geq 1] \leq \mathbb{E}[X]$.

Now, Chebyshev's inequality is easy. Use the
$$
\begin{aligned}
\mathbb{P}\left[|X - \mu| \geq k \sigma\right]
  &= \mathbb{P}\left[ \frac{(X - \mu)^2}{k^2 \sigma^2} \geq 1 \right] \\
  &\leq \mathbb{E}\left[ \frac{(X - \mu)^2}{k^2 \sigma^2} \right]
    \quad \text{(by the lemma)} \\
  &= \frac{1}{k^2 \sigma^2} \mathbb{E}\left[(X-\mu)^2\right] \\
  &= \frac{1}{k^2}. \quad \text{(since that expected value is $\sigma^2$ by definition)}
\end{aligned}
$$

For $k=1$, we result is trivial: at most 100% of values fall outside 1
standard deviation from the mean. (An upper bound of 100% tells us nothing.)
For $k=2$, at most $1/4 = 25\%$ of values fall outside 2 standard deviations.
That is, 75% fall inside. For $k=3$, 89% fall inside. These are much more
conservative results than for the normal distribution, for which 95% of
values fall within 2 standard deviations and 99.7% fall within 3.

I'm not sure of the practical utility of this inequality. It requires
knowing the true variance, which already requires a whole bunch of data.
