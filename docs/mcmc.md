# Markov chain Monte Carlo algorithms

## Particle marginal Metropolis-Hastings sampler

Section 2.4.2 in Andrieu et al

### Motivation

The observed data are a time series $\mathbf{y} = (y_1, \ldots, y_T)$ generated from a known likelihood function $p(\mathbf{y} | \mathbf{x}, \theta)$ that depends on an unknown set of parameters $\theta$ and an unobserved state space $\mathbf{x} = (x_1, \ldots x_T)$.

In each iteration $i$ of this algorithm, we use the previous posterior sample $\theta^{(i)}$ to generate

**Problem**: I need $x$ to be indexed by iteration, particle, and time.

### Notation

- subscripts indicate the time steps in the data
- superscripts indicate inference iterations
- perturbation distribution: $q\left(\theta^{(i)} | \theta^{(i-1)}\right)$, which I'm assuming is symmetric

### Algorithm

Initialize:

1. Draw $\theta^{(0)}$ from prior distribution. (Andrieu et al. say to set it "arbitrarily.")
1. Generate particles $X^{(0)}_j$ using $\theta^{(0)}$

Then, for each iteration $i \geq 1$:

1. Perturb parameters to generate proposal parameters $\theta^\star$
1. Generate proposal particles $X^\star_j$ using $\theta^\star$
1. Estimate marginal likelihood $\hat{p}(\mathbf{y} \mid \theta^\star)$ by summing over the particles
1. Compute estimated posterior probability ratio; see below
1. With that probability, set $X^{(i)} \leftarrow X^\star$ and $\theta^{(i)} \leftarrow \theta^\star$

$$
\min\left\{ 1, \frac{
    \hat{p}(\mathbf{y} \mid \theta^\star) p(\theta^\star)
}{
    \hat{p}(\mathbf{y} \mid \theta^{(i)}) p(\theta^{(i)})
}
\right\}
$$

### Generating particles

All of this assumes some parameterization $\theta$.

- importance density: $q(x_t \mid y_t, x_{t-1})$, with a special case $q(x_1 | y_1)$ for the initial state
- prior on state: $p(\mathbf{x})$
- observation probability: $p(\mathbf{y} | \mathbf{x})$
- transition prbability: $p(x_t | x_{t-1})$
- index $j$ over particles: $j = 1, \ldots, N$

Initialize:

1. Generate initial particles from the initial importance density: $x_1^{(j)} \sim q(\cdot | y_1)$
1. Generate unnormalized weights: $\tilde{w}_1^{(j)}$, see below
1. Generate normalized weights $w_1^{(j)}$, see below

$$
\tilde{w}^{(j)}_1 = \frac{
    p{\left(y_1 \middle| x_1^{(j)} \right)} p{\left(x_1^{(j)}\right)}
}{
    q{\left(x_1^{(j)} \middle| y_1\right)}
}
$$

$$
w_1^{(j)} = \frac{\tilde{w}_1^{(j)}}{\sum_k \tilde{w}_1^{(k)}}
$$

For each time step $t = 2, \ldots, T$:

1. For each particle $j$, draw the index of its parent: $a_t^{(j)} \sim \mathrm{Multinomial}(\mathbf{w}_{t-1})$. Write $z^{(j)}_{t-1} \equiv x_t^{\left(a^{(j)}_t \right)}$ as the state of parent of the $j$-th particle in the previous time step.
1. Generate the state at this time step for each particle: $x_t^{(j)} \sim q {\left(\cdot \middle| y_t, z^{(j)}_{t-1} \right)}$
1. Extend each particle by taking its parent and putting $x_t$ onto it
1. Generate weights, then normalize

$$
\tilde{w}_t^{(j)} = \frac{
    p{\left(x_t^{(j)} \middle| z_{t-1}^{(j)} \right)}
    p{\left(y_t \middle| x_t^{(j)} \right)}
}{
    q{\left(x^{(j)}_t \middle| y_t, z^{(j)}_{t-1} \right)}
}
$$

### Estimating marginal likelihood

The final weights are $w^{(j)}_T$. The complete particles are $\mathbf{x}^{(j)} = \left( x_1^{(j)}, \ldots x_T^{(j)} \right)$.

We then approximate the marginal likelihood

$$
p(y|\theta) = \int_X p(y| \mathbf{x}, \theta) p(\mathbf{x}) \,\mathrm{d}\mathbf{x}
$$

with a weighted sum over the particles:

$$
\hat{p}(\mathbf{y}|\theta) = \frac{1}{N} \sum_{j=1}^N p(\mathbf{y} | \mathbf{x}^{(j)}, \theta) \cdot w_T^{(j)}
$$
