import itertools

sign_list = list(itertools.product(range(2), repeat=15))
num = len([s for s in sign_list if sum(s) >= 13])
den = len(sign_list)
print(num / den * 2)
