import itertools

# Compute all possible subsets and their ranks

n = 15
ranks = list(range(1, n + 1))

# first, using Wilcoxon's T statistic: the sum of the ranks of the data pairs
# with the unusual sign

obs_rs = sum([10, 14])
print('obs rank sum:', obs_rs)

possible_rs = [sum(xs) for m in range(n + 1) for xs in itertools.combinations(ranks, m)]

p_greater = len([x for x in possible_rs if x <= obs_rs]) / len(possible_rs)
print(p_greater)

# And now using the W statistic: the sum of all the ranks, but with the sign
# modulated by the data values

obs_signs = [1 if r in [10, 14] else -1 for r in ranks]
obs_w = sum([r * s for r, s in zip(ranks, obs_signs)])
print('obs w:', obs_w)

possible_signs = itertools.product([1, -1], repeat=15)
possible_w = [sum([r * s for r, s in zip(ranks, signs)]) for signs in possible_signs]

p_greater = len([x for x in possible_w if x <= obs_w]) / len(possible_w)
print(p_greater)
