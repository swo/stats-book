# Confidence intervals

## Definition

So far we have worked with _point estimates_, that is, guesses for population parameters that are just a single number. This presents a problem, because statistics and probability are all about uncertainty, and we know that the point estimate we make for, say, $B$ in the German tank problem will likely never be exactly correct, even if the estimator is consistent, unbiased, and efficient.

In the frequentist framework, the approach for expressing uncertainty is using _confidence intervals_. A confidence interval for a parameter $\theta$ with estimator $\hat{\theta}$ at _level_ $1-\alpha$ is a pair of estimators $\hat{\theta}_-$ and $\hat{\theta}_+$ defined such that, for any parameter value $\theta$, it holds that: $$\mathbb{P}[\hat{\theta]_- \leq \theta \leq \hat{\theta}_+} \geq 1 - \alpha.$$ A typical value for $\alpha$ is 5%, or $0.05$, which yields 95% confidence intervals. A higher $\alpha$ corresponds to a lower probability of error, and thus wider confidence intervals, for which we are more sure that the interval actually contains the true value. Thus a 99% confidence interval is wide and a 90% confidence interval is narrow.

This equation is typically read as saying "the probability that the value of the unknown parameter $\theta$ is between $\hat{\theta}_-$ and $\hat{\theta}_+$ is 95%". The typical conceptualization is then to imagine that $\theta$ is varying, bopping around inside the confidence interval set by $\hat{\theta}_-$ and $\hat{\theta}_+$. In fact, however, it is the intervals that are the random variables, and the parameter is the constant fixed point around which those random variables are bopping.

Note that, in the frequentist approach, we develop two statistics ---functions of the observed data--- such that their corresponding estimators will, with some probability, enclose the true value, for every possible true value. Strictly speaking, you must select a method for constructing confidence intervals such that, for any parameter $\theta$ I choose, the proportion of infinitely many repeated trials will produce realizations of the confidence interval that enclose $\theta$.

## Meaning and interpretation

If this introduction has been a bit befuddling, then you are in good company. Confidence intervals are a very new concept. They were first introduced in the statistical literature in 1937 and become commonplace in scientific work only in the later 20th century. It is perhaps no surprise, given its youth, that the concept of the confidence interval is very confusing.

The most common misconception about confidence intervals is that they represent _confidence_. (One might argue that "confidence" was a poor word to use to name this thing!) In this misconception, we can have 95% confidence that the true parameter $\theta$ lies inside the confidence interval constructed after the experimental data has been gathered. Strictly speaking, this is incorrect. In a frequentist framework, the true value is either inside the realized confidence interval, or it is not; our ignorance of the true value has nothing to do with probability. In fact, the interval that encloses the true value with some "confidence" is a Bayesian concept, the _credible interval_. "Confidence" is part of the Bayesian definition of probability; it is foreign to the frequentist construction.

To a practicing scientist, this distinction might appear entirely semantic. But if anyone tells you there is a 95% probability that the true value of a parameter falls within some fairly specific range, you should be very skeptical. Would you, for example, bet twenty-to-one odds that they were correct? I would not, not because they had miscomputed their statistics, but because their experimental approach is very likely imperfect.

## Constructing intervals

Regardless of what confidence intervals really mean, they are useful for producing some quantification of uncertainty.

To show how confidence intervals are constructed, consider the German tank problem again. Our unbiased point estimate is $\hat{B} = \tfrac{n+1}{n} \max_i X_i$. We will design a _symmetric_ confidence interval, which means that: $$\mathbb{P}[\hat{B]_- \leq B} = \mathbb{P}[\hat{B]_+ \geq B} = 1 - \frac{\alpha}{2}$$ This confidence interval is symmetric because the probability that the confidence interval will not include $B$ because it is too low is equal to the probability that it will not include $B$ because it is too high. For a 95% confidence interval, the probability of the confidence interval being wrong on either side is $2.5\%$, for a 5% total probability of error.

To construct $\hat{B}_-$ and $\hat{B}_+$, we will find the range of values in which the point estimator $\hat{B}$ is to expected fall, given $B$. We found that the cdf for the biased estimator $\max_i X_i$ was $(x/B)^n$, so the cdf for the unbiased point estimator is: $$\mathbb{P}[\hat{B] \leq x} = \frac{n+1}{n} \left(\frac{x}{B}\right)^n$$ First, we use this cdf to find the value of $x$ such that $\hat{B}$ will fall below it with probability $1-\frac{\alpha}{2}$: $$\mathbb{P}[\hat{B] \leq x} = 1 - \frac{\alpha}{2} \implies x = \left( \frac{\alpha}{2} \frac{n}{n+1}\right)^{1/n} B$$ Next, we "invert" this relationship: $$1 - \frac{\alpha}{2}
    = \mathbb{P}[\hat{B] \leq \left( \frac{\alpha}{2} \frac{n}{n+1}\right)^{1/n} B}
    = \mathbb{P}[\left( \frac{\alpha]{2} \frac{n}{n+1}\right)^{-1/n} \hat{B} \leq B}$$ And thus, we have found our lower confidence interval: $$\hat{B}_- = \left( \frac{\alpha}{2} \frac{n}{n+1}\right)^{-1/n} \hat{B}$$ A similar exercise shows that: $$\hat{B}_+ = \left[ \left(1- \frac{\alpha}{2}\right) \frac{n}{n+1}\right]^{-1/n} \hat{B}$$

As an example, for $n=5$, $\max x_i = 1$, and $\alpha = 5\%$, we have $\hat{B} = 1.2$, $\hat{B}_- = 1.04$ and $\hat{B}_+ = 2.17$. For $n=100$ and the same observed maximum $1$, we have $\hat{B} = 1.01$, $\hat{B}_- = 1.0004$, and $\hat{B}_+ = 1.04$. In both these cases, we do not say what $B$ actually is, so we cannot say whether or not the confidence intervals contain the true value or not. We only know that, regardless of what $B$ is, there is a 95% probability that the resulting data will produce, according to our definitions, values of $\hat{B}_-$ and $\hat{B}_+$ that contain $B$.

## Properties of confidence intervals

We could have been much lazier with our confidence intervals. For example, I could have defined $\hat{B}_- = 0$. Because we know _a priori_ that $B>0$, this lower end of the confidence interval will always be correct. In fact, it means that the confidence intervals will be contain $B$ with a probability greater than $1-\alpha$. This is an undesirable feature. Confidence intervals with the desirable property that they have a error probability of exactly $\alpha$ and no more are termed _valid_ confidence intervals.

You might imagine that we could have constructed different confidence intervals. For example, if we relaxed the symmetry requirement, then we might be able to produce confidence intervals that are overall narrower. For certain situations, there is a well-acknowledged single best method for constructing a confidence interval. In other situations, there are multiple very reasonable ways to construct confidence intervals. For example, for the binomial distribution, there are pros and cons to the Wilson method and the Clopper-Pearson methods for computing confidence intervals.

## Resampling methods

In the previous example, we used our knowledge about the distribution of the data to develop confidence intervals on the estimator $\hat{B}$. What would we do if we had an estimator ---that is, we knew what property of the data we wanted to measure--- but we did not know how the data were distributed? In these situations, we turn to resampling methods like the _bootstrap_ or the _jackknife_.

### Bootstrap

In the bootstrap approach, we do no assert that we know the statistical distribution that the data were drawn from. Instead, we assume that the data we collected is the best approximation we have for the true, underlying distribution of the data. In statistics jargon, this means we use the sampling distribution as if it were the population distribution. In other words, we sampled some number $n$ of data points $x_i$ from the true distribution $F_X$ of some i.i.d. random variables $X$, and from those observed data points we construct a new set of i.d.d. random variables $\hat{X}$, which are discrete random variables with probability mass function: $$f_{\hat{X}}(x') = \frac{\#\{x' \in x_i\}}{n},$$ The probability of drawing the value $x'$ is equal to the proportion of the data points $x_i$ equal to that value. If none of the $x_i$ are the same (i.e., every value is unique), then: $$f_{\hat{X}}(x') = \begin{cases}
        \tfrac{1}{n} &\text{ if } x' \in x_i \\
        0 &\text{ otherwise}
    \end{cases}$$

Strictly speaking, there are a finite number of possible draws from this population, and so the probabilities $f_{\hat{X}}(x')$ can be computed exactly. For example, say you ran an experiment and drew three values $x_1, x_2, x_3$. Then $f_{\hat{X}}(x')$ is $\tfrac{1}{3}$ for $x' \in \{x_1,x_2,x_3\}$ and zero otherwise. There are only 10 possible data sets that can be drawn: $\{x_1,x_1,x_1\}$ with probability $\tfrac{1}{27}$, $\{x_1,x_1,x_3\}$ with probability $\tfrac{1}{9}$, and so on, finishing with $\{x_3,x_3,x_3\}$ with probability $\tfrac{1}{27}$.

Another way to say this is that bootstrapping represents _resampling with replacement_. From the $n$ data points in our sample, we take a "resample" of $n$ data points, allowing replacement. One of the possible resamples is the original sample. In the example above, this is the resample $\{x_1,x_2,x_3\}$. In all the other cases, we draw at least one data point multiple times. For example, in the resample $\{x_1,x_1,x_2\}$, we drew $x_1$ twice.

Some combinatorics shows that there are $\binom{2n-1}{n}$ possible resamples. For $n=3$, this yields 10 possible resamples. For $n=10$, this yields $92,378$ possible resamples. For $n=25$, this yields more than $10^{13}$ possible resamples. Thus, for all but the smallest data sets, it is not feasible to consider all possible resamples. A scientific study might perform $1,000$ or 1 million bootstraps, randomly resampling the original data $1,000$ or 1 million times, and then stop. Very few studies exhaustively considering all the possible combinations. This means there is some stochasticity in practical applications of the bootstrap. In practice, the number of bootstraps is chosen to be quite large in order to minimize any of these stochastic effects.

Bootstraps can be used to construct confidence intervals on some estimator. There are a few different mathematical approaches, the simplest of which is called the _percentile method_. Given a statistic $t$ and data points $x_i$, draw many bootstraps $x^{(j)}$, and compute $t(x^{(j)})$ for each bootstrap. The lower confidence interval $\hat{T}_-$ is the $\tfrac{\alpha}{2}$ quantile of the bootstrapped statistics $t(x^{(j)})$, and the upper confidence interval $\hat{T}_+$ is the $1-\tfrac{\alpha}{2}$ quantile. In other words, the confidence intervals for the estimator are equal to the quantiles of the statistic computed on many bootstraps of the data.

### Jackknife

In the bootstrap, we draw $n$ data points with replacement, yielding possible $\binom{2n-1}{n}$ resamples, and we select a subset at random to analyze. The _jackknife_, by contrast, involves taking just $n$ resamples, each of size $n-1$. In each resample, all the original data points are used, except one, which is left out. The jackknife is therefore sometimes called "delete-1" resampling. The advantage of the jackknife is that evaluating $n$ resamples is computationally feasible, so it ceases to be a Monte Carlo method.

One might be tempted to proceed with the jackknife in the same way we did the bootstrap: for a statistic $t$, enumerate the $n$ resamples $x^{(j)}$, compute the jackknifed statistics $t(x^{(j)})$, and then look at the distribution of those jackknife statistics to compute the confidence interval. This approach would be mistaken because the resamples are all quite similar to one another, having $n-2$ of $n-1$ data points in common. Thus, the distribution of the jackknifed statistics $t(x^{(j)})$ is much narrower than the distribution of the bootstrapped statistics would be.

The process of correctly accounting for the narrowness of these values is:

1.  Compute the jackknifed _replicates_ $t^{(j)} \equiv t(x^{(j)})$

2.  Compute the jackknifed _statistic_, which is the mean of the replicates: $t_\mathrm{jack} = \tfrac{1}{n} \sum_j t^{(j)}$

3.  Compute the jackknife estimate of the variance of $T$ as $\frac{n-1}{n} \sum_j \left( t^{(j)} - t_\mathrm{jack} \right)^2$

4.  Get the confidence intervals from the Student's $t$-distribution with $n-1$ degrees of freedom and multiply them by the jackknife estimate of the variance

Those familiar with Taylor series may appreciate that the jackknife is the first-order approximation for the bootstrap in the space of the observed data $x_i$[^1]. Starting from the observed data, the jackknife moves a little bit in every "direction" by deleting a single data point and seeing what effect that has on the computed statistic. The bootstrap, on the other hand, moves about in every direction at once, wildly exploring the large but ultimately finite space of possible resamples.

The jackknife has some notable flaws. For example, the jackknife performs badly when estimating used to estimate confidence intervals for the sample median. In these cases, one needs to resort to the bootstrap or to other resampling methods, such as delete-$d$ resampling, which yields $\binom{n}{d}$ possible resamples.

## Profile method

Digest this: `https://personal.psu.edu/abs12/stat504/Lecture/lec3_4up.pdf`

[^1]: http://www.jstor.org/stable/2030104
