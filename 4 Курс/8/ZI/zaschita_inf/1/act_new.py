import hashlib
import json
import os

def get_hardware_info():
    # Собираем информацию о процессоре, памяти и других характеристиках компьютера
    cpu_info = os.getenv('PROCESSOR_IDENTIFIER')
    mem_info = os.getenv('TOTAL_MEMORY')

    hardware_info = {
        "cpu_model": cpu_info,
        "total_memory": mem_info
    }
    return json.dumps(hardware_info)

def generate_license_key(hardware_info):
    # Генерируем лицензионный ключ на основе информации об оборудовании
    hash_object = hashlib.sha256(hardware_info.encode())
    return hash_object.hexdigest()

def save_license_key(license_key):
    # Сохраняем лицензионный ключ в файл
    with open('license_key.txt', 'w') as f:
        f.write(license_key)

def main():
    hardware_info = get_hardware_info()
    license_key = generate_license_key(hardware_info)
    save_license_key(license_key)
    print("Лицензионный ключ успешно создан и сохранен.")

if __name__ == "__main__":
    main()
