#!/usr/bin/env python3

### NumPy Ultraquick Tutorial
import numpy as np

# Task 1
feature = np.arange(6, 21)
print(feature)
label = 3*feature + 4
print(label)

# Task 2
noise = (np.random.random(size = (15,)) - 0.5) * 4
noise = (np.random.random([15]) * 4) - 2
print(noise)
label = label + noise
print(label)


### pandas Ultraquick Tutorial
import numpy as np
import pandas as pd

my_column_names = ['Eleanor', 'Chidi', 'Tahani', 'Jason']
my_data = np.random.randint(low = 0, high = 101, size = (3,4))
df = pd.DataFrame(data = my_data, columns = my_column_names)

print(df)
print(df['Eleanor'][1])

df['Janet'] = df['Tahani'] + df['Jason']
print(df)

