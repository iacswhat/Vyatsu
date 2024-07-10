# Чтение данных из файла
with open('data_cleaned_fix.txt', 'r', encoding='utf-8') as file:
    lines = file.readlines()

# Удаление повторяющихся строк
lines = list(set(lines))

# Запись обновленных данных обратно в файл
with open('datanew.txt', 'w', encoding='utf-8') as file:
    file.writelines(lines)
