import fractions
import math

# Умножение
multiply_num = lambda main, sec: main.numerator * sec.numerator

multiply_den = lambda main, sec: main.denominator * sec.denominator

# Деление
divide_num = lambda main, sec: main.numerator * sec.denominator

divide_den = lambda main, sec: main.denominator * sec.numerator

# Сложение
sum_num = lambda main, sec: main.numerator + sec.numerator

# Вычитание
sub_num = lambda main, sec: main.numerator - sec.numerator

# Общее
num_main = lambda main, sec: main.numerator * sec.denominator
num_sec = lambda main, sec: sec.numerator * main.denominator
fr = lambda num, den: fractions.Fraction(num, den)

