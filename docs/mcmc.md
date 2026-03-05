# Markov chain Monte Carlo algorithms

## Particle marginal Metropolis-Hastings sampler

See [Andrieu et al. (2010)](https://dx.doi.org/10.1111/j.1467-9868.2009.00736.x), especially sections 2.2.1 and 2.4.2.

### Overview

The observed data are a time series $\mathbf{y} = (y_1, \ldots, y_T)$ generated from a known likelihood function $p(\mathbf{y} | \mathbf{x}, \theta)$ that depends on an unknown set of global parameters $\theta$ and an unobserved, time-varying state space $\mathbf{x} = (x_1, \ldots x_T)$.

Particle Markov chain Monte Carlo methods use the Metropolis-Hastings (MH) algorithm to draw samples from the posterior distribution on the parameters. In each MH step, a sequential Monte Carlo (SMC) is used to draw samples, called "particles," from the state space, conditional on the data and the proposal parameters. These particles allow an approximation of the likelihood $p(\mathbf{y} \mid \theta)$ that determines the MH proposal acceptance probability.

The particles' values are indexed $x_{tki}$ for time step $t$, inference iteration $i$, and particle $k$.

### MH algorithm

Known things:

- Prior distribution on parameters: $p(\theta)$
- Proposal distribution on parameters: $q(\theta_i \mid \theta_{i-1})$

Initialize (where "initial" refers to the first inference iteration):

1. Draw $\theta_1$ from the prior distribution.
1. Generate $N$ particles $x_{tk1}$ using $\theta_1$, according to the SMC algorithm; see below.

Then, for each iteration $i \geq 2$:

1. Generate proposal parameters $\theta^\star$ using the proposal distribution and previous parameter sample $\theta_{i-1}$.
1. Generate proposal particles $x^\star_{tk}$ using $\theta^\star$, and the approximate marginal likelihood $\hat{p}(\mathbf{y} \mid \theta^\star)$ using those particles, according to the SMC algorithm.
1. Compute the estimated ratio $r$ of the posterior probability of the proposal parameters relative to the previous parameters sample; see below.
1. With probability $\min(1, r)$, use the proposal parameters and states as the next samples, setting $x_{tki} \leftarrow x^\star_{tk}$ and $\theta_i \leftarrow \theta^\star$. Otherwise, discard the proposals.

$$
r \equiv
\frac{\hat{p}(\mathbf{y} \mid \theta^\star)}{\hat{p}(\mathbf{y} \mid \theta_{i-1})}
\frac{p(\theta^\star)}{p(\theta_{i-1})}
\frac{q(\theta_{i-1} | \theta^\star)}{q(\theta^\star | \theta_{i-1})}
$$

### SMC algorithm

See Andrieu et al. section 2.2.1. Briefly, we wish to approximate the marginal likelihood $p(\mathbf{y} \mid \theta)$ by summing over a finite sample, rather than integrating over all state space $\mathbf{x}$.

The following are known distributions from which we can directly sample:

- Proposal distribution for states: $q(x_t \mid y_t, x_{t-1})$, with a special case $q(x_1 \mid y_1)$ for the first time step
- Prior distribution for states: $p(x_t)$, although in practice we may have a prior only on the initial state $x_1$
- Transition distribution: $p(x_t \mid x_{t-1})$
- Observation distribution: $p(\mathbf{y} \mid \mathbf{x})$

All of these distributions depend on the parameters $\theta$, which are fixed for purposes of this algorithm.

Initialize (where "initial" now refers to the first time step):

1. Draw state $x_{1k}$ from the initial proposal distribution, for each particle $k$.
1. Compute unnormalized weights $\tilde{w}_{1k}$ for each particle, using the observation probability, prior on states, and proposal distribution; see below.
1. Compute normalized weights $w_{1k}$; see below.

$$
\tilde{w}_{1k} = \frac{p(y_1 \mid x_{1k}) p(x_{1k})}{q(x_{1k} \mid y_1)}
$$

$$
w_{1k} = \frac{\tilde{w}_{1k}}{\sum_k \tilde{w}_{1k}}
$$

For each time step $t = 2, \ldots, T$:

1. For each particle $k$, draw the index $j \sim \mathrm{Multinomial}(\mathbf{w}_{t-1})$ of this particle's "parent." Create the new particle $x^\star_{sk} \leftarrow x_{sj}$ for $s=1,\ldots,t-1$.
1. Replace the old particles with the new ones: $x_{sk} \leftarrow x^\star_{sk}$ for $s=1,\ldots,t-1$.
1. Draw the new state $x_{tk}$ using the proposal distribution $q(\bullet \mid y_t, x_{t-1,k})$.
1. Compute unnormalized weights $\tilde{w}_{tk}$ using the transition distribution, observation distribution, and proposal distribution; see below.
1. Compute normalized weights $w_{tk}$.

$$
\tilde{w}_{tk} = \frac{
    p(x_{tk} \mid x_{t-1,k})
    p(y_t \mid x_{tk})
}{
    q(x_{tk} \mid y_t, x_{t-1,k})
}
$$

Finally, compute the approximate marginal likelihood $\hat{p}(\mathbf{y})$ using the unnormalized weights:

$$
\hat{p}(\mathbf{y}) = \prod_{t=1}^T \left( \frac{1}{N} \sum_{k=1}^N \tilde{w}_{tk} \right)
$$

Note that the dependence on the parameters is implicit; this value is written more explicitly as $\hat{p}(\mathbf{y} \mid \theta)$. Note also that this is an approximation of:

$$
p(\mathbf{y}) = p(y_1) \prod_{t=2}^T p(y_t \mid y_1, \ldots, y_{t-1})
$$

where, for example,

$$
p(y_1) = \int p(y_1 | x_1) p(x_1) \,\mathrm{d}x_1
$$

Posterior samples can be drawn from the state space by drawing indices from $\mathrm{Multinomial}(\mathbf{w}_T)$ and using the corresponding particles.
