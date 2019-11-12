import itertools

# Old code

sign_list = list(itertools.product(range(2), repeat=15))
num = len([s for s in sign_list if sum(s) >= 13])
den = len(sign_list)
# print(num / den * 2)

# Given n total tosses, of which x are heads, what's the p-value?

observed_data = ['H', 'H', 'T', 'T', 'T', 'T', 'H', 'T', 'T', 'T']
stat = lambda observation: observation.count('H')
observed_stat = stat(observed_data)

# this is 3 heads out of 10 flips
assert len(observed_data) == 10
assert observed_stat == 3

# universe of all observations
flip = ['H', 'T']
universe = list(itertools.product(flip, repeat=len(observed_data)))

# test statistics for each of those observations
stats = [stat(possibility) for possibility in universe]

# compute p-value by counting
p_value_numerator = len([stat for stat in stats if stat <= observed_stat])
p_value_denominator = len(universe)
p_value = p_value_numerator / p_value_denominator

print("One-sided, low-side p-value:", p_value)

# compare with R's result:
# r$> binom.test(3, 10, alternative = 'less')$p.value
# [1] 0.171875

# make a two-sided p-value
stat_upper = len(observed_data) - observed_stat
p_value_2sided_numerator = len([stat for stat in stats if stat <= observed_stat or stat >= stat_upper])
p_value_2sided = p_value_2sided_numerator / p_value_denominator

print("Two-sided p-value:", p_value_2sided)

# compare with R's result:
# r$> binom.test(3, 10)$p.value
# [1] 0.34375
