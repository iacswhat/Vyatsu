import numpy as np
from scipy.optimize import curve_fit

# Заданные диапазоны переменных
x1_values = np.arange(-6, 6)
x2_values = np.arange(-6, 5)

# Значения функции
def func(x1, x2):
    return (3 * x1**3) * np.cos(x2 - 4)

y_values = []
for x1 in x1_values:
    for x2 in x2_values:
        y_values.append(func(x1, x2))

# Подготовка данных для линейной регрессии
x_data = []
for x1 in x1_values:
    for x2 in x2_values:
        x_data.append([x1, x2])

x_data = np.array(x_data)
y_data = np.array(y_values)

# Линейная регрессия
def linear_regression(x, a, b, c):
    return a * x[:,0] + b * x[:,1] + c

# Проводим линейную регрессию для каждого правила
popt, _ = curve_fit(linear_regression, x_data, y_data)

print("Параметры линейной регрессии:", popt)
