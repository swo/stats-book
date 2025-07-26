Things to do:

Things to do:

- If you cannot construct the entire universe of possible observations (events?), then you are actually sampling from the $p$-value distribution
- You observe a specific statistic, and then you sample another _n_.
- Under the null hypothesis, the observed value and the other _n_ came from the same distribution.
- The _p_-value is the probability of getting a value as small as the observed one, given that the null is true.
- If you know the "shape" of the distribution, you can compute this exactly (e.g., as we did in our sign test).
- If you _don't_ know the shape, then you need to do this empirically, with a parametric test.
- You say, I have _n+1_ items in a list. What's the chance that this particular item falls at rank _m_ or below (or above)? That's $(r+1)/(n+1)$.
- It's a mistake to do $r/n$, but not a terrible mistake, except that it gives you $p=0$!
- Overestimates small $p$ (because you go up to 1/n+1) and underestimates large, but that's normally not a problem. The important thing is avoiding p=0 bias.
- Also, this provides an _estimate_ of the $p$-value, since you're basically doing a binomial test: of $n+1$ total coin flips, $r+1$ come out heads. What's the probability of heads? This has a confidence interval around it.

# Frequentist inferential statistics: statistical tests and confidence intervals

[1. Define p-value (1 and 2-sided). 2. Zea mays example data. 3. Binomial sign test. 4. Fisher's weird sum. 5. Paired test (wilcox)?. 6. Paired t-test.]{.mark}

[Add a chapter for statistical power and sample size. Define Type I and Type II errors. Chapters on parametric vs. nonparametric. Permutation tests.]{.mark}

$T=t(X)$ is statistic. $t^\star = t(x)$ is obs. value. $p=\prob{T>t^\star}$ or $\prob{T<t^\star}$. 2-sided is $\prob{T<t^\star \text{ or } T > t_0 + (t^\star-t_0)}$, where $t_0$ is some central value?

The previous chapter laid out the conceptual points of inference. In this chapter, I lay out the nuts and bolts of what most people think statistics is: tests.

The mathematics of statistical tests follows directly from the previous mathematical chapters: we define some _estimators_, functions of the data that predict some property of the data, and determine their variance. We just give things different names and interpret them differently.

But rather than begin with the mathematics of tests, I'll start with the concepts of how they work, and show how to implement them algorithmically and computationally. Once you understand what the test is doing, we can get back to unpacking some of the math you will hear bandied about around them.

## The ingredients in a statistical test

To run a statistical test, you need:

1.  Observed data.
2.  A listing of the universe of observations that could have been made, of which the actual observation is one instance.
3.  A _null hypothesis_ that associates a probability with each possible observation.
4.  A _test statistic_ that summarizes how interesting the observed data are in a single number.

Every statistical test that you know of can be defined by how it selects its universe of possible observations, its null hypothesis, and its test statistic.

The test will give you two outputs:

1.  A $p$-value, which is the probability of observing data as extreme (or "interesting") as what you did observe, given the null hypothesis.
2.  Confidence intervals on the test statistic.

More concretely, the $p$-value is the proportion of the observations in the universe of observations, weighted by their probabilities, that have test statistics that are more extreme (i.e., either larger or smaller) than the test statistic for the observed data. The confidence interval says that, using the observed data as our best estimates of the underlying truth, what range of test statistics would we expect?

## Interpreting $p$-values and confidence intervals

The $p$-value was developed by Fisher, probably the one person who had the most influence on modern statistics. He used the $p$-value, a rigorously-derived number, to reason informally about data. If the $p$-value too big, by some standard to be determined _ad hoc_, then the data didn't show anything interesting. In different books and papers, for different data sets, Fisher used different standards for "too big", but $0.05$ was a recurring choice.

Later, Neyman and Pearson (the younger) reformulated Fisher's method as a kind of decision-making under uncertainty. If you were a decision-maker, and you had to make a decision, what would you do when faced with certain data? They suggested you pick some specific _confidence level_, written $\alpha$, and make your decision based on whether $p$ was greater than or less than $\alpha$.

Although Fisher furiously disagreed with Neyman and Pearson about how to interpret $p$-values, the canonical $\alpha = 0.05$ somehow made it into the scientific literature.

As laid out in the previous chapter, "what is the probability that this data is true, given the data?" is a very tricky question. The critical point is that the $p$-value is, in the language of that chapter, $\prob{X | \theta}$, but we want to know about $\prob{\theta | X}$. The link between these is the mysterious prior probability $\prob{\theta}$.

I think my only take-away is that you should trust your gut more than a $p$-value. First, Fisher developed statistics as a way to rigorously show that data _weren't_ interesting, a mathematical counterbalance to humans' ability to find interesting patterns in data, especially their own. He meant $p$-values as a way to deflate puffed-up conclusions, not to puff them up. Second, Fisher, who invented $p$-values, couldn't really agree with other extremely intelligent people about exactly what they meant. So don't make yourself crazy trying to figure it out too precisely either! Just know that big $p$-values, where "big" depends on the intellectual context, mean the data aren't interesting, where "interesting" is defined by the null hypothesis.

[Move all of the above to previous chapter where p-values are defined]{.mark}

## A test with a simple explanation but difficult math: the binomial proportion test

To understand how to go from a test's ingredients to its outputs, I will work through many examples of increasing complexity. The first and simplest is this: I flip a coin $n$ times, seeing some sequence of heads and tails, and I want to infer whether the coin is fair.

- The _observed data_ is the sequence of heads and tails I flipped.
- The universe of possible observations is all the sequences of heads and tails I could have flipped. So if $n=2$, the universe is the four cases $HH, HT, TH, TT$.
- The _null hypothesis_ is that heads and tails are equally likely.
- The _test statistic_ is the number of heads I flipped. This statistic, like all the other statistics discussed in chapter XX, is a function of the data: given some sequence of heads and tails, it just counts up the number of heads.

### One- and two-sided $p$-values

The $p$-value is the probability of data as extreme as what we observed, or more extreme, given the null hypothesis that $p = 0.5$.[^1] The tricky part of this definition is understand what "as extreme or more" means.

"Extremeness" is quantified by the test statistic, which summarizes each of the possible observations ---each length-$n$ sequence of heads and tails--- into a single number, the number of heads in that sequence. "As extreme or more" can mean 3 things:

- as small as what was observed, or smaller,
- as large as what was observed, or larger, or
- as far away from the "center" as was observed, or further away.

**_Exact tests: you can count every possibility for a binomial_**

The first two cases call for _one-sided_ $p$-values and can be used if you have an _a priori_ hypothesis that the number of heads that you will observe will be much higher or lower than what you would expect if the coin were fair. So if I want to seek support for my _a priori_ hypothesis that the coin is more likely to land tails than heads, then I would use that one-sided $p$-value. If I don't have an _a priori_ expectation about whether the flips will be enriched for heads or tails ---if I just think that the coin is not fair, but I don't know which way--- then I need a more conservative, _two-sided_ $p$-value.

In this example, the null hypothesis of a fair coin means that all the possible sequences of heads and tails are equally likely, so to compute a one-sided $p$-value, I just need to count up the number of sequences that are more extreme than the observed one: $$\text{one-sided $p$-value} = \frac{\text{number of possible sequences more extreme than observed}}{\text{total number of sequences}}$$ You may know that the number of length-$n$ heads-tails sequences is $2^n$ and that the number of those sequences that has $x$ heads is $\binom{n}{x} = n! /
\left[ x! (n-x)! \right]$. Thus, for this example, if we have a "low-sided" expectation about the number of heads: $$\text{``low-sided'' one-sided $p$-value} = \frac{\sum_{y=0}^x \binom{n}{x}}{2^n}$$ A "high-sided" $p$-value would sum from $x$ up to $n$.

For the two-sided $p$-value, we need to sum up the "low-side" and "high-side" $p$-values. Because the observed $x$ falls to one side of the central expectation $\expect{x} = n/2$, we need to symmetrize to find the other value. For example if $x$ is low, we make another, mirrored "high" $x_\mathrm{hi} = n-x$: $$\text{two-sided $p$-value} = \frac{\sum_{y=0}^x \binom{n}{x} + \sum_{y=n-x}^n \binom{n}{x}}{2^n}$$ If $x > n/2$, then the sums would go from $0$ to $n-x$ and from $x$ to $n$.

## Checking for a specified unfairness of a coin

In the first example, we used a null hypothesis that heads and tails were equal, which simplifed thinking about $p$-values because we could simply count up the equiprobable sequences of heads and tails.

Now, we generalize slightly, allowing a null hypothesis that the probability $p$ of flipping heads is not exactly $\tfrac{1}{2}$:

- The _observed data_ is, again, the sequence of heads and tails I flipped.
- The universe of possible observations is, again, all the sequences of heads and tails I could have flipped.
- The _null hypothesis_ is that the probability of flipping heads is $p$.
- The _test statistic_ is the number of heads I flipped.

The mathematically savvy will know that the probability of $y$ successful trials among $n$ total trials, with each trial having a probability $p$ of success, is the _binomial distribution_: $$\mathrm{Binom}(y; n, p) = \binom{n}{y} p^y (1-p)^{n-y}$$ This is just like the above, where we counted the number of sequences, only now we need to weight them by the number of more (or less) probably heads (and tails): $$\text{``low-sided'' one-sided $p$-value} = \sum_{y=0}^x \mathrm{Binom}(y; n, p)$$

### Computing confidence intervals

Recall that a _confidence interval_ is a method: it is a pair of statistics, functions of the data, that will, in a certain proportion $\alpha$ of replicate experiments, will contain the true value, regardless of what the true value is.

In this example, the "true value" in question is the unknown probability $p_\mathrm{true}$ that the coin will flip heads, which would be anything between 0 and 1. So we need a method that, whether $p_\mathrm{true} = 10^{-6}$ or $p_\mathrm{true} = 0.999$, will produce an interval that contains the true $p_\mathrm{true}$ in a proportion of $\alpha$ of the data that would arise in replicates of that experiment.

As mentioned earlier, there are multiple methods that can achieve this result. The one that doesn't rely on any kind of approximation, which we will address later, is the _Clopper-Pearson_ interval. This says to find the largest value $p_+$ for which $\sum_{y=0}^x \mathrm{Binom}(y; n, p_+) > \alpha/2$ and the smallest value $p_-$ for which $\sum_{y=x}^n \mathrm{Binom}(y; n, p_-) >
\alpha/2$. In other words, if $\alpha=95\%$, pick an uppper limit on $p_\mathrm{true}$ so that, if that were the true value, in exactly $2.5\%$ of replicates of the experiment, you would get numbers of heads larger than what you observed. Similarly, pick a lower limit so that, if that were the true probability of flipping heads, in $2.5\%$ of replicates, you would get numbers of heads larger than what you observed.

If this seems like a big, confusing headache, I hope you take it as a sign that confidence intervals are confusing, not that you're not understanding!

[Now with computers, Clopper-Pearson is easy]{.mark}

## A test with simple math but a difficult explanation: the $z$-test

The elegance of the previous example is that it works by simply enumerating all the possible sets of observations. The inelegant part is that there can be many: $2^n$ grows quickly with $n$, making the sums in the $p$-value calculations onerous. Furthermore, the math of the Clopper-Pearson interval is a bit of a mess and hard to articulate.

As a counterexample, consider the humble $z$-test, in which your experiment consists of drawing a single number from a pre-specified population, specifically, a normal distribution with known mean $\mu$ and variance $\sigma^2$:

- The observed data is the single number $x$ you drew.
- The universe of possible observations is all numbers, from $-\infty$ to $+\infty$.
- The null hypothesis is that the number $x$ was drawn from a normal population with mean $\mu$ and variance $\sigma^2$.
- The test statistic is just the number $x$.

In this example, rather than summing up over the _discrete_ universe of possibilities, you need to integrate to find the $p$-value: $$\text{``low-sided'' $p$-value} = \int_{y=-\infty}^x f_\mathcal{N}(y; \mu, \sigma^2) \,\mathrm{d}y = F_\mathcal{N}(y; \mu, \sigma^2).$$

### cis

$$
\begin{aligned}
1 - \alpha &= \prob{X_- \leq \mu \leq X_+} \\
\alpha / 2 &= \prob{X_- \geq \mu}
\end{aligned}$$ Making the inspired guess that
$$\frac{X_- - \mu}{\sigma} = \frac{X - \mu}{\sigma} - b$$ that is, that
$X_- = X - \sigma b$, we find that $$\begin{aligned}
  \alpha/2 &= \prob{X - \sigma b \geq \mu} \\
  &= \prob{\frac{X - \mu}{\sigma} > b},
\end{aligned}$$ which you can find that, for $\alpha = 0.05$, you get
$b = 1.96$.

## approx

In fact, rather than enumerating all $2^n$ possibilities, the typical
approach is to approximate the binomial distribution with the normal
distribution. It turns out that, when $n$ is not too small, that:
$$\mathrm{Binom}(x; n, p) \approx \mathcal{N}\left(x; \; \mu = np, \; \sigma^2 = \frac{p (1-p)}{n}\right),$$
in other words, you can use a normal distribution with mean a mean and
variance computed from $n$ and $p$ to approximate the binomial
distribution.

**FIGURE**

The binomial counting approach was intellectually elegant but
mathematically inelegant. The normal approximation approach is
mathematically elegant but intellectually confusing, as it makes the
ingredients in the test very artificial:

- The observed data is not the sequence of heads and tails but rather
  simply $x$, which was previously the observed test statistics, that
  is, the number of heads flipped.
- The universe of possible observations is all values between $0$ and
  $n$. Of course, this isn't really true, as you can only observe
  integer $x$. But for the math to work out, you need to imagine that
  you could have observed $x = 1.02$, for example.
- The null hypothesis, as above, is some assertion about the probability
  $p$, only now $p$ is not the probability of any particular event, it's
  just a parameter in the normal distribution's mean and variance.
- The test statistic is just $x$, the observed number.

The other intellectually weird thing is that now, because the universe
of possible observations is infinite, you cannot count up the states but
must integrate over them:
$$\text{``low-sided'' one-sided $p$-value} = \int_{y=0}^x \mathcal{N}\left(y; np, \frac{p(1-p)}{n} \right) \,\mathrm{d}y$$
This is where the mathematical elegance comes in: the integral of the
normal distribution, which is its cumulative distribution function, is
oft-calculated and so easy to look up. So now rather than summing over
something like $2^n$ states, we just look up a single number.

The confidence intervals become similarly simple: I look for a lower
bound $p_-$ such that the probability that I would observe a value
smaller than what I did observe is $\alpha/2$:
$$\alpha/2 = \int_{y=0}^x \mathcal{N} \left(y; np_-, \frac{p_-(1-p_-)}{n} \right) \,\mathrm{d}y$$

There are a few other approximations to the binomial distribution that
are more accurate, but they all come down to the same logic: they
exchange the intellectual simplicity of counting up over a finite
universe of states for the mathematical elegance of integrating over a
well-known function.

**point out how this works with a z-test?**

## The data with different null hypotheses and statistics: paired tests

So far we've had null hypotheses and test statistics that are obvious
matches for the data that we're looking at. In the real world, when
you're making up your own statistical tests, you'll find that you
actually have multiple choices for null hypotheses and test statistics.
To show how this can work, I'll analyze the same kind of data in a few
ways.

Charles Darwin wanted to know if cross-fertilized corn (*Zea mays*) grew
better than self-fertilized corn. He took 15 pairs of plants, one self-
and one cross-fertilized, each having germinated on the same day, and
planted them together in one of 4 pots. He measured the heights of the
plants, to one-eight of an inch, after some time (Table
[1.1](#table:darwin){reference-type="ref" reference="table:darwin"}).

::: {#table:darwin}
+----------+-----+---------------------------------------+
|          |     | Height (inches)                       |
+==========+=====+===================+===================+
| 3-4 Pair | Pot | Crossed           | Self-fert.        |
+----------+-----+-------------------+-------------------+
| 1        | 1   | $23 \tfrac{1}{2}$ | $17 \tfrac{3}{8}$ |
+----------+-----+-------------------+-------------------+
| 2        | 1   | $12$              | $20 \tfrac{3}{8}$ |
+----------+-----+-------------------+-------------------+
| 3        | 1   | $21$              | $20$              |
+----------+-----+-------------------+-------------------+
| 4        | 2   | $22$              | $20$              |
+----------+-----+-------------------+-------------------+
| 5        | 2   | $19 \tfrac{1}{8}$ | $18 \tfrac{3}{8}$ |
+----------+-----+-------------------+-------------------+
| 6        | 2   | $21 \tfrac{1}{2}$ | $18 \tfrac{5}{8}$ |
+----------+-----+-------------------+-------------------+
| 7        | 3   | $22 \tfrac{1}{8}$ | $18 \tfrac{5}{8}$ |
+----------+-----+-------------------+-------------------+
| 8        | 3   | $20 \tfrac{3}{8}$ | $15 \tfrac{1}{4}$ |
+----------+-----+-------------------+-------------------+
| 9        | 3   | $18 \tfrac{1}{4}$ | $16 \tfrac{1}{2}$ |
+----------+-----+-------------------+-------------------+
| 10       | 3   | $21 \tfrac{5}{8}$ | $18$              |
+----------+-----+-------------------+-------------------+
| 11       | 3   | $23 \tfrac{1}{4}$ | $16 \tfrac{1}{4}$ |
+----------+-----+-------------------+-------------------+
| 12       | 4   | $21$              | $18$              |
+----------+-----+-------------------+-------------------+
| 13       | 4   | $22 \tfrac{1}{8}$ | $12 \tfrac{3}{4}$ |
+----------+-----+-------------------+-------------------+
| 14       | 4   | $23$              | $15 \tfrac{1}{2}$ |
+----------+-----+-------------------+-------------------+
| 15       | 4   | $12$              | $18$              |
+----------+-----+-------------------+-------------------+

: Darwin's *Zea mays* data
:::

The obvious question is: did the hybridized plants grow faster than the
self-fertilized plants?

### A sign test

This just reduces down to the binomial test above. Null hypothesis is
that the median is zero.

### Wilcoxon's signed rank test

Null hypothesis is zero median and symmetric distribution. Much more
complex test statistic.

### Fisher's sum test

Null is zero median and symmetric distribution. Simple test statistic.

### Paired $t$-test

### Scott's

Something about permuting within the pots? Bootstrapping?

## Parametric inference

\- z-test - t-test - Wilk's theorem? and likelihood-ratio tests -
F-tests in general, variance. Then go to ANOVA

## Non-parametric inference

\- Kolmogorov-Smirnov

## $t$-test

### Equal variance

The (old school) *t*-test is two sample, assuming equal variances. We're
interested in the difference in the means between the two populations.

The null hypothesis is that we're drawing $n_1 + n_2$ samples from a
population that has this equal variance, and that the labels on the two
"populations" are just fictitious.

Our estimator $s_p^2$ for the pooled variance is just the average of the
variances of the two "populations", weighted by $n_i - 1$ (which is a
better estimator than weighting by just $n_i$):
$$s_p^2 = \frac{(n_1 - 1) s_1^2 + (n_2 - 1) s_2^2}{n_1 + n_2 - 2}.$$

To see why this is, say that we're going to develop some pooled
estimator $\hat{\mathbb{V}}_{X,p}$, which is a constant times the sum of
squares: $$\begin{aligned}
\hat{\mathbb{V}}_{X,p} &= C \left[ \sum_i (X_{1i} - \overline{X}_1)^2 + \ldots \right] \\
  &= C \left[ \sigma^2 \sum_i (Z_{1i} - \overline{Z}_1^2 ) + \ldots \right] \\
  &= C \sigma^2 \left[ \sum_i Z_{1i}^2 - n \overline{Z}_1^2 + \ldots \right] \\
\expect{\hat{\mathbb{V}}_{X,p}} &= C \sigma^2 \left[ \sum_i \expect{Z_{1i}^2} - n \expect{\overline{Z}_1^2} + \ldots \right] \\
  &= C \sigma^2 \left( n_1 - 1 + n_2 - 1 \right) \\
\end{aligned}$$ which implies that $$C = \frac{1}{n_1 + n_2 - 2}.$$

To see the last bit, use this identity: $$\begin{aligned}
\sum_i (Z_i - \overline{Z})^2 &= \sum_i (Z_i^2 - 2 Z_i \overline{Z} + \overline{Z}^2) \\
  &= \sum_i Z_i^2 - 2 n \overline{Z} \overline{Z} + n \overline{Z}^2 \\
  &= \sum_i Z_i^2 - n \overline{Z}^2.
\end{aligned}
$$

The thing we're observing is the difference between the mean of $n_1$ samples from a (potentially ficitious) variable $X_1$ and $n_2$ from $X_2$: $$\overline{X}_1 - \overline{X}_2 = \frac{1}{n_1} \sum_{i=1}^{n_1} X_{1i} - \frac{1}{n_2} \sum_{i=1}^{n_2} X_{2i}.$$ It would be nice if our statistic was distributed like $\mathcal{N}(0, 1)$, so we compute the variance of this observation:

$$
\begin{aligned}
\mathrm{Var}\left[ \overline{X}_1 - \overline{X}_2 \right]
  &= \frac{1}{n_1^2} \sum_i \mathrm{Var}[X_1] + \frac{1}{n_2^2} \sum_i \mathrm{Var}[X_2] \\
  &= \frac{1}{n_1^2} n_1 s_p^2 + \frac{1}{n_2^2} n_2 s_p^2 \\
  &= \left( \frac{1}{n_1} + \frac{1}{n_2} \right) s_p^2.
\end{aligned}
$$

So the statistic for this test is just the observation over its variance: $$t = \frac{\overline{X}_1 - \overline{X}_2}{s_p \sqrt{\frac{1}{n_1} + \frac{1}{n_2}}}.$$

The confusing thing is that $\overline{X}_1$, $\overline{X}_2$, and $s_p$ are all random variables. We know how to take the sum (or difference) of two random variables (i.e., how to figure out the distribution of the numerator), but it's not immediately obvious how to find the distribution of the whole thing, which has a different random variable in its denominator.

#### Computational approach

- Compute the observed $t$ statistic

- Compute the observed sizes, means, and standard deviations for the two sample populations

- Many times, generate two sets of random variates. One set of variates is drawn from a normal distribution with the first sample mean and variance.

- For each iteration, compute the simulated $t$ statistic.

- The empirical $p$-value is the fraction (not true! need $r+1/n+1$) of simulated statistics that are greater than the observed statistic.

### Unequal variance (Welch's)

This is the Behrens-Fisher problem. It stumped Fisher! He came up with a weird statistic with a weird distribution (Behrens-Fisher), but it didn't really stick, since he couldn't calculate confidence intervals (?).

Instead, people went for the Welch-Satterthwaite equation, which approximates the interesting distribution using a more handy one by matching the first and second moments. (Maybe worth discussing those? Or just say mean and variance?)

## anova

Say you have some (equally-sized) groups. Each group was drawn from a normal distribution (all with the same variance). Are the data consistent with the model in which all those groups have the same mean?

The statistic is $F \equiv \frac{\mathrm{MS}_B}{\mathrm{MS}_W}$, where $MS_B$ is the mean of the squares of the residuals(?) between the group means and the grand mean ("between") and $MS_W$ is the mean of the squares of the residuals between the data points and the group means ("within").

Again, focus on what's the population we're sampling from. It's easy to think about a finite population, where you can just do all the possible combinations and compare their $F$ statistics. Then move on to say that, if you believe that the particular variances and means you measured are the exact, true distribution that you're sampling from, ask what happens when you sample from that infinite population.

### z-test example

What's the nonparametric equivalent of this? It's just saying what the empirical cdf is! Then say, if you really truly believe your mean and standard deviation, then you can do that.

In other words, you say you are absolutely sure what population you are drawing from. The same is actually true of the _t_-test, except that the _z_-test is asking about a single value, distributed like $N(\mu, \sigma^2)$, while the _t_-test is about the mean of the $n$ points, which is distributed like $N(\mu, \sigma^2/n)$.

## Paired differences

### Historical example and motivation

Darwin's thing with the pots, as described in Fisher's _Design of Experiments_

We'll make a tower of the kinds of assumptions made to test Darwin's hypothesis.

### Sign test

Assume that it's meaningful if a hybrid plant is taller than a self-fertilized plant, but don't assign any meaning beyond that. Then the data are effectively dichotomized: you get some number of cases in which one is taller and some number of cases in which the other is taller.

Better to say that we're sampling from any distribution that has zero median. You could even say you're sampling from _all_ distributions. That's confusing, mathematically, because there are infinitely many distributions, and it's not obvious how you should sample from that functional space, but it works out, because all those distributions will have the same distribution of pluses and minuses.

This is now just a binomial test.

### Rank test (Mann-Whitney $U$)

Assume that the _ranks_ of the differences are meaningful.

Now you're sampling from any distribution that is symmetric about zero. That means it has zero median also.

### Fisher's weird sum test

Not sure if there's any name for this. Assume that the actual values of the differences are meaningful.

### Welch's $t$-test

Assume that the two populations are normally distributed and, and therefore that that the variances of the populations are meaningful. Then you can infer where this set of differences would stand in an infinite set of such differences.

For early statisticians, this was really appealing, mostly from a computational point of view: you could actually compute the mean and standard deviation with pen and paper in a reasonable amount of time, but you definitely couldn't do all $2^n$ different ways of taking sums. Fisher does it for one example in his book, and I'm sure it was pretty crazy. He makes it clear that he went to great lengths to do it, and his conclusion is that the results are basically the same, so you should probably be doing the easier thing and not worry about it. Nowadays it's gotten pretty easy to do the other thing!, so it's

## Wilcox test and Mann-Whitney test

**Walsh averages and confidence intervals**, from [here](http://www.stat.umn.edu/geyer/old03/5102/notes/rank.pdf)

There a few different names for these things:

- One-sample test: is this distribution symmetric about zero (or whatever)?

- Two-sample unpaired (independent; Mann-Whitney): does one of these distributions "stochastically dominate" the other (i.e., is it that a random value drawn from population $A$ is more than 50% probable to be greater than a random value from $B$)?

- Two-sample paired (dependent): are the differences between paired data points symmetric about zero?

### Wilcoxon

1.  For each pair $i$, compute the magnitude and sign $s_i$ of the difference. Exclude tied pairs.

2.  Order the pairs by the magnitude of their difference: $i=1$ is the pair with the smallest magnitude. Now $i$ is the rank.

3.  Compute the $W = \sum_i i s_i$.

Thus, the bigger differences get more weight.

(There might be a way to do a visualization of this: as you walk along the data points, you get a good bump for every rank that is in the "high" data set, and you get a bad hit for every rank that is not. Then it settles out pretty quickly, and you want to know the meaning of the final intercept.)

For small $W$, the distribution has to be computed for each integer $W$. For larger values ($\geq 50$), a normal approximation works.

Compare the sign test, which does not use ranks, and which assumes the median is zero, but not that the distributions are symmetric. That's just a binomial test of the number of pluses or minuses you get. It's like setting the weights, which in $W$ are the ranks, all equal.

### Mann-Whitney

1.  Assign ranks to every observation.

2.  Compute $R_1$, the sum ranks that belong to points for sample 1. Note that $R_1 + R_2 = \sum_{i=1}^N = N(N+1)/2$.

3.  Compute $U_1 = R_1 - n_1(n_1+1)/2$ and $U_2$. Use the smaller of $U_1$ or $U_2$ when looking at a table.

At minimum $U_1 = 0$, which means that sample 1 had ranks $1,2,\ldots,n_1$. Note that $U_1 + U_2 = n_1 n_2$.

For large $U$, there is a normal distribution approximation.

#### Generation

Say you have $N$ total points and $n_1$ in sample 1. Find all the ways to draw $n_1$ numbers from the sequence $1, 2, \ldots N$. Compute $U$ for each of those. Voila.

Note that, if you fix $n_1$, then you don't have to subtract the $n_1(n_1+1)/2$ to get the right $p$-value.

## Statistical power: Cochrane-Armitage test

[Do I need this example, if I'm showing the Zea mays choices instead?]{.mark}

We never want to run just any test: we want to use the test that is most capable of distinguishing between the scenarios we're interested in. Usually this is a matter of choosing the test that has the right assumptions: the one-sample _t_-test is more powerful than the Wilcoxon test if the data come from a truly normally-distributed population.

In other cases, you might have more flexibility. There's a somewhat obscure test that is, I think, a great illustration of this.

Imagine that you have some data with a dichotomous outcome for some categorical predictor value. One classic example is drug dosing: you think that, as the dosage of the drug goes up, you have more good outcomes than bad outcomes. Did a greater proportion of people on board the Titanic survive as you go up from crew to Third Class to Second to First? Did the proportion of some kind of event increase over years? Technically, this means you have a $2 \times k$ table of counts, with two outcomes and $k$ predictor categories.

Outcome Dose 1 Dose 2 Dose 3

---

Good 1 5 9 Bad 9 4 1

You could use a $\chi^2$ test with equal expected frequencies across the columns. In other words, there might be more "good" than "bad" outcomes, but you don't expect that proportion to differ meaningfully across categories. You would pool the data across categories, use the observed proportion of good outcomes as you best guess of the true proportion $f$, and compare the actual data with you expectation that a fraction $f$ of the counts in each column are "good".

In our examples, we think the data have some _particular_ kind of pattern. The $\chi^2$ test doesn't look for any particular pattern; it just looks for any deviation from the null. The test statistic for the $\chi^2$ distribution is based around the sum of the square deviations from the expected values, usually written $\sum_i (O_i - E_i)^2$, with some stuff in the denominator to make the distribution of the statistic easier to work with. If the sum of the squared deviations is too large, then we have evidence that the observed values are not "sticking to" the expected frequencies.

The trick I'm going to show you is to keep the same null hypothesis---that outcome doesn't depend on dose---but adjust the test so that it's more sensitive to particular kinds of dependencies.

This is a fair approach because we're still just trying to say, "OK, say you (the nameless antagonist) were right, and there really was no pattern in the data. Then I'm free to make up any test statistic, so long as, if you're right, we can show that the observed data were likely to have arisen by chance."

To start constructing the test, think about each flip as a weighted binomial trial. We'll use these weights to adjust the test statistic to be more sensitive to what we suspect the true pattern in the data is, but we'll need to derive the distribution of the test statistic so that we can satisfy the nameless antagonist.

Say each flip $y_i$, which is in some category $x_i$, gets some associated weight $w_i$. A really simple statistic would be $\sum_i w_i y_i$, the sum of the weights of the "successful" trials. It would be nice to have this be zero-centered: $$\sum_i \left\{ w_i y_i - \mathbb{E}\left[ w_i y_i \right] \right\} = \sum_i w_i (y_i - \overline{p}),$$ where $\overline{p} = (1/N)\sum_i y_i$.

It would also be nice for this to have variance 1, so we can divide by the square root of $$\mathrm{Var}\left[ \sum_i w_i (y_i - \overline{p}) \right] = \overline{p} (1-\overline{p}) \sum_i w_i^2$$ to produce the statistic $$T = \frac{\sum_i w_i (y_i - \overline{p})}{\sqrt{\overline{p} (1-\overline{p}) \sum_i w_i^2}}.$$

You could also conceive of this being a table with two rows and some number of columns. We bin the trials by their weights: all trials with the same weight are in the same column. Successes go in the top row; failures in the bottom. Now write $t_c$ as the weight of the trials in the $c$-th column, $n_{1c}$ is the number of successful trials with weight $t_c$ (i.e., in column $c$), and $n_{2c}$ is the number of failures. Then some math shows that you can rewrite $T$ as $$T = \frac{\sum_c w_c (n_{1c} n_{2\bullet} - n_{2c} n_{1\bullet})}{\sqrt{(n_{1\bullet} n_{2\bullet} / n_{\bullet\bullet}^2) \sum_c n_{\bullet c} w_c^2}}$$ where $n_{r\bullet}$ are the row margins, $n_{\bullet c}$ are the column margins, and $n_{\bullet\bullet}$ is the total number of trials.

_N.B._: The wiki page gives a different answer, but I don't trust it, since the variance formula doesn't assume independence of the $y_i$. A fact sheet about the PASS software that shows the formula in terms of the $y_i$ seems to make a mistake by using $i$ as an index both for individual trials and for the weight categories.

The confusing thing here is how to pick the weights. This test is mostly used to look for linear trends: imagine that each $y_i$ is associated with some $x_i$, so that the weights would be $x_i$ or $x_i - \overline{x}$. Why you pick these exact weights has to do with the _sensitivity_ of the test. There could, of course, be a nonlinear trend, like a U-shape, that would lead to a zero expectation for this statistic. The $\chi^2$ test can find that, but Cochrane-Armitage with these weights cannot.

To see why you use those weights for a linear test, imagine that $p_i \propto x_i$, and zero-center the $x_i$ such that $p_i = m x_i + \overline{p}$.

Then the question is what $w_i$ maximize $\mathbb{E}[T]$? You can quickly see that this is equivalent to maximizing $\sum_i w_i x_i / \sqrt{\sum_i w_i^2}$, and taking a derivative with respect to $w_j$ shows that, at the extremum, $x_j \sum_i w_i^2 = w_j \sum_i w_i x_i$, which $w_i = x_i$ for all $i$ satisfies. So those weights are the best way to get a large statistic if you think that there actually is a linear test.

[^1]: I apologize that $p$ means the expected proportion of heads and $p$-value means something totally different.
