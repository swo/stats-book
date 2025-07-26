Before diving into that equation, note that the $X_i$ and $e{X}$ are random variables, and note that they are not independent: the value of $\overline{X}$ certainly depends on each of the $X_i$. So first let's imagine a simpler case, where we're in a universe where happen to know the expected value of the distribution we're trying to determine the variance of. To make the equations simpler to read, I'll use the standard notation $\mu \defeq
\expect{X}$.[^1] In this case, having known expected value ("kEV"), our estimator will be a little simpler: $$\hat{\mathbb{V}}_{X,\mathrm{kEV}} = \frac{1}{N} \sum_i ( X_i - \mu )^2$$

### Bias in estimators of variance

The known-expected-value estimator is unbiased: $$\begin{aligned}
\expect{\hat{\mathbb{V}}_{X,\mathrm{kEV}}}
  &= \expect{\frac{1}{N} \sum_i ( X_i - \mu )^2} \\
  &= \frac{1}{N} \sum_i \expect{X_i^2 - 2\mu X_i + \mu^2} \\
  &= \expect{X^2} - 2 \mu \expect{X} + \mu^2 \quad\text{(since $X_i$ are identic. distrib.)} \\
  &= \expect{X^2} - \mu^2 \\
  &= \var{X}. \quad\text{(since $\var{X} = \expect{X^2} - \expect{X}^2$)}
\end{aligned}$$ So if we happen to know the true expected value $\mu$, then we can compute variance in the naive way, and it's exactly correct.

Now we can use this result to pull a little mathematical trick. Even if we don't know $\mu$ and $\var{X}$, we do know they exist, so we can manipulate [\[eq:estimator-vx1\]](#eq:estimator-vx1){reference-type="eqref" reference="eq:estimator-vx1"} to make it easier to work with. Specifically, I'm going to write "standardized"[^2] random variables: $$Z_i = \frac{X_i - \mu}{\sqrt{\var{X}}} \implies X_i = \sqrt{\var{X}} Z_i + \mu$$ It should be easy to see that $Z_i$ has expected value 0 and variance $\expect{Z_i^2} = 1$, and $\overline{Z}$ has expected value 0 and variance $\expect{\overline{Z}^2} = 1/n$. Now I'll rewrite [\[eq:estimator-vx1\]](#eq:estimator-vx1){reference-type="eqref" reference="eq:estimator-vx1"} so it has $Z_i$ instead of $X_i$:

$$
\begin{aligned}
\hat{\mathbb{V}}_X
  &= \frac{1}{n} \sum_i \left( X_i - \overline{X} \right)^2 \\
  &= \frac{1}{n} \sum_i \left( \left[\sqrt{\var{X}} Z_i + \mu\right] - \left[ \sqrt{\var{X}} \overline{Z} + \mu \right] \right)^2 \\
  &= \frac{\var{X}}{n} \sum_i \left( Z_i - \overline{Z} \right)^2
\end{aligned}$$ Analogous to how we showed that
$\var{X} = \expect{X^2} - \expect{X}^2$, some algebra shows that
$$\sum_i \left(Z_i - \overline{Z}\right)^2 = \sum_i Z_i^2 - n \overline{Z}^2.$$
Thus, the expected value of this estimator is $$\begin{aligned}
\expect{\hat{\mathbb{V}}_X}
  &= \expect{\frac{\var{X}}{n} \sum_i \left( Z_i - \overline{Z} \right)^2} \\
  &= \frac{\var{X}}{n} \expect{\sum_i Z_i^2 - n \overline{Z}^2} \\
  &= \frac{\var{X}}{n} \left( \sum_i \expect{Z_i^2} - n \expect{\overline{Z}^2} \right)\\
  &= \frac{\var{X}}{n} (n - 1) \quad\text{(using the little identities)} \\
  &= \frac{n-1}{n} \var{X}.
\end{aligned}$$ Note that the expected value of our estimator is not
equal to the thing we're trying to estimate, so this estimator is
biased! It systematically *underestimate* the true variance.
Interestingly, like when we tried to cook up an estimator for the upper
limit of a uniform distribution, we ended up with something that was off
by a multiplicative factor. The solution is to make a new estimator that
has the inverse, cancelling factor out front:
$$\hat{\mathbb{V}}_{X,\mathrm{unbiased}}
  = \frac{n}{n-1} \times \frac{1}{n} \sum_i \left(X_i - \overline{X}\right)^2
  = \frac{1}{n-1} \sum_i \left(X_i - \overline{X}\right)^2.$$ Using
$n-1$ instead of $n$ in the denominator is known as Bessel's
correction.[^3]

This equation may look familiar as the "sample variance", typically
written
$$s^2 = \frac{1}{n-1} \sum_i \left(x_i - \overline{x}\right)^2.$$ I
always wondered why, in Stats 101, I was told that the mean had $n$ in
the denominator but variance had $n-1$.[^4] This is why! The point is to
make an unbiased estimator.

[^1]: Do remember, however, that $\overline{X}$ is a random variable---a
    function of the data---while $\expect{X}$ is a function of the
    distribution, and therefore just a single matter-of-fact number.

[^2]: You're probably used to seeing standardized *normal* variables
    written this way, but note that I haven't assumed that the $X_i$ are
    normally distributed. This logic holds for any random variable that
    has a well-defined expected value and variance.

[^3]: Gauss was using the correction before Bessel discovered it, as
    early as 1823. I hope the late date, 1823, impresses upon you how
    subtle this reasoning must be. The ancient Greeks were using the
    arithmetic mean, but an unbiased estimator for standard deviation
    took thousands of years.

[^4]: The traditional answer says that it's about "degrees of freedom":
    you're "using up" one "degree of freedom" when computing
    $\overline{x}$, so you only have $n-1$ to compute $s^2$. "Degrees of
    freedom" is an ill-defined concept that I don't think it useful.
    Explaining one mystery in terms of another mystery is not good
    pedagogy!

# Things to include

- Gauss: a minimum-variance, mean-unbiased estimator minimizes the
  squared-error loss function. Laplace: among median-unbiased
  estimators, a minimum-average-absolute-deviation estimator minimizes
  the absolute loss function. Maybe it's better to allow some bias so
  you can get less variance. That's the domain of statistical theory.
  [Move to MLE section?]{.mark}

- Fisher's crazy sum test is the same thing as is used in *TRANSIT*
  (DeJesus *et al*.): they treat TA sites in the same gene as
  independent; the statistic is the difference in the sum of the
  (normalized) number of insertions in two treatments; the null
  distribution is generated by shuffling the values across the two
  datasets. OK, it's not *exactly* like Fisher's test, since it's not
  paired, but it's pretty close. Fisher probably wouldn't have wanted to
  to the $\binom{n}{2}$ options, compared to the $2^n$ that he did.
  [Example of how people come up with tests?]{.mark}

## Estimators about estimators

[Move this up, into the descriptive section]{.mark}

### Jackknife

You have $n$ data points and compute an estimator $\hat{\theta}$ for
some population parameter $\theta$. If you don't know how the population
is structured, then it's not clear what you expect the variance of
$\hat{\theta}$ to be. How sure can you be of this value? In terms of
inference, can you make any inference with it?

Compute the *jackknife replicates*[^1] $\hat{\theta}_j$, which are the
estimators computed using all the data points except the $j$-th one.

That seems like a weird thing to have done, but you can use them to
compute two handy things:

1.  An estimate of the variance of the estimator. This can help you for
    description---by giving a confidence interval(?)---and for
    inference---by giving you a sense of the "random" ranges you would
    expect from two samples.

2.  An estimate of the bias in the estimator. This is helpful if you
    don't want want your estimator to be biased but you don't know how
    to fix it.

#### Jackknife variance estimator

The variance estimator is
$$\widehat{\mathrm{Var}}_\mathrm{jk}[\hat{\theta}] := \frac{n-1}{n}  \sum_j \left( \hat{\theta}_j - \hat{\theta}_{(\cdot)} \right)^2,$$
where $\hat{\theta}_{(\cdot)}$ is the average of the jackknife
replicates:
$$\hat{\theta}_{(\cdot)} := \frac{1}{n} \sum_j \hat{\theta}_j.$$ In
other words, it's the variance of the jackknife replicates with some
rescaling:
$$\mathrm{Var}[\hat{\theta}_j] = \frac{1}{n-1} \sum_j \left( \hat{\theta}_j - \hat{\theta}_{(\cdot)} \right)^2 \implies
  \widehat{\mathrm{Var}}_\mathrm{jk}[\hat{\theta}] = \frac{(n-1)^2}{n} \mathrm{Var}[\hat{\theta}_j].
$$

The reason for that scaling factor is beyond the scope of this book (Efron & Stein 1981?), but the exercise gives you a sense of why it has to be true for a specific case.

Some other work, also beyond the scope of this book, shows that the jackknife estimate of variance is biased: it tends to overestimate the true variance. This makes the jackknife a conservative tool.

**Exercise**. Let $\theta$ be the mean. Show that the scaling factor is what we think. Hints:

- Show that $\hat{\theta}_{(\cdot)}$ is the sample mean.

- Show that $\hat{\theta}_j - \hat{\theta}_{(\cdot)} = (n \overline{x} - x_j) / (n - 1)$.

- Show that that value is equal to $(\overline{x} - x_j) / (n - 1)$.

That exercise is from McIntosh's bioRxiv about jackknife resampling.

#### Jackknife bias estimator

The jackknife estimate of bias is $(n-1) \left( \hat{\theta}_{(\cdot)} - \theta \right)$. This is the sum of the deviations of the jackknife replicates from the observed value $\hat{\theta}$. Again, the reason that you would take the average deviation and scale it up to the sum is beyond the scope.

However, if you have an expectation about the bias in an estimator, you can make an unbiased estimator by subtracting out that bias: $$\hat{\theta}_\mathrm{jk} := \hat{\theta} - \widehat{\mathrm{Bias}}_\mathrm{jk}[\theta].$$

**Exercise**. Show that the jackknife estimate of bias for the variance gives you the familiar unbiased variance estimator.

**Exercise**. Something about the maximum estimator?

#### Pros and cons of the jackknife

It's a piece of cake to implement. There are only $n$ replicates to do, so it's tractable. Those replicates are deterministic, so you only run it once.

The cons are that it doesn't always work. For example, a jackknife estimate of the variance of a median (**swo check Knight**) is not consistent. It's also overly conservative: it's biased toward higher variances. You can rescue some properties if you move to a delete-$d$ resampling and pick $d$ from the correct range.

### Bootstrap

# Example from Efron, "Thinking the unthinkable"

There's some true distribution $f_X(x)$, and you're approximating it with $\hat{f}_X(x)$, which is a pmf. If you took $N$ data points, then bootstrapping means that you're picking a vector $\vec{c}$, where $c_i$ is the number of times that the $i$-th data point makes it into the bootstrap sample. This begs the question, how is $\vec{c}$ behaved? It's just a multinomial, with probability $1/N$ for each of the $N$ cells.

Normally you compute a statistic $T(\vec{x})$ of the data. Instead, formulate this in terms of a function $g(\vec{c})$ If you can write $T(\vec{x}) = \sum_i t(x_i)$, then $g(\vec{c}) = \sum_i (c_i/N) t(x_i)$. In a Taylor expansion around $\vec{c}_\mathrm{ML} = (1, 1, \ldots, 1)$: $$g(\vec{c}) = g(\vec{c}_\mathrm{ML}) + \sum_i \frac{dg}{dc_i} (c_i - 1) + \mathcal{O}(c_i^2)$$ So the variance of the values $g(\vec{c})$ that you will get from bootstrapping is approximately $$\begin{aligned}
\expect{\left[g(\vec{c}) - g(\vec{c}_\mathrm{ML})\right]^2}
  &= \expect{\left(\sum_i \frac{dg}{dc_i} (c_i-1)\right)^2} + \mathcal{O}(c_i^2) \\
  &= \expect{\sum_i \left( \frac{dg}{dc_i} (c_i-1)\right)^2} + \mathcal{O}(c_i^2) \\
  &= \sum_i \left(\frac{dg}{dc_i}\right)^2 \expect{(c_i-1)^2} + \mathcal{O}(c_i^2) \\
\end{aligned}$$

And then an $n^2$ comes out? The point is that the jackknife is basically doing a finite estimation of the gradient, by leaving out a single point at a time.

# What does it mean to "sample"?

[Earlier in text, get clearer about RVs and their "realizations". and "samples"]{.mark}

Does it make sense to compute a confidence interval when you're sampled all the 50 United States?

**Finite correction factor** to point out that there's a difference between simple random sampling and something else. Then need to explain what simple random sampling is!

## _t_-distribution

[Maybe just mention in passing how difficult the math gets when you want to estimate many quantities simultaneously? Contrast t- and z-tests]{.mark}

Let's think about how to construct that method. Say you knew the true variance $\sigma^2$. Then we know that the sample means are drawn from $\mathcal{N}(0, \sigma^2/n)$. So it's pretty easy to see that $(\overline{x} - \mu) / (\sigma^2) \sim \mathcal{N}(0, 1)$, from which the familiar $1.96$, etc. come.

What if you _don't_ know the true variance? The means are still drawn from $\mathcal{N}(0, \sigma^2/n)$, but now the sample variance is also a random variable.

We know the confidence interval is some function of the sample mean and variance, and let's guess that it's symmetric about the sample mean and is some linear function of sample variance: $$\mathrm{CI}_\pm(\overline{x}, s) = \overline{x} \pm A s.$$ We want to find $A$ such that $$\mathbb{P}\left[ \mathrm{CI}_- < \mu < \mathrm{CI}_+ \right] = 95\%,$$ or, if we're willing to trust in symmetry, $$2.5\% = \mathbb{P}\left[ \mathrm{CI}_- > \mu \right] = \mathbb{P}\left[ \frac{\overline{x} - \mu}{A} - s > 0 \right].$$ We know the distribution of the first thing: $$(\overline{x}-\mu)/A \sim \mathcal{N}\left(0, \frac{\sigma^2}{n A^2}\right).$$ Some math shows that $$\frac{(n-1) s^2}{\sigma^2} \sim \chi^2(n-1).$$

Call the first thing $K$ and the second $L$. We're interested in the distribution of $M \equiv K - L$: $$f_M(m) = \int_0^\infty f_K(m + l) f_L(l) \,\mathrm{d}l,$$

where the limits come from the fact that variance is positive. You're probably not excited to do this integral, which was considered a major achievement (well, it was the thought leading up to the integral, which we've just outlined, but whatever). This major achievement was made by William Sealy Gosset, who made it while he was a researcher for Guinness ensuring the quality of their beer. Guinness had a policy of not allowing its employee to publish their results, so Gosset signed his paper "a student", so the result of that integral is now called Student's _t_-distribution:

$$
f_t(x; \nu) = \frac{\Gamma(\frac{\nu+1}{2})}{\sqrt{\nu\pi} \Gamma\left(\frac{\nu}{2}\right)}
  \left(1+ \frac{x^2}{\nu}\right)^{-\frac{\nu+1}{2}},$$ where the (badly
named) "degrees of freedom" $\nu$ is $n-1$ for our purposes. I write
this out fully because it is one of the things we will *not* derive in
this book.

# Contingency tables

[Move Fisher's exact, Barnard, chi-square up, into a section on
p-values? Or maybe statistical power?]{.mark}

These are nice examples for how to do statistical thinking.

## Barnard's test

The classic example is whether a certain treatment causes more of the
outcome of interest than just doing nothing. In medicine, that means
splitting your participants into a placebo group and a treatment group
and asking what fraction of each gets well. In a biology experiment, you
might split your mice into a treatment group and a control group and ask
what proportion of the mice in each group get cancer.

In statistics jargon, this is called a $2 \times 2$ contingency table:

  Group         Outcome $p$   Outcome not-$p$   Row sums
  ------------- ------------- ----------------- ----------
  A             $a$           $c$               $m$
  B             $b$           $d$               $n$
  Column sums   $r$           $s$               $N$

Because we picked $m$ and $n$, the sizes of the two groups, those are
fixed parameters. The question is whether the way that $m$ gets
distributed into $a$ and $c$ (and that way that the $n$ get put into the
$b$ and $d$) is consistent with there being a common probability $p$ of
the outcome of interest.

So we might say that $a$ is distributed like a binomial distribution
with $m$ draws and probability $p_a$ of success, and $b$ is distributed
like a binomial with $n$ draws and a probability of $p_b$ of success.
The null hypothesis is that $p_a = p_b$. What's the likelihood of the
data given the null?

If we didn't assume the null, and gave the two binomials their own
probabilities, the likelihood of the data would be:
$$P(a, b | p_a, p_b) = \mathrm{Bin}(a; m, p_a) \times \mathrm{Bin}(b; n, p_b).$$
But, given that the probabilities are the same, we can collapse it:
$$\begin{aligned}
\mathcal{P}[a, b | p_a = p_b = p] &= \mathrm{Bin}(a; m, p) \times \mathrm{Bin}(b; n, p) \\
  &= \binom{m}{a} p^a (1-p)^{m-a} \times \binom{n}{b} p^b (1-p)^{n-b} \\
  &= \binom{m}{a} \binom{n}{b} p^{a+b} (1-p)^{m+n-(a+b)} \\
  &= \frac{m! \, n!}{a! \, b! \, c! \, d!} p^r (1-p)^s.
\end{aligned}
$$

This result is a little confusing[^2], for two reasons:

1.  The probability $p$ of the outcome of interest might be interesting to design a later experiment, but it's _not_ interesting for designing a test. We certainly don't want to deliver a result like, "Well, if the null hypothesis is true, _and_ $p$ happens to be exactly such-and-such, then your $p$-value is so-and-so." The value $p$ is called a _nuisance parameter_ since we don't actually care about its value.

2.  We're usually not interested in the likelihood of exactly this data, but rather in the likelihood of data _at least this extreme_. We usually measure "extremeness" using a statistic---a single number---so it's clear that "more extreme" means "bigger" (or "smaller" or "bigger or smaller", depending on if it's a one-sided or two-sided test). Here, we have two numbers, $a$ and $b$, so there aren't two "sides" to the distribution: there are four!

To resolve the first point, we say that the null hypothesis $p_a = p_b = p$ doesn't restrict us to a particular value of $p$. In other words, the null hypothesis, which functions as a sort of Annoying Skeptic, is free to pick $p$ to make our results as uninteresting as possible. Mathematically, this means that, when computing the $p$-value, we should optimize over all values of $p$, choosing the one that makes our results as uninteresting as possible (i.e., which maximizes the $p$-value).

We can't really "resolve" the second point, since it demonstrates that our previous way of thinking about extremeness was not sufficient for all cases. As Barnard notes in his original paper[^3], there are actually many ways to choose the pairs $(a, b)$ that produce a $p$-value more than our threshold. This gets into some fancy footwork to articulate exactly how you should pick this area, but the basic results are pretty intuitive: when $a/m$ and $b/n$ are similar, you tend to be under the rejection threshold; when they are far apart, you tend to be over.

The interesting point here is that, whatever fancy footwork you pick to choose that region, and no matter how "reasonable" your footwork is, it's still footwork that doesn't obviously follow from the simple definition of a hypothesis test. We'll encounter this problem again in Bayesian statistics, when we find that the Bayesian analog of a confidence interval is not unique: there are many ranges of values that are compatible with our ignorance.

## Fisher's test to the rescue(?)

If you've worked with contingency tables, you're probably saying, "I've never heard of this crazy Bernard's test, with its weird multi-sided rejection space and its requirement to maximize over $p$. We have Fisher's exact test, which is the exactly right test to use here!"

Looking at the same contingency table, Fisher's test asks, given the row marginals $m$ and $n$, the first column marginal $r$, and the grand total $N$, what is the probability of a table at least this extreme?

This is just a combinatoric problem: if you're as likely to assign items in $m$ to $a$ as to $c$ (and, analogously, to assign items from $n$ to $b$ or $d$), then "what's the probability of this table" is equivalent to asking "given the marginals, how many ways are there to choose this table?". More specifically, how many ways are there to choose $a$ items from a bank of $m$ items and $b$ items from a bank of $n$, given that we chose $r = a + b$ items from the total $N$? Mathematically: $$\mathbb{P}[a | m, n, r, s] = \frac{\binom{m}{a} \binom{n}{b}}{\binom{N}{r}} = \frac{m! \, n! \, r! \, s!}{N! \, a! \, b! \, c! \, d!}.$$

Computing the $p$-value is easier here than with Barnard's test because we need to keep the row _and column_ marginals the same. In Barnard's test, we just kept the row marginals constant, because we considered those as fixed parameters, corresponding to things like the number of patients we assigned to each of the placebo and treatment groups. It doesn't make sense to allow the Annoying Skeptic to fiddle with those values.

In Banard's test, we _did_ allow the Annoying Skeptic to fiddle with the column marginals, since it wasn't clear, before the experiment began, that $r$ would have the outcome of interest. In other words, we didn't know that $r$ people in both the placebo and treatment groups would get well.

Fisher's test, however, _does_ keep the column marginal constant. This makes it a lot easier to compute the $p$-value. First, the nuisance parameter $p$ doesn't appear in the likelihood, so we don't need to do the weird maximization. Second, we only need to vary one value, $a$ (or, equivalently, $b$), since, if you know the marginals, there is only one axis along which to change the values in the table. In other words, if you know $$\begin{aligned}
a + c &= m \\
b + d &= n \\
a + b &= r,
\end{aligned}$$ then that's three equations with four unknowns ($a$, $b$, $c$, $d$), so specifying any one of $a$, $b$, $c$, or $d$ specifies all the others. (You might be looking for a fourth equation $c + d = s$, but you can get that by adding the first two equations and subtracting the third.)

Here's an example:

Group Success Failure Row sums

---

A 1 9 10 B 11 3 14 Column sums 12 12 14

There's only one way to make this table more "extreme" without changing the marginals: you can take the one group A success and make it a group A failure and simultaneously make a group B failure into a group B success. Similarly, there's only one way to make this table less extreme: turn a group A failure into success, and turn a group B success into failure.

So keeping the column sums constant made it way easier to compute the $p$-value: count this table and all the tables with a more extreme upper-left or bottom-right and see if your summed probability hits the rejection threshold.

However, this simplicity came at a cost, which you may have noticed: does it make sense to keep the columns constant? Experimentally, this means that you're restricting the Annoying Skeptic to only consider cases in which, say, the number of patients who got well _in both groups_ is equal to the experimentally observed value. This is a little weird. It suggest that your experimental design was like this:

1.  Pick $m$, $n$, and $r$.

2.  Assign $m$ patients to placebo and $n$ to treatment.

3.  Wait until $r$ patients _across both groups_ have gotten well.

4.  Stop the experiment.

This is almost certainly not reflective of how typical experiments are run[^4].

**Fisherian small data**

**What happens if I use the "wrong" test? Chi-square as an example of wrongness**

# Regression

[Make this a chapter? In descriptive statistics? Or just say this regression is an ML problem? Link and error distributions.]{.mark}

# $\chi^2$ test

[Merge with section above on chi-square]{.mark}

Say you have $k$ iid standard normal random variables: $$X_i \stackrel{\text{iid}}{\sim} \mathcal{N}(0, 1).$$ Then $Y = \sum_{i=1}^k x^2$ (??) is $\chi^2$-distributed with $k$ degrees of freedom.

Let's start with a simple case where you have a table with two cells with expected probabilities $p_1$ or $p_2 = 1-p_1$. We got $n$ total observations, with $O_1$ in the first cell and $O_2 = n - O_1$ in the second. You probably remember how to compute the test statistic from Stats 101: $$\chi^2 = \sum_{k=1}^2 \frac{(O_i - E_i)^2}{E_i} = \frac{(O_1 - np_1)^2}{np_1} + \frac{(O_2 - np_2)^2}{np_2},$$ where $E_i$ is the "expected" number of counts in each cell.

Consider the numerator of the second term: $$(O_2 - np_2)^2 = \left[(n - O_1) - n(1 - p_1)\right]^2 = (-O_1 + np_1)^2 = (O_1 - np_1)^2.$$ Handy, that's the same as numerator of the first term! That means we can re-write things: $$\chi^2 = \frac{(O_1 - np_1)^2}{n}\left( \frac{1}{p_1} + \frac{1}{p_2}\right).$$ A little algebra shows that $1/p_1 + 1/p_2 = 1/p_1(1-p_1)$, so that $$\chi^2 = \frac{(O_1 - np_1)^2}{np_1(1-p_1)} = \left( \frac{O_1-np_1}{\sqrt{np_1(1-p_1)}} \right)^2.$$ That might look terrible, but it's actually pretty cool. Here's why: $O_1$ is the observed value, $np_1$ is the expected mean, and $\sqrt{np_1(1-p_1)}$ is the standard deviation of the binomial distribution. I'll re-write that last equation with more suggestive notation: $$\chi^2 = \left( \frac{x_1 - \mu_1}{\sigma_1} \right)^2$$

This certainly _looks_ like a $\mathcal{N}(0, 1)$ variable, although we said previously that the counts in the two cells follow a binomial distribution. This is where the central limit theorem comes in: the sum of any large set of (well-behaved) iid random variables approaches a normal distribution. The binomial distribution approaches the normal distribution particularly quickly such that (if the distribution is not highly skewed) you only need about 5 counts for the normal approximation to be pretty good.[^5]

So, so long as each cell has (ish) 5 or more counts, then we can approximate the binomial variables with normal variables, which means that the test statistic $\chi^2$ that I wrote is actually just the square of a single, standard normal variable, which happens to be $\chi^2$-square distributed with 1 degree of freedom. Two cells in the table ($k=2$) meant $k-1=1$ degrees of for the $\chi^2$ distribution.

The same result holds, that the sum of the $(O_i - E_i)^2/E_i$ values follows a $\chi^2$ distribution with $k-1$ degrees of freedom, for $k>2$. The math is a lot more involved because the $k$ cells in the table are distributed according to a multinomial distribution. In other words, conditioned on the total number $n$ of counts, the values in the different cells are not independent: if cell 1 has a lot of counts, cells 2, 3, etc. can't have that many cells. Like we've seen before, covariance makes the calculations hard! Nevertheless, the same restrictions apply: you can only count on the normal approximation working if you have enough counts in every cell.

# Coda

[New material]{.mark}

\- Bayes - Bayes sampling? - MCMC for copmlex models? - Nature Biotech Bayes example - Optimization for MLE - Regression and mixed models - Random variable neq variable with a random value - When discussing RVs, note that cdf defines it. Then don't ever talk about events, just look at joint cdfs, etc. Make this a whole section unto itself. - Do joint pdf's so it's easier to talk about independence

Tony's ideas:

\- Neyman Pearson lemma - Likelihood ratio tests - Why is frequentist so good? CLT, convergence, etc. - Information theory, model simplicity, AIC?

[^1]: The "jackknife" method is so called because Tukey compared the method, which is "rough-and-ready", to another rough-and-ready tool, the pocket knife, also known as a jackknife. Although this name has the disadvantage of giving you no clue what it is about, it had the advantage of having more brevity and vivacity than "delete-1 resampling", which is probably the more accurate name.
[^2]: I trotted out this test because these two confusions are actually great learning opportunities.
[^3]: Barnard conceived of the $(a, b)$ as points "in a plane lattice diagram of points with integer co-ordinates", that is, that $a$ is like the $x$-axis and $b$ is like the $y$-axis. Then the possible outcomes of the experiment are the points in the rectangle bounded by the horizontal lines $a = 0$ and $a = m$ and the vertical lines $b = 0$ and $b = n$. He then said that you should pick the non-extremal points (i.e., the values of $(a, b)$ for which you would not reject the null) such that they "consist of as many points as possible, and should like away from that diagonal of the rectangle which passes through the origin. Formulated mathematically, these latter requirements mean that the \[points for which you would reject the null\] must in a certain sense be convex, symmetrical and minimal."
[^4]: It is, however, the way the famous "lady tea tasting" experiment was designed. The myth is that Fisher didn't believe it when a high-class lady told him that she could detect whether tea was added to a cup with milk in it or whether the milk was added to the tea. He designed an experiment with $m$ cups prepared one way, $n$ prepared the other, and told her to detect the $r = m$ cups that were prepared the first way. A Barnard-style experiment, in which the same $m$ and $n$ cups
[^5]: The normal approximation to the binomial was proved long before the central limit theorem. This special case, called the _de Moive-Laplace theorem_, was first published by de Moivre in 1738. Laplace published the reverse result, that the binomial approximates the normal, 75 years later, in 1812. The general central limit theorem was proven, more than 150 years after de Moivre's original result only, in 1901 by Lyapunov. [Put CLT in with regression? Or z-test?]{.mark}
