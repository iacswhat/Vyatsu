import tkinter as tk
import third_task
import fourth_task

def split_hash(hash_value):
    hash_value = int(hash_value, 16)
    
    byte1 = (hash_value >> 24) & 0xFF
    byte2 = (hash_value >> 16) & 0xFF
    byte3 = (hash_value >> 8) & 0xFF
    byte4 = hash_value & 0xFF

    return [byte1, byte2, byte3, byte4]


def bytes_to_hash(byte_array):    
    hash_value = (byte_array[0] << 24) | (byte_array[1] << 16) | (byte_array[2] << 8) | byte_array[3]
    
    return hex(hash_value)



def generate(public_entry, private_entry):
    public_key, private_key = third_task.generate_keys(third_task.p, third_task.q)

    public_entry.delete("1.0", tk.END)
    public_entry.insert("1.0", public_key)

    private_entry.delete("1.0", tk.END)
    private_entry.insert("1.0", private_key)


def encrypt_text(input_entry, output_entry1, output_entry11, private_entry):
    input_text = input_entry.get("1.0", "end-1c")
    
    byte_message = input_text.encode('utf-8')
    
    hash_value = fourth_task.encrypt_adler32(byte_message)
    hash_bytes = split_hash(hash_value)
    
    private_key = tuple(map(int, private_entry.get("1.0", "end-1c").split()))
   
    signature = third_task.encrypt_sig(hash_bytes, private_key)
    
    output_entry1.delete("1.0", tk.END)
    output_entry1.insert("1.0", signature)
    output_entry11.delete("1.0", tk.END)
    output_entry11.insert("1.0", hash_value)


def decrypt_text(input_entry, output_entry2, output_entry22, output_entry222, public_entry):
    input_text = input_entry.get("1.0", "end-1c")

    byte_message = input_text.encode('utf-8')

    hash_value = fourth_task.encrypt_adler32(byte_message)

    input_numbers = output_entry22.get("1.0", "end-1c")

    numbers_list = list(map(int, input_numbers.split()))

    public_key = tuple(map(int, public_entry.get("1.0", "end-1c").split()))

    decode_hash_bytes = third_task.decrypt_sig(numbers_list, public_key)

    decode_hash = bytes_to_hash(decode_hash_bytes)

    output_entry2.delete("1.0", tk.END)
    output_entry2.insert("1.0", hash_value)
    output_entry222.delete("1.0", tk.END)
    output_entry222.insert("1.0", decode_hash)

