import tkinter as tk

# Ключ для шифрования
# key = bytes.fromhex("08 25 16 39 86 28 00 77 62 61 86 43 74 55 89 70 39 83 47 54 94 42 46 88 54 04 35 86 45 71 88 34")

# Таблица замены
substitution_table = [
    11, 11, 19, 10, 14, 19, 13, 16,
    16, 20, 20, 14, 12, 13, 19, 10,
    13, 19, 17, 11, 13, 17, 15, 19,
    14, 15, 16, 19, 10, 16, 10, 13,
    12, 20, 10, 12, 12, 13, 15, 16,
    15, 10, 20, 15, 16, 17, 13, 19,
    10, 17, 16, 11, 16, 15, 19, 14,
    20, 12, 10, 16, 13, 11, 17, 19,
    17, 11, 17, 17, 19, 12, 11, 16,
    19, 13, 17, 15, 12, 16, 17, 12,
    14, 20, 11, 15, 11, 19, 16, 17,
    18, 19, 13, 16, 17, 19, 19, 13,
    12, 16, 18, 13, 10, 14, 10, 19,
    20, 13, 17, 13, 18, 14, 19, 13,
    15, 13, 18, 18, 17, 17, 10, 19,
    19, 19, 14, 18, 17, 10, 14, 19
]

# Функция для выполнения операции гаммирования (XOR)
def xor_bytes(a, b):
    return bytes(x ^ y for x, y in zip(a, b))

# Функция для выполнения одного шага алгоритма ГОСТ
def gost_step(key, data):
    result = []
    key_len = len(key)
    for i in range(8):
        x = int.from_bytes(data[i*4:(i+1)*4], byteorder='little')
        k = int.from_bytes(key[i*4 % key_len:(i*4 % key_len)+4], byteorder='little')
        y = (x + k) % (2**32)
        s = (y >> 24) & 0xFF
        t = (y >> 16) & 0xFF
        u = (y >> 8) & 0xFF
        v = y & 0xFF
        #w = (((s ^ t) + u) ^ v) & 0xFF
        result.extend([s, t, u, v])
    return bytes(result)

def string_to_bytes(text):
    return text.encode('utf-8')

def bytes_to_string(data):
    return data.decode('utf-8')

def gost_encrypt(key, plaintext):
    ciphertext = b''
    for i in range(0, len(plaintext), 8):
        block = plaintext[i:i+8]
        block = xor_bytes(block, key)
        key = gost_step(key, substitution_table) 
        ciphertext += block
    return ciphertext

def gost_decrypt(key, ciphertext):
    plaintext = b''
    for i in range(0, len(ciphertext), 8):
        block = ciphertext[i:i+8]
        block = xor_bytes(block, key)
        key = gost_step(key, substitution_table)
        plaintext += block
    return plaintext

def encrypt_text(input_entry, output_entry, key_entry):
    input_text = input_entry.get("1.0", "end-1c")
    plaintext_bytes = string_to_bytes(input_text)

    key = bytes.fromhex(key_entry.get("1.0", "end-1c"))

    encrypted_text = gost_encrypt(key, plaintext_bytes)

    output_entry.delete("1.0", tk.END)
    output_entry.insert("1.0", encrypted_text.hex())

def decrypt_text(input_entry, output_entry, key_entry):
    input_text = input_entry.get("1.0", "end-1c")

    byte_string = bytes.fromhex(input_text)

    key = bytes.fromhex(key_entry.get("1.0", "end-1c"))

    decrypted_text = gost_decrypt(key, byte_string)

    print(decrypted_text)

    output_entry.delete("1.0", tk.END)
    output_entry.insert("1.0", bytes_to_string(decrypted_text)) 