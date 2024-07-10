# test_model.py

import numpy as np
import pandas as pd
import tensorflow as tf
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler, OneHotEncoder
from sklearn.compose import ColumnTransformer
from sklearn.metrics import accuracy_score

# Загрузка обученной модели
model = tf.keras.models.load_model("models/trained_model.keras")

# Загрузка новых данных для тестирования
def load_new_data(file_path):
    new_data = pd.read_csv(file_path)
    return new_data

# Преобразование новых данных
def preprocess_new_data(new_data):
    X_new = new_data[['Model', 'Age']].values
    y = new_data[['Art', 'Sport', 'Book/Films', 'Science', 'Travel', 'Cooking', 'Politics']].values  # Выходные данные
    ct = ColumnTransformer(
        [('one_hot_encoder', OneHotEncoder(categories='auto'), [0])],
        remainder='passthrough'
    )
    X_new = ct.fit_transform(X_new)
    X_new = X_new.toarray()
    
    # Фит и трансформация числовых признаков
    scaler = StandardScaler()
    scaler.fit(X_new[:, -1:])
    X_new[:, -1:] = scaler.transform(X_new[:, -1:])
    
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
    new_data = load_new_data("data/data.csv")

    # Преобразование новых данных
    X_new, y = preprocess_new_data(new_data)

    # Получение предсказаний
    binary_predictions = get_predictions(X_new)

    # Вывод результатов
    print_results(new_data, binary_predictions)
    
    # Вычисление точности предсказаний
    accuracy = accuracy_score(y, binary_predictions)
    print("Accuracy:", accuracy)