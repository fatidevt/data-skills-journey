# NumPy Cheat Sheet

## Why NumPy over lists?
- Python list element = 8+ bytes (size + ref count + type + value overhead)
- NumPy array element = fixed-size (1 byte for `int8`, up to 8 for `int64`), stored contiguously
- Fixed dtype → faster math, less memory

```python
import sys
sys.getsizeof(42)          # ~28 bytes (a Python int)

import numpy as np
np.array([10, 20], dtype=np.int8).itemsize   # 1
```

## Creating Arrays
```python
np.array([1, 2, 3])                  # from list
np.array([1, 2, 3], dtype='int8')    # specify dtype
np.zeros((2, 3))                     # all 0s
np.ones((2, 3), dtype='int8')        # all 1s
np.full((2, 3), 99)                  # all a given value
np.full_like(arr, 4)                 # same shape as arr, filled with 4
np.identity(5)                       # 5x5 identity matrix
np.random.rand(2, 3)                 # random floats [0,1)
np.random.randint(1, 9, size=(3,3))  # random ints in [low, high)
np.repeat(arr, 3, axis=0)            # repeat along an axis
```

## Inspecting Arrays
```python
a.ndim       # number of dimensions
a.shape      # (rows, cols, ...)
a.dtype      # data type
a.itemsize   # bytes per element
a.size       # total number of elements
a.nbytes     # size * itemsize
```

## Indexing & Slicing
```python
a[1, 5]           # element at row 1, col 5
a[0, :]           # entire row 0
a[:, 2]           # entire column 2
a[0, 1:6:2]       # slice [start:end:step]
a[1, 5] = 20      # set single element
a[:, 2] = 5       # set whole column
b[0, 1, 1]        # 3D: [block, row, col]
```

## Copying (⚠️ common bug)
```python
b = a            # b is a VIEW — changes to b affect a
b = a.copy()     # b is an independent copy
```
Slicing (`a[0, :]`) also returns a **view**, not a copy, in most cases.

## Math (element-wise)
```python
a + 2, a - 2, a * 2, a / 2, a ** 2
a + b            # element-wise between two arrays
np.sin(a), np.cos(a)
```

## Linear Algebra
```python
np.matmul(a, b)     # matrix multiplication
np.linalg.det(a)    # determinant
```

## Statistics
```python
np.min(stats)            # global min
np.min(stats, axis=1)    # min of each row
np.min(stats, axis=0)    # min of each column
np.max(stats)
np.sum(stats, axis=0)    # sum down each column
```
> `axis=0` → collapse rows (operate down columns)
> `axis=1` → collapse columns (operate across rows)

## Reshaping & Stacking
```python
before.reshape((4, 2))   # must preserve total element count
np.vstack([v1, v2])      # stack vertically (rows)
np.hstack([v1, v2])      # stack horizontally (columns)
```

## Loading Data
```python
filedata = np.genfromtxt('data.txt', delimiter=',')
filedata = filedata.astype('int8')
```

## Boolean Masking & Advanced Indexing
```python
filedata > 15                       # boolean mask, same shape
filedata[filedata > 15]             # 1D array of matching values
np.any(filedata > 15, axis=0)       # any match per column
np.all(filedata > 15, axis=1)       # all match per row
(filedata > 15) & (filedata < 18)   # combine conditions (use & / |, not and/or)

filedata[2:4, 0:2]                  # slice block
filedata[[0, 1, 2, 3], [0, 1, 2, 3]]  # fancy indexing: paired (row,col) picks
filedata[[0, 3, 4], 2:]              # select specific rows, then slice cols
```

## Quick Reference: Common Gotchas
| Gotcha | Fix |
|---|---|
| `b = a` shares memory | use `b = a.copy()` |
| `and`/`or` on arrays fails | use `&` / `\|` with parentheses per condition |
| dtype silently overflows (e.g. int8 max 127) | pick dtype based on expected value range |
| reshape fails | new shape must have same total element count |
