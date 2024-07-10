import pandas as pd
import numpy as np

# Загрузка CSV файла в DataFrame
df = pd.read_csv('cars_fix.csv')

# Генерация случайных значений для поля Age от 20 до 50
ages = np.random.randint(20, 51, size=len(df))

# Добавление нового столбца Age к DataFrame
df['Age'] = ages

# Сохраняем обновленный DataFrame обратно в CSV файл
df.to_csv('data.csv', index=False)
