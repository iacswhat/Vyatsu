import tkinter as tk



def encrypt_adler32(string):
    MOD_ADLER = 65521
    s1 = 1
    s2 = 0
    for byte in string:
        s1 = (s1 + byte) % MOD_ADLER
        s2 = (s2 + s1) % MOD_ADLER
    return hex((s2 << 16) + s1)


def encrypt_text(input_entry, output_entry):
    input_text = input_entry.get("1.0", "end-1c")

    encoded_message = input_text.encode('utf-8')

    result_string = encrypt_adler32(encoded_message)


    output_entry.delete("1.0", tk.END)
    output_entry.insert("1.0", result_string)