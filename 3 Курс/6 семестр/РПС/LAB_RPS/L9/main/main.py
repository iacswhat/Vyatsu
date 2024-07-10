import ctypes
import fractions
import time
from fractions import Fraction
import timeit
# import numpy as np

lib = ctypes.CDLL('./Module.dll')


# lib.my_function.argtypes = [ctypes.c_char_p, ctypes.c_int]
# lib.my_function.restype = ctypes.c_char_p

# Определение сигнатуры функции
# lib.processStringWrapper.restype = ctypes.c_char_p
# lib.processStringWrapper.argtypes = [ctypes.c_char_p, ctypes.c_int]

lib.multiply_num.argtypes = [ctypes.c_char_p, ctypes.c_int, ctypes.c_char_p, ctypes.c_int]
lib.multiply_num.restype = ctypes.c_char_p

multiply_num = lambda main_num, sec_num: main_num * sec_num

def mul(main_num, sec_num):
    return main_num / sec_num


if __name__ == '__main__':
    number = "1" * 10000000  # Повторяем строку "0123456789" 1000 раз
    frac = number + "/3"
    a = Fraction(frac)
    b = Fraction(frac)
    # print(a, b)

    # a_str = str(a.numerator)
    # a_bytes = a_str.encode('utf-8')
    #
    # b_str = str(b.numerator)
    # b_bytes = b_str.encode('utf-8')
    #
    # res_cpp = lib.multiply_num(a_bytes, len(a_bytes), b_bytes, len(b_bytes))

    start = time.time()
    res_py = multiply_num(int(number), int(number))
    end = time.time() - start
    # print(res_py)
    print("Time py = ", end)




    # # Пример использования функции
    # string = "123"
    # length = len(string)
    #
    # # Вызов функции из динамической библиотеки
    # result = lib.processStringWrapper(string.encode('utf-8'), length)
    #
    # # Преобразование результата в строку
    # result_str = result.decode('utf-8')
    #
    # # Вывод результата
    # print("Result:", result_str)

    # input_string = "12345"
    #
    # # Преобразование строки в байты в формате UTF-8
    # input_bytes = input_string.encode('utf-8')
    #
    # # Вызов функции в C++
    # result = lib.my_function(input_bytes, len(input_bytes))
    #
    # # Преобразование результата в строку в Python
    # result_string = result.decode('utf-8')
    #
    # # Вывод результата
    # print(result_string)