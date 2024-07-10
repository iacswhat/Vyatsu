import json
import hashlib
from cryptography.fernet import Fernet, InvalidToken
import os
import uuid

def get_hardware_info():
    # Получаем MAC-адрес сетевого адаптера
    mac_address = ':'.join(['{:02x}'.format((uuid.getnode() >> elements) & 0xff) for elements in range(0,2*6,2)])

    hardware_info = {
        "mac_address": mac_address
    }
    return json.dumps(hardware_info)

def generate_license_key(hardware_info):
    # Генерируем лицензионный ключ на основе характеристик компьютера
    hash_object = hashlib.sha256(hardware_info.encode())
    return hash_object.hexdigest()

def load_license_key():
    # Загружаем зашифрованный лицензионный ключ из файла
    try:
        with open('license_key.enc', 'rb') as f:
            return f.read()
    except FileNotFoundError:
        return None
    
def load_encryption_key():
    # Загружаем ключ шифрования из файла
    try:
        with open('encryption_key.key', 'rb') as f:
            return f.read()
    except FileNotFoundError:
        return None

def main():
    hardware_info = get_hardware_info()
    generated_license_key = generate_license_key(hardware_info)

    # Пытаемся загрузить ключ шифрования
    encryption_key = load_encryption_key()

    if encryption_key is None:
        print("Ключ шифрования не найден. Программа не может быть запущена.")
        return

    f = Fernet(encryption_key)

    # Пытаемся загрузить существующий лицензионный ключ
    existing_license_key = load_license_key()

    if existing_license_key is None:
        print("Лицензионный ключ не найден. Программа не может быть запущена.")
        return

    # Расшифровываем существующий лицензионный ключ
    try:
        decrypted_license_key = f.decrypt(existing_license_key).decode()
        hardware_info = get_hardware_info()
        generated_license_key = generate_license_key(hardware_info)

        if generated_license_key == decrypted_license_key:
            print("Лицензионный ключ верный. Программа готова к использованию.")
            # Здесь добавляем основной функционал программы
        else:
            print("Лицензионный ключ не соответствует текущему компьютеру. Программа не может быть запущена.")
    except InvalidToken:
        print("Ошибка: неверный ключ шифрования либо зашифрованный текст.")
        return
    
if __name__ == "__main__":
    main()