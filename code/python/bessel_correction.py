import numpy as np

print(np.mean([np.var(np.random.normal(size=3)) for i in range(1000)]))
