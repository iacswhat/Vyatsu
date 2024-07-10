import tkinter as tk
from tkinter import ttk
from tkinter import Text
import first_task as ft
import second_task as st
import third_task as tt
import fourth_task as frt
import fifth_task as fft



def create_page1(tab):

    task = "Напишите дешифратор для <<ШИФРА А1Я33>> и расшифруйте предоставленную строку: -19-14-6-18-20-30-15-6-8-5-6-20-10-8-10-9-15-30-8-5-1-20-30-15-6-5-16-13-8-15-1"

    frame1 = ttk.Frame(tab)
    frame2 = ttk.Frame(tab)
    frame3 = ttk.Frame(tab)

    text = Text(tab, width = 100, height=10)
    text.pack()
    text.insert("1.0", task)
    text.config(state="disabled")

    in_lable = ttk.Label(frame1, width=10, text= "Input")
    #input_entry = ttk.Entry(frame1, width=100)
    input_entry = Text(frame1, width=75, height= 10)

    out_lable = ttk.Label(frame2, width=10, text= "Output")
    #output_entry = ttk.Entry(frame2, width=100)
    output_entry = Text(frame2, width=75, height= 10)

    encrypt_button = ttk.Button(frame3, text="Зашифровать", command= lambda: ft.encrypt_text(input_entry, output_entry))
    decrypt_button = ttk.Button(frame3, text="Дешифровать", command= lambda: ft.decrypt_text(input_entry, output_entry))

    frame1.pack()
    frame2.pack()
    frame3.pack()

    in_lable.pack(padx=10, pady=10, side="left")
    input_entry.pack(padx=10, pady=10, side="left")
    out_lable.pack(padx=10, pady=10, side="left")
    output_entry.pack(padx=10, pady=10, side="left")
    encrypt_button.pack(padx=10, pady=10, side="left")
    decrypt_button.pack(padx=10, pady=10, side="left")



def create_page2(tab):

    task = ("Зашифруйте строку: <<Я хочу хоть с одним человеком обо всём говорить как с собой.>> Алгоритмом шифрования ГОСТ 28147 89 в режиме гаммирование.\n"
    + "Ключ для шифрования: 0825163986280077626186437455897039834754944246885404358645718834\n"
    + "Используйте узлы замены:\n"
    + "11   11   19   10   14   19   13   16\n"
    + "16   20   20   14   12   13   19   10\n"
    + "13   19   17   11   13   17   15   19\n"
    + "14   15   16   19   10   16   10   13\n"
    + "12   20   10   12   12   13   15   16\n"
    + "15   10   20   15   16   17   13   19\n"
    + "10   17   16   11   16   15   19   14\n"
    + "20   12   10   16   13   11   17   19\n"
    + "17   11   17   17   19   12   11   16\n"
    + "19   13   17   15   12   16   17   12\n"
    + "14   20   11   15   11   19   16   17\n"
    + "18   19   13   16   17   19   19   13\n"
    + "12   16   18   13   10   14   10   19\n"
    + "20   13   17   13   18   14   19   13\n"
    + "15   13   18   18   17   17   10   19\n"
    + "19   19   14   18   17   10   14   19"
)
    
    frame1 = ttk.Frame(tab)
    frame2 = ttk.Frame(tab)
    frame3 = ttk.Frame(tab)
    frame4 = ttk.Frame(tab)

    text = Text(tab, width = 100, height=10)
    text.pack()
    text.insert("1.0", task)
    text.config(state="disabled")

    in_lable = ttk.Label(frame1, width=10, text= "Input")
    input_entry = Text(frame1, width=75, height= 10)

    out_lable = ttk.Label(frame2, width=10, text= "Output")
    output_entry = Text(frame2, width=75, height= 10)

    key_lable = ttk.Label(frame3, width=10, text= "Key")
    key_entry = Text(frame3, width=75, height= 1)

    encrypt_button = ttk.Button(frame4, text="Зашифровать", command= lambda: st.encrypt_text(input_entry, output_entry, key_entry))
    decrypt_button = ttk.Button(frame4, text="Дешифровать", command= lambda: st.decrypt_text(input_entry, output_entry, key_entry))

    frame1.pack()
    frame2.pack()
    frame3.pack()
    frame4.pack()

    in_lable.pack(padx=10, pady=10, side="left")
    input_entry.pack(padx=10, pady=10, side="left")
    out_lable.pack(padx=10, pady=10, side="left")
    output_entry.pack(padx=10, pady=10, side="left")
    key_lable.pack(padx=10, pady=10, side="left")
    key_entry.pack(padx=10, pady=10, side="left")
    encrypt_button.pack(padx=10, pady=10, side="left")
    decrypt_button.pack(padx=10, pady=10, side="left")



def create_page3(tab):
    task = ("Алгоритм шифрования rsa.\n"
    + "Сгенерируйте открытый и закрытый ключи в алгоритме шифрования RSA, выбрав простые числа p = 577 и q = 457.\n"
    + "Зашифруйте сообщение: Но никто не знает, что самое большое счастье — в понимании."
    )

    text = Text(tab, width = 100, height=10)
    text.pack()
    text.insert("1.0", task)
    text.config(state="disabled")

    frame1 = ttk.Frame(tab)
    frame2 = ttk.Frame(tab)
    frame3 = ttk.Frame(tab)
    frame4 = ttk.Frame(tab)

    in_lable = ttk.Label(frame1, width=10, text= "Input")
    input_entry = Text(frame1, width=75, height= 10)

    out_lable = ttk.Label(frame2, width=10, text= "Output")
    output_entry = Text(frame2, width=75, height= 10)

    encrypt_button = ttk.Button(frame3, text="Зашифровать", command= lambda: tt.encrypt_text(input_entry, output_entry, public_entry))
    decrypt_button = ttk.Button(frame3, text="Дешифровать", command= lambda: tt.decrypt_text(input_entry, output_entry, private_entry))
    generate_button = ttk.Button(frame3, text="Сгенерировать", command= lambda: tt.generate(public_entry, private_entry))

    public_lable = ttk.Label(frame4, width=10, text= "Public")
    public_entry = Text(frame4, width= 20, height= 1)

    private_lable = ttk.Label(frame4, width=10, text= "Private")
    private_entry = Text(frame4, width=20, height= 1)

    frame1.pack()
    frame2.pack()
    frame3.pack()
    frame4.pack()

    in_lable.pack(padx=10, pady=10, side="left")
    input_entry.pack(padx=10, pady=10, side="left")
    out_lable.pack(padx=10, pady=10, side="left")
    output_entry.pack(padx=10, pady=10, side="left")
    encrypt_button.pack(padx=10, pady=10, side="left")
    decrypt_button.pack(padx=10, pady=10, side="left")
    generate_button.pack(padx=10, pady=10, side="left")
    public_lable.pack(padx=10, pady=10, side="left")
    public_entry.pack(padx=10, pady=10, side="left")
    private_lable.pack(padx=10, pady=10, side="left")
    private_entry.pack(padx=10, pady=10, side="left")


def create_page4(tab):
    task = ("Реализовать алгоритм криптографической функции – adler32.\n"
            + "Зашифруйте сообщение: И нет величия там, где нет простоты, добра и правды.")

    text = Text(tab, width = 100, height=10)
    text.pack()
    text.insert("1.0", task)
    text.config(state="disabled")

    frame1 = ttk.Frame(tab)
    frame2 = ttk.Frame(tab)
    frame3 = ttk.Frame(tab)

    in_lable = ttk.Label(frame1, width=10, text= "Input")
    input_entry = Text(frame1, width=75, height= 10)

    out_lable = ttk.Label(frame2, width=10, text= "Output")
    output_entry = Text(frame2, width=75, height= 10)

    encrypt_button = ttk.Button(frame3, text="Зашифровать", command= lambda: frt.encrypt_text(input_entry, output_entry))
    

    frame1.pack()
    frame2.pack()
    frame3.pack()

    in_lable.pack(padx=10, pady=10, side="left")
    input_entry.pack(padx=10, pady=10, side="left")
    out_lable.pack(padx=10, pady=10, side="left")
    output_entry.pack(padx=10, pady=10, side="left")
    encrypt_button.pack(padx=10, pady=10, side="bottom")



def create_page5(tab):
    task = ("Используя хеш-образ строки: << Я люблю быть один, но рядом с кем-то.>>"
            + "И вычислите электронную цифровую подпись по схеме RSA.")

    text = Text(tab, width = 100, height=10)
    text.pack()
    text.insert("1.0", task)
    text.config(state="disabled")

    frame1 = ttk.Frame(tab)
    frame1_1 = ttk.Frame(frame1)
    frame1_2 = ttk.Frame(frame1)
    frame1_3 = ttk.Frame(frame1)
    frame1_4 = ttk.Frame(frame1)
    frame2 = ttk.Frame(tab)
    frame2_1 = ttk.Frame(frame2)
    frame2_2 = ttk.Frame(frame2)
    frame2_3 = ttk.Frame(frame2)
    frame2_4 = ttk.Frame(frame2)
    frame2_5 = ttk.Frame(frame2)
    frame3 = ttk.Frame(tab)
    frame3_1 = ttk.Frame(frame3)
    frame3_2 = ttk.Frame(frame3)
    frame3_3 = ttk.Frame(frame3)

    in_lable1 = ttk.Label(frame1_1, width=10, text= "Input")
    input_entry1 = Text(frame1_1, width=50, height= 5)

    out_lable1 = ttk.Label(frame1_2, width=10, text= "ЭЦП")
    output_entry1 = Text(frame1_2, width=50, height= 5)

    out_lable11 = ttk.Label(frame1_3, width=10, text= "Hash")
    output_entry11 = Text(frame1_3, width=50, height= 5)


    in_lable2 = ttk.Label(frame2_1, width=10, text= "Input")
    input_entry2 = Text(frame2_1, width=50, height= 5)

    out_lable2 = ttk.Label(frame2_2, width=10, text= "Hash")
    output_entry2= Text(frame2_2, width=50, height= 5)

    out_lable22 = ttk.Label(frame2_3, width=10, text= "ЭЦП")
    output_entry22 = Text(frame2_3, width=50, height= 5)

    out_lable222 = ttk.Label(frame2_4, width=10, text= "Decode\nhash")
    output_entry222 = Text(frame2_4, width=50, height= 5)

    public_lable = ttk.Label(frame3_1, width=10, text= "Public")
    public_entry = Text(frame3_1, width= 20, height= 1)

    private_lable = ttk.Label(frame3_2, width=10, text= "Private")
    private_entry = Text(frame3_2, width=20, height= 1)

    encrypt_button = ttk.Button(frame1_4, text="Подписать", command= lambda: fft.encrypt_text(input_entry1, output_entry1, output_entry11, private_entry))
    decrypt_button = ttk.Button(frame2_5, text="Проверить", command= lambda: fft.decrypt_text(input_entry2, output_entry2, output_entry22, output_entry222, public_entry))
    generate_button = ttk.Button(frame3_3, text="Сгенерировать", command= lambda: fft.generate(public_entry, private_entry))


    frame1.pack(side="left")
    frame1_1.pack()
    frame1_2.pack()
    frame1_3.pack()
    frame1_4.pack()
    frame2.pack(side="left")
    frame2_1.pack()
    frame2_2.pack()
    frame2_3.pack()
    frame2_4.pack()
    frame2_5.pack()
    frame3.pack(side="right")
    frame3_1.pack()
    frame3_2.pack()
    frame3_3.pack()

    in_lable1.pack(padx=10, pady=10, side="left")
    input_entry1.pack(padx=10, pady=10, side="left")
    out_lable1.pack(padx=10, pady=10, side="left")
    output_entry1.pack(padx=10, pady=10, side="left")
    out_lable11.pack(padx=10, pady=10, side="left")
    output_entry11.pack(padx=10, pady=10, side="left")
    in_lable2.pack(padx=10, pady=10, side="left")
    input_entry2.pack(padx=10, pady=10, side="left")
    out_lable2.pack(padx=10, pady=10, side="left")
    output_entry2.pack(padx=10, pady=10, side="left")
    out_lable22.pack(padx=10, pady=10, side="left")
    output_entry22.pack(padx=10, pady=10, side="left")
    out_lable222.pack(padx=10, pady=10, side="left")
    output_entry222.pack(padx=10, pady=10, side="left")
    encrypt_button.pack(padx=10, pady=10, anchor="center")
    decrypt_button.pack(padx=10, pady=10, anchor="center")
    generate_button.pack(padx=10, pady=10, side="left")
    public_lable.pack(padx=10, pady=10, side="left")
    public_entry.pack(padx=10, pady=10, side="left")
    private_lable.pack(padx=10, pady=10, side="left")
    private_entry.pack(padx=10, pady=10, side="left")




def init():
    root = tk.Tk()
    root.title("Lab3")

    notebook = ttk.Notebook(root)

    page1 = ttk.Frame(notebook)
    notebook.add(page1, text='Task 1')
    create_page1(page1)

    page2 = ttk.Frame(notebook)
    notebook.add(page2, text='Task 2')
    create_page2(page2)

    page3 = ttk.Frame(notebook)
    notebook.add(page3, text='Task 3')
    create_page3(page3)

    page4 = ttk.Frame(notebook)
    notebook.add(page4, text='Task 4')
    create_page4(page4)

    page5 = ttk.Frame(notebook)
    notebook.add(page5, text='Task 5')
    create_page5(page5)


    notebook.pack(expand=1, fill='both')

    root.mainloop()
