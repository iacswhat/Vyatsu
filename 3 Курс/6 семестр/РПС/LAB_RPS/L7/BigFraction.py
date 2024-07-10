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


# def mul(main, sec):
#     buffer = fractions.Fraction(main.numerator * sec.numerator, main.denominator * sec.denominator)
#     buffer.__reduce__()
#     return buffer
#
#
# def div(main, sec):
#     buffer = fractions.Fraction(main.numerator * sec.denominator, main.denominator * sec.numerator)
#     buffer.__reduce__()
#     return buffer
#
#
# def sum(main, sec):
#     if main.denominator == sec.denominator:
#         buffer = fractions.Fraction(main.numerator + sec.numerator, main.denominator)
#     elif main.denominator != sec.denominator:
#         t1 = main.numerator * sec.denominator
#         t2 = sec.numerator * main.denominator
#         buffer = fractions.Fraction(t1 + t2, main.denominator * sec.denominator)
#     buffer.__reduce__()
#     return buffer
#
#
# def sub(main, sec):
#     if main.denominator == sec.denominator:
#         buffer = fractions.Fraction(main.numerator - sec.numerator, main.denominator)
#     elif main.denominator != sec.denominator:
#         t1 = main.numerator * sec.denominator
#         t2 = sec.numerator * main.denominator
#         buffer = fractions.Fraction(t1 - t2, main.denominator * sec.denominator)
#     buffer.__reduce__()
#     return buffer
