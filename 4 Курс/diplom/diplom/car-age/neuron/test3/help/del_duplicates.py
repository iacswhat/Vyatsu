import pandas as pd

# Загрузка CSV файла в DataFrame
df = pd.read_csv('cars.csv')

# Удаление дубликатов
df.drop_duplicates(inplace=True)

# Сохраняем обновленный DataFrame обратно в CSV файл
df.to_csv('cars_fix.csv', index=False)
