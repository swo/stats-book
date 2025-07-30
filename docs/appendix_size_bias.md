# Size bias

Imagine there are urns, each with some associated number $\lambda$ drawn from some distribution $f_\Lambda$, and then a number of balls $N$, such that $\mathbb{E}[N] = \lambda$. While the probability of drawing an _urn_ with value $\lambda$ follows $f_\Lambda$, the probability of drawing a _ball_ at random, and that ball coming from an urn with value $\lambda$ at random, follows a different distribution $f_{\Lambda^\star}$:

$$
f_{\Lambda^\star}(\lambda) = \frac{\lambda f_\Lambda(\lambda)}{\mathbb{E}[\lambda]}.
$$

This might sound abstract, but consider the example of the generation time. If each person has an infectious period of duration $Y \sim \mathrm{Exp}(1/\mu)$, and then creates secondary infections at times $X \sim \mathrm{Uniform}(0, Y)$, then the average time to secondary infection is:

```math
\begin{align*}
\mathbb{E}[X] &= \mathbb{E}\left[ \mathbb{E}[X|D] \right] \\
&= \mathbb{E}\left[ \tfrac{1}{2} D \right] \\
&= \frac{1}{2} \int_0^\infty y \frac{1}{\mathbb{E}[Y]} y \frac{1}{\mu} e^{-y/\mu} \,dy \\
&= \frac{\mu}{2} \int_0^\infty x^2 e^{-x} \,dx \\
&= \mu
\end{align*}
```

In other words, because of _size-biased sampling_, the expected time to secondary infection is actually equal to the expected duration of the infectious period.
