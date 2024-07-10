import pandas as pd

# Загрузка CSV файла в DataFrame
df = pd.read_csv('..\data\data.csv')

# Объединение полей Make и Model в новое поле Car
df['Car'] = df['Make'] + ' ' + df['Model']

# Создание нового DataFrame с объединенными полями
new_df = df[['Car', 'Age']]

# Запись нового DataFrame в файл CSV
new_df.to_csv('..\data\data_new.csv', index=False)
