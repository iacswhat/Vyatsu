from math import *
from functools import reduce



def lagrange_interpolation(x: float, func: list, eps: float):
    xs, ys = func
    n = len(xs)

    ls = [reduce(lambda a, b: a * b, ((x - xs[j]) / (xs[i] - xs[j]) for j in range(n) if i != j)) for i in range(n)]

    res = sum(y * l for y, l in zip(ys, ls))

    return round(res, int(-log10(eps)))


func_lagrange = [
    (0.05, 0.10, 0.17, 0.25, 0.30, 0.36),
    (0.050042, 0.100335, 0.171657, 0.255342, 0.309336, 2.376403)
]

x_lagrange = 0.263

eps_lagrange = 0.000001

print('y = {} при x = {}'.format(lagrange_interpolation(x_lagrange, func_lagrange, eps_lagrange), x_lagrange))

