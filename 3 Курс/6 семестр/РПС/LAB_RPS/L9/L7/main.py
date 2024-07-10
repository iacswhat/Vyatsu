import BigFraction
import fractions
from tkinter import *
from tkinter.ttk import Combobox
import re
import ctypes
import time


lib = ctypes.CDLL('./Module.dll')
lib.multiply_num.restype = ctypes.c_char_p
lib.multiply_num.argtypes = [ctypes.c_char_p, ctypes.c_int, ctypes.c_char_p, ctypes.c_int]


def clicked():
    lbl_hint.configure(text= "Введите дроби", foreground='black')
    if (txt_num1.get() != "") & (txt_den1.get() != "") & (txt_num2.get() != "") & (txt_den2.get() != ""):
        try:
            num = txt_num1.get()
            num = re.sub('[^0-9-]', '', num)
            int(num)
        except:
            lbl_hint.configure(text="Неверный числитель 1!", foreground='red')

        try:
            den = txt_den1.get()
            den = re.sub('[^0-9-]', '', den)
            int(den)
        except:
            lbl_hint.configure(text="Неверный знаменатель 1!", foreground='red')

        if int(den) != 0:
            main = fractions.Fraction(int(num), int(den))
        else:
            lbl_hint.configure(text="Знаменатель = 0!", foreground='red')

        try:
            num = txt_num2.get()
            num = re.sub('[^0-9-]', '', num)
            int(num)
        except:
            lbl_hint.configure(text="Неверный числитель 2!", foreground='red')

        try:
            den = txt_den2.get()
            den = re.sub('[^0-9-]', '', den)
            int(den)
        except:
            lbl_hint.configure(text="Неверный знаменатель 2!", foreground='red')

        if int(den) != 0:
            sec = fractions.Fraction(int(num), int(den))
        else:
            lbl_hint.configure(text="Знаменатель = 0!", foreground='red')

        if combo.get() == "Сложение":
            if main.denominator == sec.denominator:
                num = BigFraction.sum_num(main.numerator, sec.numerator)
                den = main.denominator
                res = fractions.Fraction(num, den)
            elif main.denominator != sec.denominator:
                num1 = BigFraction.num_main(main.numerator, sec.denominator)
                num2 = BigFraction.num_sec(main.denominator, sec.numerator)
                den = BigFraction.multiply_den(main.denominator, sec.denominator)
                res = fractions.Fraction(num1 + num2, den)
        if combo.get() == "Вычитание":
            if main.denominator == sec.denominator:
                num = BigFraction.sub_num(main.numerator, sec.numerator)
                den = main.denominator
                res = fractions.Fraction(num, den)
            elif main.denominator != sec.denominator:
                num1 = BigFraction.num_main(main.numerator, sec.denominator)
                num2 = BigFraction.num_sec(main.denominator, sec.numerator)
                den = BigFraction.multiply_den(main.denominator, sec.denominator)
                res = fractions.Fraction(num1 - num2, den)
        if combo.get() == "Умножение":
            main_numerator_str = str(main.numerator)
            sec_numerator_str = str(sec.numerator)
            mn_bytes = main_numerator_str.encode('UTF-8')
            sn_bytes = sec_numerator_str.encode('UTF-8')
            start = time.time()
            num = lib.multiply_num(mn_bytes, len(mn_bytes), sn_bytes, len(sn_bytes))
            end = time.time() - start
            print("Time py = ", end)
            num_str = num.decode('utf-8')
            den = BigFraction.multiply_den(main.denominator, sec.denominator)
            res = fractions.Fraction(int(num_str), den)
        if combo.get() == "Деление":
            if sec.numerator != 0:
                num = lib.divide_num(main.numerator, sec.denominator)
                den = lib.divide_den(main.denominator, sec.numerator)
                res = fractions.Fraction(num, den)
            elif sec.numerator == 0:
                lbl_hint.configure(text= "Деление на 0!", foreground='red')
    else:
        lbl_hint.configure(foreground='red')

    try:
        string = str(res.numerator) + "/" + str(res.denominator)
        lbl_res1.configure(text=string)
    except:
        lbl_hint.configure(text="Деление на 0!", foreground='red')


if __name__ == '__main__':
    window = Tk()
    window.title("Lab7")
    window.geometry('600x150')

    lbl_num1 = Label(window, text="1 числитель")
    lbl_num1.grid(column=0, row=0)
    lbl_den1 = Label(window, text="1 знаменатель")
    lbl_den1.grid(column=0, row=1)

    lbl_num2 = Label(window, text="2 числитель")
    lbl_num2.grid(column=0, row=2)
    lbl_den2 = Label(window, text="2 знаменатель")
    lbl_den2.grid(column=0, row=3)

    lbl_res = Label(window, text="Результат")
    lbl_res.grid(column=0, row=4)

    lbl_hint = Label(window, text="Введите дроби")
    lbl_hint.grid(column=1, row=5)

    txt_num1 = Entry(window, width=50)
    txt_num1.grid(column=1, row=0)
    txt_den1 = Entry(window, width=50)
    txt_den1.grid(column=1, row=1)

    txt_num2 = Entry(window, width=50)
    txt_num2.grid(column=1, row=2)
    txt_den2 = Entry(window, width=50)
    txt_den2.grid(column=1, row=3)

    lbl_res1 = Label(window, width=50)
    lbl_res1.grid(column=1, row=4)

    combo = Combobox(window, width=20, state="readonly")
    combo['values'] = ('Сложение', 'Вычитание', 'Умножение', 'Деление')
    combo.current(0)
    combo.grid(column=2, row=2)

    btn = Button(window, width=20, text="Вычислить!", command=clicked)
    btn.grid(column=2, row=0)
    window.mainloop()