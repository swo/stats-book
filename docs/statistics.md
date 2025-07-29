# Statistics

## A statistic is a function of data

In common speech, we use the terms like expected value, variance, covariance, and correlation in reference to data, that is, to sets of fixed numbers, rather than to mathematical objects like random variables. In this chapter, we will bridge the gap between the probability theory we have considered so far and the practice of statistics.

The term "statistics" has two meanings. As a singular noun, a _statistic_, is a function that maps data, that is, an ordered list of numbers, to a real number. We use $t$ as a stand-in to mean "any old statistic":

$$
t : \mathbb{R}^n \to \mathbb{R}
$$

To study the properties of a statistic, we will define a random variable that is analogous to that statistic. A random variable that is analogous to a statistic is called an _estimator_, often written $T$.

For example, the arithmetic mean maps a list of numbers $x_i$ to a single number, and so is a statistic, which I will write as $t$, such that $t \equiv (1/n) \sum_i x_i$. There is an analogous estimator $T \equiv t(X) = (1/n) \sum_i X_i$. As I emphasized in the previous chapter, although the notation in these two equations is almost identical, just replacing some lowercase letters with uppercase ones, it is critical to remember that adding random variables is not the same thing as adding numbers. The function $t$ maps numbers to a number, so $t(X)$ is, strictly speaking, nonsense. But in the same way that we use the plus sign when adding numbers, like in $x + y$, and for "adding" random variables, like in $X + Y$, we use $t$ to refer to an operation on numbers as well as to the analogous operation on random variables.

The word "statistics" ending in _s_ could either be the plural of statistic, that is, many functions of the data, or it can refer to the field of study of estimators. Thus it is syntactically and semantically correct to say "statistics _is_ fun".

Up to this point, we have discussed random variables in a deductive way: given the distribution of the random variable, you ask what its expected value or variance is. [Estimators](estimators.md) are the starting point of statistics (the field of study), which goes the opposite way: given some data points, what can we say about the distribution of the random variables that gave rise to that data?
