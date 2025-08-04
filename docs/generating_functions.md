# Generating functions

[PGFs, CFs, MGFs]

## Application: Size bias

We often talk about sampling from a distribution, thinking about i.i.d. variables $X$ and their distribution. Sometimes, we don't directly sample from the distribution, but from a _size-biased_ version of that distribution, in which the probability of drawing a value is proportional to the value itself.

If a random variable $X \geq 0$ is distributed with pdf $f_X$, then the pdf of the associated size-biased random variable $X^\mathrm{s}$ is:

```math
f_{X^\mathrm{s}}(x) = \frac{x \, f_X(x)}{\mathbb{E}[X]}
```

The value of $\mathbb{E}[X]$ in the denominator is the normalization constant.

As an abstract example, imagine there are many urns, each with an associated random variable $X \geq 0$. Each urn has a number of balls that depends on $X$, such that the expected number of balls in the urn is $\mathbb{E}[X]$. Each ball has the same value as its urn. Then the distribution of values associated with a randomly selected ball is $X^\mathrm{s}$. The urns with larger values $X$ will have more balls, and so we are more likely to draw a ball from one of those urns, so the values $X^\mathrm{s}$ will be biased toward higher values.

More concretely, imagine that, in the context of an infectious disease, infected people are infectious for some period of time $X \sim \mathrm{Exp}(\lambda)$, during which time they have a constant infectiousness, so that the number of people they infect is proportional to $X$, and the times of those secondary infections are uniformly distributed throughout the period $X$. What is the average delay between the infector's being infected and an infectee's being infected?

First, we consider the size-biased variable $X^\mathrm{s}$, which represents selecting an _infectee_ at random and asking about their infector's infectious period. The expected value of this random variable is:

```math
\begin{align*}
\mathbb{E}[X^\mathrm{s}] &= \int_0^\infty x f_{X^\mathrm{s}}(x) \,dx \\
&= \int_0^\infty x \frac{x f_X(x)}{\mathbb{E}[X]} \,dx \\
&= \int_0^\infty x \frac{x \lambda e^{-\lambda x}}{1/\lambda} \,dx \\
&= \int_0^\infty (\lambda x)^2 e^{-\lambda x} \,dx
\end{align*}
```

Make a chance of variables $y=\lambda x$ so that:

```math
\mathbb{E}[X^\mathrm{s}] = \frac{1}{\lambda} \int_0^\infty y^2 e^{-y} \,dy = \frac{2}{\lambda} = 2 \mathbb{E}[X]
```

Because each infectee lands, on average, in the middle of the infector's infectious period, then the average time to infection is $\mathbb{E}[X]$, that is, equal to the average duration of infectiousness.

### Size bias with CFs

The math worked out here for the exponential distribution, but in general integrals are hard and this sort of math won't work out for other distributions.

Rather than working with pdf's, we can instead work with their transforms. Just as logarithms make difficult multiplication into easy addition, so these transformations can make things difficult things like adding random variables into simpler multiplication.

Define the _characteristic function_ of a random variable $X$ as:

```math
\phi_X(u) = \mathbb{E}[e^{iuX}]
```

The expected value of a random variable is:

```math
\mathbb{E}[X] = i^{-1} \phi_X'(0)
```

Note also that:

$$
\phi_{X^\mathrm{s}}(u) = \frac{1}{i \mathbb{E}[X]} \phi_X'(u)
$$

Given the characteristic function for an exponential is $\phi(u) = (1 - i \lambda^{-1} u)^{-1}$, it is relatively straigthforward to compute the mean of the size biased exponential:

$$
\begin{align*}
\mathbb{E}[X^\mathrm{s}] &= i^{-1} \phi_{X^\mathrm{s}}'(0) \\
&= i^{-1} \frac{1}{i \lambda^{-1}} \frac{d}{du} \left[ i \lambda^{-1} (1-i\lambda^{-1} u)^{-2} \right]\Big|_{u=0} \\
&= 2 (1-i\lambda^{-1}u)^{-3} \big|_{u=0} \\
&= 2
\end{align*}
$$

This same procedure could be followed for other distributions, which would be impossible to integrate.
