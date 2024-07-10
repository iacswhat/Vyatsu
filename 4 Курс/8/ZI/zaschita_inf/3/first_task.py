import tkinter as tk

letters = 'абвгдеёжзийклмнопрстуфхцчшщъыьэюя'


def encrypt_text(input_entry, output_entry):
    input_text = input_entry.get("1.0", "end-1c")

    result_string = '-'.join(str(letters.index(char) + 1) for char in input_text)

    output_entry.delete("1.0", tk.END)
    output_entry.insert("1.0", result_string)

def decrypt_text(input_entry, output_entry):

    input_text = input_entry.get("1.0", "end-1c")

    numbers = list(map(int, filter(None, input_text.split('-'))))

    result_string = ''

    for i in range(len(numbers)):
        result_string += letters[numbers[i] - 1]

    output_entry.delete("1.0", tk.END)
    output_entry.insert("1.0", result_string) 
