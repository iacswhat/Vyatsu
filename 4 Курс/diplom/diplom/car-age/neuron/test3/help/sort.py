import pandas as pd

# Загрузка CSV файла в DataFrame
df = pd.read_csv('..\data\sorted_data.csv')

# Сортировка DataFrame сначала по полю "Make", затем по полю "Model" внутри каждого "Make"
df_sorted = df.sort_values(by=['Make', 'Model'])

# Запись отсортированного DataFrame в файл CSV
df_sorted.to_csv('..\data\sorted_data.csv', index=False)
