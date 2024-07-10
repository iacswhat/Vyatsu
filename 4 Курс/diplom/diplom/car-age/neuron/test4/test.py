# Загрузка CSV файла в DataFrame
import pandas as pd
import numpy as np

df = pd.read_csv('data\data.csv')

# Оставляем только нужные поля
df = df[['Year','Make', 'Model', 'Age']]

# Сохраняем обновленный DataFrame обратно в CSV файл
df.to_csv('cars_raw.csv', index=False)
