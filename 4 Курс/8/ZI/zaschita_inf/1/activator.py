import hashlib
import json
import uuid
from cryptography.fernet import Fernet
import os

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

def encrypt_license_key(license_key, key):
    # Шифруем лицензионный ключ с использованием заданного ключа
    f = Fernet(key)
    return f.encrypt(license_key.encode())

def save_license_key(encrypted_license_key):
    # Сохраняем зашифрованный лицензионный ключ в файл
    with open('license_key.enc', 'wb') as f:
        f.write(encrypted_license_key)

def save_encryption_key(key):
    # Сохраняем ключ шифрования в файл
    with open('encryption_key.key', 'wb') as f:
        f.write(key)

def main():
    hardware_info = get_hardware_info()
    license_key = generate_license_key(hardware_info)
    key = Fernet.generate_key()
    save_encryption_key(key)
    encrypted_license_key = encrypt_license_key(license_key, key)
    save_license_key(encrypted_license_key)
    print("Лицензионный ключ успешно создан и сохранен.")

if __name__ == "__main__":
    main()
