# Markov chain Monte Carlo algorithms

## Particle marginal Metropolis-Hastings sampler

### To do

- Under what conditions do these iterates converge to posterior samples?
- Provide nice reference to section 2.4.2 in [Andrieu et al. (2010)](https://dx.doi.org/10.1111/j.1467-9868.2009.00736.x)

### Overview

The observed data are a time series $\mathbf{y} = (y_1, \ldots, y_T)$ generated from a known likelihood function $p(\mathbf{y} | \mathbf{x}, \theta)$ that depends on an unknown set of global parameters $\theta$ and an unobserved, time-varying state space $\mathbf{x} = (x_1, \ldots x_T)$.

Particle Markov chain Monte Carlo methods use the Metropolis-Hastings (MH) algorithm to draw samples from the posterior distribution on the parameters. In each MH step, a sequential Monte Carlo (SMC) is used to draw samples, called "particles," from the state space," conditional on the data and the proposal parameters. These particles allow an approximation of the likelihood $p(\mathbf{y} \mid \theta)$ that determines the MH proposal acceptance probability.

### MH algorithm

Known things:

- Prior distribution on parameters: $p(\theta)$
- Proposal distribution on parameters: $p(\theta_i \mid \theta_{i-1})$

Initialize (where "initial" refers to the first inference iteration):

1. Draw $\theta_1$ from the prior distribution.
1. Generate $N$ particles $x_{tk1}$ using $\theta_1$, according to the SMC algorithm.

Then, for each iteration $i \geq 2$:

1. Generate proposal parameters $\theta^\star$ using the parameter proposal distribution and previous parameter sample $\theta_{i-1}$.
1. Generate proposal particles $x^\star_{tk}$ using $\theta^\star$, and the marginal likelihood $\hat{p}(\mathbf{y} \mid \theta^\star)$ using those particles, according to the SMC algorithm.
1. Compute estimated posterior probability ratio $r$; see below.
1. With probability $r$, use the proposal parameters and states as the next samples, setting $x_{tki} \leftarrow x^\star_{tk}$ and $\theta_i \leftarrow \theta^\star$. Otherwise, discard the proposals.

$$
r \equiv \min\left\{ 1,
\frac{\hat{p}(\mathbf{y} \mid \theta^\star)}{\hat{p}(\mathbf{y} \mid \theta_{i-1})}
\frac{p(\theta^\star)}{p(\theta_{i-1})}
\frac{p(\theta_{i-1} | \theta^\star)}{p(\theta^\star | \theta_{i-1})}
\right\}
$$

### SMC algorithm

The following are known distributions from which we can directly sample:

- Proposal distribution for states: $p(x_t \mid y_t, x_{t-1})$, with a special case $p(x_1 \mid y_1)$ for the first time step. We can directly draw samples from this distribution.
- Prior distribution for states: $p(x_t)$
- Transition distribution: $p(x_t \mid x_{t-1})$
- Observation distribution: $p(\mathbf{y} \mid \mathbf{x})$

All of these depend on parameters $\theta$, which are fixed for purposes of this algorithm.

Initialize (where "initial" now refers to the first time step):

1. Draw states $x_{1k}$ from the initial proposal distribution for each particle $k$.
1. Compute unnormalized weights $\tilde{w}_{1k}$ for each particle, using the observation probability, prior on states, and proposal distribution; see below.
1. Generate normalized weights $w_{1k}$; see below.

$$
\tilde{w}_{1k} = \frac{p(y_1 \mid x_{1k}) p(x_{1k})}{p(x_{1k} \mid y_1)}
$$

$$
w_{1k} = \frac{\tilde{w}_{1k}}{\sum_k \tilde{w}_{1k}}
$$

For each time step $t = 2, \ldots, T$ and particle $k$:

1. Draw the index of its parent: $a_{tk} \sim \mathrm{Multinomial}(\mathbf{w}_{t-1})$. Write $\xi_{tk} \equiv x_{t-1,a_{tk}}$ as the state of parent of the $k$-th particle in the previous time step.
1. Draw the state at this time step $x_{tk}$ using the proposal distribution $p(\cdot \mid y_t, \xi_{tk})$.
1. Generate unnormalized weights $\tilde{w}_{tk}$ using the transition distribution, observation distribution, and proposal distribution; see below.
1. Normalize weights.

$$
\tilde{w}_{tk} = \frac{
    p(x_{tk} \mid \xi_{tk})
    p(y_t \mid x_{tk})
}{
    p(x_{tk} \mid y_t, \xi_{tk})
}
$$

Each particle $\mathbf{x}_k = (x_{1k}, \ldots x_{Tk})$ and weight $w_{Tk}$, we approximate the marginal likelihood

$$
p(\mathbf{y} \mid \theta) = \int_\mathbf{x} p(\mathbf{y} \mid \mathbf{x}, \theta) p(\mathbf{x}) \,\mathrm{d}\mathbf{x}
$$

with a weighted sum over the particles:

$$
\hat{p}(\mathbf{y} \mid \theta) = \frac{1}{N} \sum_{k=1}^N p(\mathbf{y} \mid \mathbf{x}_k, \theta) \cdot w_{Tk}
$$
