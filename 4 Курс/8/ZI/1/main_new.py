import hashlib
import json
import os
import numpy as np


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


def load_license_key():
    # Загружаем лицензионный ключ из файла
    try:
        with open('license_key.txt', 'r') as f:
            return f.read().strip()
    except FileNotFoundError:
        return None

def main():

    hardware_info = get_hardware_info()
    license_key = generate_license_key(hardware_info)

    # Пытаемся загрузить существующий лицензионный ключ
    saved_license_key = load_license_key()

    if saved_license_key is None:
        # Если лицензионный ключ не найден, программа завершает работу
        print("Лицензионный ключ не найден. Программа не может быть запущена.")
        return
    elif saved_license_key == license_key:
        # Если найденный лицензионный ключ совпадает с текущим, программа продолжает работу
        print("Лицензионный ключ верный. Программа готова к использованию.")

        # Здесь добавляем основной функционал программы
        matrix1 = np.array([[1, 2, 3], [4, 5, 6], [7, 8, 9]])
        matrix2 = np.array([[9, 8, 7], [6, 5, 4], [3, 2, 1]])
        result = np.dot(matrix1, matrix2)
        print("Результат умножения матриц:")
        print(result)
    else:
        # Если найденный лицензионный ключ не совпадает с текущим, программа завершает работу
        print("Лицензионный ключ неверный. Программа не может быть запущена.")
        return

if __name__ == "__main__":
    main()
