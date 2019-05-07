#!/usr/bin/env Rscript

import::from(tidyr, unnest, crossing)

prob = 0.5

bin = tibble(n = c(5, 10, 25, 50)) %>%
  mutate(x = map(n, ~ 0:.)) %>%
  unnest() %>%
  mutate(
    pmf = map2_dbl(x, n, ~ dbinom(.x, .y, prob = prob)),
    pdf = map2_dbl(x, n, ~ dnorm(.x, .y * prob, sd = sqrt(.y * prob * (1 - prob))))
  )

nor = tibble(n = unique(bin$n)) %>%
  mutate(x = map(n, ~ seq(0, ., length.out = 1000))) %>%
  unnest() %>%
  mutate(pdf = map2_dbl(x, n, ~ dnorm(.x, .y * prob, sd = sqrt(.y * prob * (1 - prob)))))

approximation_plot = bin %>%
  ggplot(aes(x, pmf)) +
  facet_wrap(~ n, scales = 'free') +
  geom_line(data = nor, aes(y = pdf), color = 'red', size = 1.0) +
  geom_point() +
  geom_line()

difference_plot = bin %>%
  mutate(diff = pmf - pdf) %>%
  ggplot(aes(x, diff)) +
  facet_wrap(~ n, scales = 'free_x') +
  geom_point() +
  geom_line()

ggsave('approximation.pdf', plot = approximation_plot)
ggsave('difference.pdf', plot = difference_plot)
