
import numpy as np
import pandas as pd
import tensorflow as tf
from sklearn.preprocessing import StandardScaler, OneHotEncoder
from sklearn.compose import ColumnTransformer
from sklearn.metrics import accuracy_score
from sklearn.preprocessing import OneHotEncoder

# Загрузка обученной модели
model = tf.keras.models.load_model("modelnew2.keras")

# Загрузка новых данных для тестирования
def load_new_data(file_path):
    new_data = pd.read_csv(file_path)
    return new_data

# Преобразование новых данных
def preprocess_new_data(new_data):
    # Преобразование категориального столбца "Model" в числовые значения с помощью OneHotEncoding
    encoder = OneHotEncoder()
    model_encoded = encoder.fit_transform(new_data[['Model']]).toarray()
    
    # Нормализация числовых данных (возраст)
    age = new_data[['Age']].values
    age_normalized = (age - np.mean(age)) / np.std(age)

    # Объединение преобразованных данных
    X_new = np.concatenate([age_normalized, model_encoded], axis=1)
    
    # Выходные данные (целевые значения)
    y = new_data[['Art', 'Sport', 'Book/Films', 'Science', 'Travel', 'Cooking', 'Politics']].values
    
    return X_new, y

# Получение предсказаний
def get_predictions(X_new):
    predictions = model.predict(X_new)
    binary_predictions = np.round(predictions)
    return binary_predictions

# Вывод результатов
def print_results(new_data, binary_predictions):
    print("New data:")
    print(new_data)
    print("\nPredictions:")
    np.set_printoptions(threshold=np.inf)
    #print(binary_predictions)
    for i, prediction in enumerate(binary_predictions):
        print(f"Row {i+2}: {prediction}")

if __name__ == "__main__":
    # Загрузка новых данных
    new_data = load_new_data("datanew2.csv")

    # Преобразование новых данных
    X_new, y = preprocess_new_data(new_data)

    # Получение предсказаний
    binary_predictions = get_predictions(X_new)

    # Вывод результатов
    print_results(new_data, binary_predictions)
    
    # Вычисление точности предсказаний
    accuracy = accuracy_score(y, binary_predictions)
    print("Accuracy:", accuracy)
