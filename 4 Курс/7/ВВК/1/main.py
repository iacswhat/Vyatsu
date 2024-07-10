from math import factorial as fact
from functools import reduce


def c_m_n(m, n):
    return fact(n) / (fact(m) * fact(n - m))


def p_m_n(m, n, p):
    return c_m_n(m, n) * (p ** m) * ((1 - p) ** (n - m))


def r_m_n(m, n, p):
    return 1 - sum(p_m_n(i, n, p) for i in range(0, m))

g1 = reduce(lambda x, y: x * y, [0.96, 0.96, 0.96, 0.91, 0.91, 0.91, 0.91, 0.91, 0.91])
print("G1 - ", round(g1, 6))

g2 = r_m_n(1, 2, 0.96) * r_m_n(1, 2, 0.96 ** 2) * r_m_n(1, 2, 0.91 ** 6)
print("G2 - ", g2)

g3 = r_m_n(1, 3, 0.96) * r_m_n(1, 3, 0.96 ** 2) * r_m_n(1, 3, 0.91 ** 6)
print("G3 - ", round(g3, 6))

g4 = 0.96 ** 2 * r_m_n(2, 3, 0.96) * r_m_n(6, 7, 0.91)
print("G4 - ", round(g4, 6))

g5 = 0.96 ** 2 * r_m_n(2, 4, 0.96) * r_m_n(6, 8, 0.91)
print("G5 - ", round(g5, 6))

g6 = 0.96 ** 2 * r_m_n(2, 4, 0.96) * r_m_n(6, 12, 0.91)
print("G6 - ",g6)