import csv
import random

# # # Открытие файла CSV для чтения
# with open('../data/cars_raw.csv', 'r') as file:
#     reader = csv.DictReader(file)
#     # Создание множества для хранения уникальных значений Make и Model
#     unique_make_model = set()
#     # Чтение каждой строки файла и добавление объединенного значения Make и Model в множество
#     for row in reader:
#         combined_make_model = row['Make'] + ' ' + row['Model']
#         unique_make_model.add(combined_make_model)

# # Создание нового файла CSV для записи результатов
# with open('../data/data_new.csv', 'w', newline='') as file:
#     writer = csv.writer(file)
#     # Запись заголовков в новый файл
#     writer.writerow(['Model', 'Age', 'Art', 'Sport', 'Book/Films', 'Science', 'Travel', 'Cooking', 'Politics'])
#     # Запись уникальных значений Make и Model в новый файл с добавленными полями
#     for make_model in unique_make_model:
#         age = random.randint(25, 50)
#         coefficients = [random.randint(0, 1) for _ in range(7)]
#         row = [make_model, age] + coefficients
#         writer.writerow(row)


import pandas as pd
import random

# Загрузка CSV-файла
df = pd.read_csv('../data/data_new.csv')

# Добавление столбца с возрастом от 18 до 60
df['age'] = [random.randint(18, 60) for _ in range(len(df))]

# Добавление 7 случайных коэффициентов
for i in range(7):
    df[f'Коэффициент_{i+1}'] = [random.choice([0, 1]) for _ in range(len(df))]

# Сохранение измененного датафрейма в новый CSV-файл
df.to_csv('../data/datanew.csv', index=False)
