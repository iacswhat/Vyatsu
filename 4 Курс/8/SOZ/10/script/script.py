import numpy as np
from random import shuffle
import math


def f(x1, x2):
    return (3 * x1**3) * np.cos(x2 - 4)

x1 = np.linspace(-6, 5, 50)
x2 = np.linspace(-6, 4, 50)

X1, X2 = np.meshgrid(x1, x2)

Y = f(X1, X2)

c = list(zip(X1.flatten(), X2.flatten(), Y.flatten()))
shuffle(c)

np.savetxt("dataset.dat", c, fmt="%f")
