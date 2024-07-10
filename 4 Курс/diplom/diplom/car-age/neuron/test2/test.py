data = []
with open('data_cleaned_fix.txt', 'r', encoding='utf-8') as file:
    for line in file:
        line = line.strip().split(',')
        line = [value.strip() for value in line]  # удалить лишние пробелы из каждого элемента
        print(line)
        data.append(line)