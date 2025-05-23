Current status: Need to migrate to mkdocs and clean up extraneous material

---
date: Jan 2021
---

- I started working through functions chapter
- The preface is pretty good
- Introduction should probably just be some historical notes like it is

---

**Material below is from Nov 2019?**

Fill in the "SWOs"

# Empirical P-values

- You observe a specific statistic, and then you sample another *n*.
- Under the null hypothesis, the observed value and the other *n* came from the same distribution.
- The *p*-value is the probability of getting a value as small as the observed one, given that the null is true.
- If you know the "shape" of the distribution, you can compute this exactly (e.g., as we did in our sign test).
- If you *don't* know the shape, then you need to do this empirically, with a parametric test.
- You say, I have *n+1* items in a list. What's the chance that this particular item falls at rank *m* or below (or above)? That's $(r+1)/(n+1)$.
- It's a mistake to do $r/n$, but not a terrible mistake, except that it gives you $p=0$!
- Overestimates small $p$ (because you go up to 1/n+1) and underestimates large, but that's normally not a problem. The important thing is avoiding p=0 bias.
- Also, this provides an *estimate* of the $p$-value, since you're basically doing a binomial test: of $n+1$ total coin flips, $r+1$ come out heads. What's the probability of heads? This has a confidence interval around it.

# Material to fix

- Universality of statistics
  - Aside from the scientific method in general, and numbers, there is no other thing as widespread in the sciences
  - Scientific questions eventually boil down to numbers, and so down to statistics. Your beautiful fascinating theory about frog evolution and flight paths or whatever eventually comes down to whether this heap of numbers is bigger than that heap, or whether this function is a better fit to this data than that function.
- combination of observations: crowdsourcing, poll the audience (who wants $1 million)
- Cohen's kappa as example for permutation?


# New material

- cross validation vs. the jackknife. CV is just a kind of resampling, like bootstrap and jackknife.
- efficiency and cramer rao for talking about the variance of estimators
    - probably bring this up but don't go too much into it, except to say that it's definitely going to be important for doing inferences.
- Joint probability distributions, and how for iid, you get products
- Note about [biostats handbook](http://www.biostathandbook.com/). I don't want to be as "cookbook"y.
- Multinomial vs. downsampling
- Robustness using Efron's example: if you flip a coin 100 times, and get $p=0.3$, then throwing away any one particular data point will have a small effect. But Mariner space probe bacteria swabs are a different story, with two huge outliers.
- Censored data should be easy to understand if you do the MLE approach for talking about regression. Rather than allowing each point to be in particular places, you allow for it to be in *many* possible places.
- Expectation maximization for fitting, e.g., mixed models, data clustering, etc.
- Cook's distance $D_i = \sum_{j=1}^n (\hat{y}_j  - \hat{y}_{j(i)})^2 / ps^2$, where $p$ is the number of parameters, $y_{j(i)}$ is the predicted value for $y_j$ when you remove point $i$. $n$ must be the number of data points *minus one*. $s^2$ is the mean squared error of the regression model. Some people say $D_i > 1$ means a point is an outlier. Note the similarity to the jackknife, which will also do estimates with a leave-one-out kind of procedure.
- also need some more discussion earlier to say that thinking about $\Omega$ is really confusing. What sample space would give rise to a normally-distributed variable, for example? And where do we draw the liens around the universe we're interested in?
- So if there are more and more $X_i$ with iid $F_X$, then the idea is that the estimator of the $\hat{\theta}(\vec{x})$ should approach $\theta(F_X)$.
- There's a ``sample'' probability distribution $\hat{f}_X$. It's hard to say whether this is a maximum likelihood estimator or something. What does ``sample'' mean? Like "sample mean"?
- cdf is also the quantile function
- consistency of the arithmetic mean using Chebyshev's identity. That's called the weak law of large numbers. Bernoulli proved a special case long ago.
- multiple hypothesis correction should always start with examining the distribution of pvalues
- include a bayesian introduction before any inferential
- linear mixed models for GWAS is a good example of when biology becomes numbers
- mixing around counts for TnSeq is another good example
- bayesian
    - introduce priors with the beta binomial
    - credible intervals, which align with confidence intervals in very particular cases
- normal distribution as arising from the poisson, or whatever you want
- regression
    - historical note about what "regression means"
    - Simpson's paradox for need to have other variables
    - Berkson's paradox for problems with including this that aren't causal
- MCMC as example for complex SIR-like models. It's really clear how to turn the crank, but it's not easy to say how the inputs should relate to the outputs. Or my funny hierarchical thing.
    - how does ABC compare for this?
- descriptions of the different distributions
    - mixture distributions
    - Poisson as horse kicks, or cells in droplets
- random number generation
- probit analysis
    - logit makes sense if you're thinking about odds ratios (well, probably risk ratios, but there are some nice things about odds ratios)
    - probit analysis makes sense if you're thinking aobut the proportion that's going to hit some mark; which is just what you'd want for an LD-50 experiment

# Lady Tasting Tea

- Probability as counting techniques, which assumes that all events are equiprobable
- Mean, variance, skew, kurtosis: legacy of Pearson's biometrics, thinking that all distributions could be described this way.
    - Something about moments in general
- Tukey's stuff as true stuff for descriptive statistics
- Gosset's t-test because you couldn't expect to have hundreds or thousands of samples as Pearson assumed
- Gumbel, Tippet, Weibull for extreme events (maximum of distribution?)
- Neyman-Pearson hypothesis testing, which they never did, as decision-making, and as one of the most broadly-used tools in science
- Fisher's p-value examples: 10^-4 was too small, 0.3 was too large, 0.04 meant that you probalby needed to do some more experiments
- Venn in 1866 saying that probability should be interpreted as frequency, not as educated guesses
    - If that seems backwards, recall that we're trying to understand what probability is, and in this case we're following the math to the world, not the other way around!
- Significance vs. hypothesis testing
- Bowley's confidence trick: "I am not at all sure that the 'confidence' is not a 'confidence trick'." "Does it really lead us towards what we need--the chance that in the universe which we are sampling the proportion is within these certain limits?" (1934, on Neyman)
- "Personal" probability
- Bayes factor as alternative to pvalue (if you have two models)
- Glivenko-Cantelli theorem about why you can (asymptotically) use the empirical distribution function to approximate the real one

# Old text about variation

Up to this point, I've used the word ``distribution'' in the mathematical
probability sense: it's the cdf $F_X$ or the pmf/pdf $f_X$.
It it now crucial to distinguish between these mathematical
probability objects and, on the other hand, the mass of data
that we get from an experiment, which might also be called the ``distribution''
of the data. (As we'll see later, this confusion of language is not
totally unwarranted, because the mass of data is itself a complicated estimator
of the mathematical distribution.)

The distinction between mathematical distributions and data distributions is
usually made in the jargon of the social sciences: from some
\emph{population}, you draw a \emph{sample}. The sample refers to the numbers
you collected; the population refers to the larger universe of numbers your
sample was drawn from. We use the sample to estimate properties of the
population. For example, if you're interested in the height of men versus
women in the US, then your target populations will be, say, all American males
and all American females. The sample is whatever heights you actually measure.
We then try to make some inference about all Americans based on our sample.

In the heights example, the target population is finite. There are only 300
million Americans. It is therefore theoretically possible to make a list of
the heights of all Americans. In a repeatable experiment, on the other hand,
the target population is infinite: you could theoretically repeat an
experiment infinitely many times, drawing an infinite number of data points.
In most cases, statistics proceeds as if the target population were infinite,
although there are corrections you can make when your sample size starts to
approach the size of the target population.

Many statistical methods also assume that the target population follows some
known distribution. The classic example is that the $t$-test assumes that the
target populations are normally distributed. This can make the language a
little confusing. If you are using the $t$-test to compare the heights of
males and females, is the ``true'' population the actual distribution of
heights among the 300 million Americans, or is the ``true'' population the
normal distribution? In most cases, ``true'' is used to refer to the abstract
mathematical distribution rather than the actual distribution of the target
population.

The important point is that the ``sample'' distribution refers to the data you
collected, while the ``true'' or ``theoretical'' distribution refers to the
theoretical approximation of the target population your data came from.

---

In the ``hard'' experimental sciences, this language about ``population'' may
sound weird. If I'm trying to measure the speed of light, I repeat my
experiment many times and get many different values. Those values are the
sample, but what is the population? We think there is a single, true speed of
light, not a distribution of speeds of lights. In this case, the ``population''
refers, somewhat tautologically, to the distribution of the values that would
come from an infinite number of repetitions of our experiment. In other words,
the sample defines the population, not the other way around.

In the social sciences example, the shape of the distribution of measured
values says something about the variation of the values in the target
population. We get a range of measured values because people are different
heights. In the physics example, the shape of the distribution has everything lot to do
with the precision in our experiment. We get a range of measured values
because of all sorts of error that arise the in the process of experimentation.

In biology, the situation is somewhere in between. We think there is true
variation in, say, the physiology of the cells used in an experiment. We
might wish there weren't. It would be easier to do some experiments if all
cells started in exactly the same state and responded exactly the same way to
an experimental condition. The meaning of the range of values we get is then
something of a philosophical one. To what degree do we treat the range of
values as due to error, because we couldn't make all the cells the same, and
to what degree is it an honest report about the heterogeneity of behavior in
some ``target population'' of cells? Multilevel models, which will come up later,
are an attempt to deal with multiple sources of variation.
