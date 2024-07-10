# Открываем файл для чтения
with open('data\input.txt', 'r') as file:
    # Читаем все строки из файла
    lines = file.readlines()

# Открываем файл для записи
with open('data\data_cleaned_fix.txt', 'w') as file:
    # Проходим по каждой строке
    for line in lines:
        # Удаляем точку в конце строки, если она есть
        if line.endswith('.\n'):
            line = line[:-2] + '\n'  # Удаляем последние два символа (точку и символ новой строки)
        # Записываем строку в файлS
        file.write(line)
