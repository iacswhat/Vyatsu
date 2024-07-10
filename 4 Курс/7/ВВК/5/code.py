from math import factorial as fact
from functools import reduce


tt = [8e-9, 8e-9, 6e-9, 10e-9, 7e-9, 7e-9, 4e-9]
L = 64
ti = 10e-9
ts = 48e-9
tc = 11e-9 #max(tt)
n = 6


def P(L, n, tc, ti):
	return L / (tc * (L + n - 1) + ti)

def P1(L, n, tc):
	return L / (tc * (L + n - 1))

def d(f, r):
	return f * r + (1 - r)

def tstart(ti, tc, n):
	return ti + n * tc

def tstart1(tc, n):
	return n * tc

def E(L, tscalar, tstart, tc):
	return L * tscalar / (tstart + (L - 1) * tc)

print(f'P = {P(64, 6, 11e-9, 10e-9)}')
r = tstart(ti, tc, n)/tc
print(f'r = {r}')
print(f'd = {0.5 * r + 0.5}')

print(f'tstart1 = {tstart(10e-9, 12e-9, n)}')

print(f'E = {E(64, 48e-9, tstart(10e-9, 11e-9, 6), 11e-9)}')

print(f'R1 = {1/12e-9}')
print(f'R1 = {1/11e-9}')


print("=====================================")

p = P(64, 6, 11e-9, 10e-9) + \
	P1(64, 6, 11e-9)


print(f'P = {p / 2}')

e = E(64, 48e-9, tstart(10e-9, 12e-9, 4), 12e-9) +\
    E(96, 49e-9, tstart(11e-9, 12e-9, 4), 12e-9) +\
	E(96, 49e-9, tstart1(12e-9, 4), 12e-9)
print(f'E = {e / 3}')


print("=====================================")
print(f'P = {P(64, 9, 11e-9, 10e-9)}')
print(f'E = {E(64, 48e-9, tstart(10e-9, 11e-9, 9), 11e-9)}')