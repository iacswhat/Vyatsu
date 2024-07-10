import csv

# Открываем текстовый файл для чтения и CSV файл для записи
with open('data\data_cleaned.txt', 'r', encoding='utf-8') as txt_file, open('data\data1.csv', 'w', newline='') as csv_file:
    # Создаем объект writer для записи данных в CSV файл
    writer = csv.writer(csv_file)
    
    # Пишем заголовки столбцов в CSV файл
    writer.writerow(['Марка', 'Тип кузова', 'Возраст'])
    
    # Читаем каждую строку из текстового файла
    for line in txt_file:
        # Разделяем строку на отдельные значения
        values = line.strip().split(', ')
        
        # Пишем значения в CSV файл
        writer.writerow(values)
