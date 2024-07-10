import tkinter as tk

def gcd(a, b):
    while b != 0:
        a, b = b, a % b
    return a

def modinv(a, m):
    m0, x0, x1 = m, 0, 1
    while a > 1:
        q = a // m
        m, a = a % m, m
        x0, x1 = x1 - q * x0, x0
    return x1 + m0 if x1 < 0 else x1

def generate_keys(p, q):
    n = p * q
    phi_n = (p - 1) * (q - 1)
    
    # Выбираем открытую экспоненту e
    e = 65537
    
    # Находим закрытую экспоненту d
    d = modinv(e, phi_n)
    
    return (e, n), (d, n)

def encrypt(message, public_key):
    e, n = public_key
    encrypted_message = [pow(ord(char), e, n) for char in message]
    return encrypted_message

def decrypt(encrypted_message, private_key):
    d, n = private_key
    decrypted_message = ''.join([chr(pow(char, d, n)) for char in encrypted_message])
    return decrypted_message



def encrypt_sig(message, private_key):
    d, n = private_key
    encrypted_message = [pow(byte, d, n) for byte in message]
    return encrypted_message

def decrypt_sig(encrypted_message, public_key):
    e, n = public_key
    decrypted_message = [pow(byte, e, n) for byte in encrypted_message]
    return decrypted_message


p = 577
q = 457

def generate(public, private):
    public_key, private_key = generate_keys(p, q)
    public.delete("1.0", tk.END)
    public.insert("1.0", public_key)

    private.delete("1.0", tk.END)
    private.insert("1.0", private_key)



def encrypt_text(input_entry, output_entry, public_entry):
    input_text = input_entry.get("1.0", "end-1c")
    public_key = tuple(map(int, public_entry.get("1.0", "end-1c").split()))

    encrypted_text = encrypt(input_text, public_key)

    output_entry.delete("1.0", tk.END)
    output_entry.insert("1.0", encrypted_text)

def decrypt_text(input_entry, output_entry, private_entry):
    input_text = input_entry.get("1.0", "end-1c")
    private_key = tuple(map(int, private_entry.get("1.0", "end-1c").split()))

    numbers_list = list(map(int, input_text.split()))

    decrypted_text = decrypt(numbers_list, private_key)

    output_entry.delete("1.0", tk.END)
    output_entry.insert("1.0", decrypted_text) 
