import numpy as np
import pandas as pd
import tensorflow as tf
from sklearn.preprocessing import OneHotEncoder
import os

# Загрузка обученной модели
model = tf.keras.models.load_model("model/model.keras")

# Преобразование новых данных
def preprocess_new_data(new_data, full_data):
    # Преобразование категориального столбца "Model" в числовые значения с помощью OneHotEncoding
    encoder = OneHotEncoder()
    encoder.fit(full_data[['Model']])
    model_encoded = encoder.transform(new_data[['Model']]).toarray()
    
    # Нормализация числовых данных (возраст)
    age = new_data[['Age']].values
    age_normalized = (age - np.mean(full_data['Age'])) / np.std(full_data['Age'])

    # Объединение преобразованных данных
    X_new = np.concatenate([age_normalized, model_encoded], axis=1)
    
    return X_new

# Получение предсказаний
def get_predictions(X_new, model_p):
    predictions = model_p.predict(X_new)
    # binary_predictions = np.round(predictions)
    return predictions

# Вывод результатов
def print_results(binary_predictions):
    # print("New data:")
    # print(new_data)
    print("\nPredictions:")
    np.set_printoptions(threshold=np.inf)
    print(binary_predictions)


def main(model, age, model_pred):
     # Загрузка всего датасета
    full_data = pd.read_csv('data/datanew.csv')

    # Пример новых данных для тестирования
    new_data = pd.DataFrame({'Model': [model], 'Age': [int(age)]})

    # Преобразование новых данных
    X_new = preprocess_new_data(new_data, full_data)

    if not os.path.isfile(model_pred):
        raise FileNotFoundError(f"Файл {model_pred} не найден")

    # Проверяем расширение файла
    if not model_pred.endswith('.keras'):
        raise ValueError("Неправильный формат файла. Ожидался файл с расширением .keras")

    model_p = tf.keras.models.load_model(model_pred)

    # Получение предсказаний только для одного примера
    binary_predictions = get_predictions(X_new, model_p)

    art_prediction = binary_predictions[0][0]
    sport_prediction = binary_predictions[0][1]
    book_films_prediction = binary_predictions[0][2]
    science_prediction = binary_predictions[0][3]
    travel_prediction = binary_predictions[0][4]
    cooking_prediction = binary_predictions[0][5]
    politics_prediction = binary_predictions[0][6]

    # Запись в массив
    predictions_array = [art_prediction, sport_prediction, book_films_prediction, science_prediction, travel_prediction, cooking_prediction, politics_prediction]


    return predictions_array
