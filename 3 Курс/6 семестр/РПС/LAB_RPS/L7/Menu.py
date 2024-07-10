import BigFraction
import re
import fractions


def prin_menu():
    print("1. +")
    print("2. -")
    print("3. *")
    print("4. /")
    print("5. Новые значения")
    print("---------------------------")


def __get_num():
    while True:
        try:
            n = input("Введите числитель: ")
            n = re.sub('[^0-9-]', '', n)
            int(n)
            break
        except:
            print("Ошибка")
    return n


def __get_den():
    while True:
        try:
            n = input("Введите знаменатель: ")
            n = re.sub('[^0-9-]', '', n)
            if int(n) != 0:
                break
            elif int(n) == 0:
                print("Знаменатель = 0!")
        except:
            print("Ошибка")
    return n


def print_res(main, sec, res):
    print(main)
    print(sec)
    print(res)
    print("---------------------------")

def frac():
    num = __get_num()
    den = __get_den()
    frac = fractions.Fraction(int(num), int(den))
    return frac

def main_menu(main, sec):
    while True:
        prin_menu()
        while True:
            try:
                k = int(input("Выбирите действие: "))
                break
            except:
                print("Ошибка")

        if k == 1:
            if main.denominator == sec.denominator:
                res = fractions.Fraction(BigFraction.sum_num(main, sec), main.denominator)
            elif main.denominator != sec.denominator:
                res = fractions.Fraction(BigFraction.num_main(main, sec) + BigFraction.num_sec(main, sec),
                                         BigFraction.multiply_den(main, sec))
            print_res(main, sec, res)
        elif k == 2:
            if main.denominator == sec.denominator:
                res = fractions.Fraction(BigFraction.sub_num(main, sec), main.denominator)
            elif main.denominator != sec.denominator:
                res = fractions.Fraction(BigFraction.num_main(main, sec) - BigFraction.num_sec(main, sec),
                                         BigFraction.multiply_den(main, sec))
            print_res(main, sec, res)
        elif k == 3:
            res = fractions.Fraction(BigFraction.multiply_num(main, sec), BigFraction.multiply_den(main, sec))
            print_res(main, sec, res)
        elif k == 4:
            if sec.numerator != 0:
                res = fractions.Fraction(BigFraction.divide_num(main, sec), BigFraction.divide_den(main, sec))
                print_res(main, sec, res)
            elif sec.numerator == 0:
                print("Деление на 0!")
        elif k == 5:
            print("---------------------------")
            break



