# Random processes

A *random process* is a collection of random variables, indexed by some set of values.
For example, we might think of a set of random variables indexed by continuous time.

## Poisson point process

Let there be some time-varying intensity $\lambda(t) \geq 0$.
Define $\Lambda(a,b) = \int_a^b \lambda(t) \,dt$.
Then define if:

1. $N(a, b) \sim \mathrm{Poisson}\left( \Lambda(a,b) \right)$
1. $N(a,b)$ and $N(c,d)$ are independent if $(a,b)$ and $(c,d)$ are disjoint,
1. $N(a,c) = N(a,b) + N(b,c)$ for $a \leq b \leq c$

then $N$ is a Poisson point process.

Independence means that, given that an "arrival" occurred at $a$, the probability that there are no arrivals until (at latest) $b$ is $f_\mathrm{Pois}(0; \Lambda(a,b)) = e^{-\Lambda(a,b)}$.
It follows that the probability that the first event after $a$ occurs at $b$ is

$$
  \frac{d}{dt} e^{-\Lambda(a,b)} = \lambda(b) e^{-\Lambda(a,b)}
$$

The probability of no event $e^{-\Lambda(a,b)}$ is the *survival function*.
The probability that an event occurs at $b$ conditional on no event having occurred since $a$ is then just $\lambda(b)$.
In other words, $\lambda(t)$ is the *hazard function*, in survival analysis terms.
