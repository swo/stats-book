# Things to include

- Poisson as horse kicks
- Simulation in general
- Bayesian as the mystical: the only way to say the probability about the truth is to assert what you think is the truth
- Frequentist as a weird subset of the Bayesian
- Confidence intervals as confidence about how, if this is right, the future will unfold
- Variance (shape) as more important than mean (location). If you have variance, it's pretty easy to measure the mean and get a sense of things. If you have the other way, it's a lot more murky.
- Inference vs. decision-making under uncertainty. How are these two things different? (e.g., what's the "cost" of making an incorrect scientific conclusion?)


# Why a book?

In a mathematical introduction, a random variable is a function that maps
events to some measurable space. This mathematical approach is powerful but not
intuitive. I think the contructivist approach is better: if you can say how
this thing would arise, I think you are in a better place as a scientist and
modeler (but not necessarily as a mathematician).


# Summary statistics

The mean is also called the *expectation value*, which gives a contemporary
English speaker a strange idea of what it is. The expectation value is *not* "a
value that you might expect". That is the *mode*. In certain cases, the mean
and the mode are the same, but this is often not true. This is why it is so
critical to look at the distribution of your data *before* selecting summary
statistics.

# t test

To recapitulate the two sample, equal variance, one-way $t$-test:

$$
t = \frac{x_1 - x_2}{s_p \sqrt{\frac{1}{n_1} + \frac{1}{n_2}}},
$$
where the pooled variance is
$$
s_p = \sqrt{\frac{(n_1 - 1) s_1^2 + (n_2 - 1) s_2^2}{n_1 + n_2 - 2}}.
$$

- Compute the observed $t$ statistic
- Compute the observed sizes, means, and standard deviations for the two sample populations
- Many times, generate two sets of random variates. One set of variates is drawn from a normal distribution with the first sample mean and variance.
- For each iteration, compute the simulated $t$ statistic.
- The empirical $p$-value is the fraction of simulated statistics that are greater than the observed statistic.

## wtf

Why doesn't just subtracting the means work? Is that test just less sensitive or something?

# anova

Say you have some (equally-sized) groups. Each group was drawn from a normal
distribution (all with the same variance). Are the data consistent with the
model in which all those groups have the same mean?

The statistic is $F \equiv \frac{\mathrm{MS}_B}{\mathrm{MS}_W}$, where $MS_B$
is the mean of the squares of the residuals(?) between the group means and the
grand mean ("between") and $MS_W$ is the mean of the squares of the residuals
between the data points and the group means ("within").

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
