import numpy as np
from sklearn.preprocessing import LabelEncoder
from keras.models import load_model


# Создание label_encoders
label_encoders = [LabelEncoder() for _ in range(2)]

# Загрузка данных из файла
data = []
with open('data_cleaned_fix.txt', 'r', encoding='utf-8') as file:
    for line in file:
        line = line.strip().split(',')
        line = [value.strip() for value in line]  # удалить лишние пробелы из каждого элемента
        data.append(line)

# Преобразование данных в numpy array
data = np.array(data)

# Обучение LabelEncoder на данных
for i in range(2):
    label_encoders[i].fit(data[:, i])

# Загрузка сохраненной модели
loaded_model = load_model('car_age_prediction_model.h5')

# Пример использования модели для предсказания
car_model = 'Nissan Rogue'
car_body_type = 'кроссовер'
example_input = np.array([[label_encoders[0].transform([car_model])[0], 
                           label_encoders[1].transform([car_body_type])[0]]]).astype(float)
predicted_age = loaded_model.predict(example_input)
print("Предсказанный возраст владельца:", predicted_age[0][0])
