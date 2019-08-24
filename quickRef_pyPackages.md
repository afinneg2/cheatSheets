Cheat sheet for using important python packages

[TOC]

# venv

Notes https://docs.python.org/3/library/venv.html 

+ What is a python virtual environment (VE)
  + A virtual environment is a Python environment such that the _Python interpreter, libraries and scripts installed into it are isolated from those installed in other virtual environments, and (by default) any libraries installed in a “system” Python_, i.e., one which is installed as part of your operating system.
  + python VE is distinugished by certain python executable files and other files which indicate that it is a virtual environment.

+ Each virtual environment has its own python binary (same version as python initialing in virtual environment (VE) and its own site directories (ie. `site-packeges/`)

+ Create VEs with 

  ```bash
  python3 -m venv /path/to/new/virtual/environment ##add option --promt <myPrompt> to set prompt after activation
  ```

  + This should automatically install pip (and setuptools ?) into the VE 

+ \Activate with 

  ```bash
  source <venv>/bin/activate
  ```

+ Effects of activating VE 
  + VE binaries folder is prepended to `$PATH` 
  + Is there also some change in `$PYTHONPATH` or some other mechanism for pointing python importes to VE `site-packeges/`  ?

+ see also: https://packaging.python.org/tutorials/installing-packages/#creating-virtual-environments



# setuptools



# scipy.sparse
####Working with Sparse Matrices[^1]
Data structures for representing sparse matrices

- __Dictinoary of keys__: `{ (row_idx , col_idx): value if value != 0 }`
- __List of Lists__ : `[ [(j,  M[i,j]) for j in cols  if M[i,j] !=0 ] for i in rows]`
- __Coordinate List__ `[(i,j, M[i,j]) if  M[i,j] !=0 ]`

Data structures for sparse matrices that are also computationally efficient

- __Compressed Sparse Row (csr)__ : 3 1d arrays stroing — non-zero vals, extents (?) of rows, column indices
- __Compressed Sparse Column__: similar to csr 

### Sparse data structures in Python [^2]

Scipy methods for representing sparse matrix

- Bloick Sparse Row matrix (BSR)
- Coorinate list matrix (COO)
- Compressed Sparse Column matrix (CSC)
- Compressed Sparse Row matrix (CSR)
- Sparse matrix with DIAgonal storage (DIA)
- Dictionary Of Keys based sparse matrix (DOK)
- Row-based linked list sparse matrix (LIL)

#### Dictionary of Keys

` (row_idx , col_idx): value if value != 0 }`

Advantages:

- Efficient access O(1) on average, fast construcion, flexible structure, efficient conversion to COO format

Disadvantgaes

- Slow iteration, arithmeti , slicing

#### LIL

```python
>>> matrix = random(3, 3, format='lil', density=0.6)
>>> matrix.data
array([[0.08833981417401027, 0.16911083656253545], [],
       [0.19806286475962398, 0.7605307121989587, 0.22479664553084766]], dtype=object)
>>> matrix.rows
array([[1, 2], [], [0, 1, 2]], dtype=object)
```

Advantages:

- fast incremental construction (why?)

Disadvantages 

​	+ slow arithmetic slow column slicing

#### Coordinate List 

`[(i,j, M[i,j]) if  M[i,j] !=0 ]`

Advantages:

- Fast conversion to CSR/CSC form, fast incremental contstuction

Disadvantages:

- slow access , arithmetic

#### Compressed Sparse format

- Most-used

  __CSR__

   Composed of 3 numpy arrays:

  - `data` - 2d array of non-zero elements in row-major order
  - `indptr` — points to row starts
  - `indices` — array of column indices (indicating which cells have non-zero values)

# pandas time series [^pd_docs_ts]



# multiprocessing[^3] 

```python
import multiprocessing as mp
```

#### Number of detected processors

```python
mp.cpu_count()
```

#### Synchronous vs Asynchronous execution

__Synchronous__ - processes must complete in the order they start. The main program will be locked until process that is expected to complete next finishes

+ Handeled by `Pool.map()` `Pool.starmap()` and `pool.apply()`

__Asynchronous__- processes can complete in any order (usually faster)

+  Handeled by `Pool.map_async()`, `Pool.starmap_async()`, `Pool.apply_async()`

#### Synchronous

__Use `pool.map` to apply a function to an iterable__

```python
with Pool(processes=4) as pool:
	result = pool.map(myFunc, myIterable)
## Alternatively
pool = mp.Pool(processes=4)
result = pool.map(myFunc, myIterable)
pool.close()
```

__Use `pool.apply` when you need to pass other arguments__

```python
with Pool(processes=4) as pool:
	result =  [ pool.apply(myFunc, args=(x, param1, param2)) for x in iterable ] ## Is this the  correct use !?!?
```

__Use `pool.starmap` when you want to expand  an iterable element [ e.g. like calling f(*x) ]__

```python
with Pool(processes=4) as pool:
	result =  pool.starmap( func, [ (x,y) for x,y in zip(x_iter, y_iter) ] ) ## usage of zip is just an example
```

#### Asynchronous

Order of outputs will be arbitrary. Therefore, it's frequently useful to define the mapped/applied function to 

__TODO__: Write this

#### Misc facts

+ multiprocess uses subprocess rather than threads





# TODO

+ Cleanup scipy.sparse
+ 



[^1]: https://machinelearningmastery.com/sparse-matrices-for-machine-learning/
[^2]:  https://rushter.com/blog/scipy-sparse-matrices/ 
[^3]: https://www.machinelearningplus.com/python/parallel-processing-python/
[^pd_docs_ts]: http://pandas.pydata.org/pandas-docs/stable/user_guide/timeseries.html

