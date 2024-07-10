import pandas as pd
import numpy as np

# Загрузка CSV файла в DataFrame
df = pd.read_csv('..\data\cars_raw.csv')

# Оставляем только нужные поля
df = df[['Year','Make', 'Model']]

# Сохраняем обновленный DataFrame обратно в CSV файл
df.to_csv('cars.csv', index=False)


# Загрузка CSV файла в DataFrame
df = pd.read_csv('cars.csv')

# Удаление дубликатов
df.drop_duplicates(inplace=True)

# Сохраняем обновленный DataFrame обратно в CSV файл
df.to_csv('cars_fix.csv', index=False)


# Загрузка CSV файла в DataFrame
df = pd.read_csv('cars_fix.csv')

# Генерация случайных значений для поля Age от 20 до 50
ages = np.random.randint(20, 61, size=len(df))

# Добавление нового столбца Age к DataFrame
df['Age'] = ages

# Сохраняем обновленный DataFrame обратно в CSV файл
df.to_csv('data.csv', index=False)


# Load the data
data = pd.read_csv('data.csv')

# List of body types for random selection
body_types = ['sedan', 'hatchback', 'wagon', 'coupe', 'crossover', 'SUV', 'minivan', 'pickup']

# Generate random body types
random_body_types = np.random.choice(body_types, size=len(data))

# Insert random body types between "Model" and "Age" columns
data.insert(loc=data.columns.get_loc('Age'), column='BodyType', value=random_body_types)

# Save the data to a new CSV file
data.to_csv('data_body.csv', index=False)


# Загрузка CSV файла в DataFrame
df = pd.read_csv('data_body.csv')

# Сортировка DataFrame сначала по полю "Make", затем по полю "Model" внутри каждого "Make"
df_sorted = df.sort_values(by=['Year','Make', 'Model'])

# Запись отсортированного DataFrame в файл CSV
df_sorted.to_csv('..\data\data_year\data.csv', index=False)
