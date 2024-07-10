from sklearn.preprocessing import StandardScaler
from sklearn.model_selection import train_test_split
import pandas as pd
import numpy as np
import tensorflow as tf
from sklearn.preprocessing import LabelEncoder

# Загрузка данных
data = pd.read_csv('data\data.csv')

# Предварительная обработка данных
label_encoders = {}
for column in ['Make', 'Model', 'BodyType']:
    label_encoders[column] = LabelEncoder()
    data[column] = label_encoders[column].fit_transform(data[column])

# Объединение всех признаков в один DataFrame
X = data.drop('Age', axis=1)
y = data['Age']

# Создание одного объекта StandardScaler для нормализации всех признаков, кроме целевой переменной
scaler = StandardScaler()
X_scaled = scaler.fit_transform(X)

# Разделение на обучающий и тестовый наборы
X_train, X_test, y_train, y_test = train_test_split(X_scaled, y, test_size=0.2, random_state=42)

# Создание модели нейронной сети
model = tf.keras.Sequential([
    tf.keras.layers.Dense(64, activation='relu', input_shape=(X_train.shape[1],)),
    tf.keras.layers.Dropout(0.2),
    tf.keras.layers.Dense(64, activation='relu'),
    tf.keras.layers.Dropout(0.2),
    tf.keras.layers.Dense(1)
])

# Компиляция модели
model.compile(optimizer='adam', loss='mean_squared_error', metrics=['mae'])

# Обучение модели
history = model.fit(X_train, y_train, epochs=150, batch_size=32, validation_split=0.2)

# Оценка модели на тестовых данных
loss, mae = model.evaluate(X_test, y_test)
print(f'Test Mean Absolute Error: {mae}')

# Предсказание возраста для обучающей выборки
predictions = model.predict(X_train)

# Вывод результатов в исходном формате
print("Predicted Age | Actual Age")
for predicted_age, actual_age in zip(predictions, y_train):
    print(f"{predicted_age[0]:.2f} | {actual_age:.2f}")

def accuracy(y_true, y_pred, tolerance=3):
    """
    Функция для оценки точности по предсказанному и фактическому возрасту.
    
    Параметры:
        y_true (array): Фактический возраст.
        y_pred (array): Предсказанный возраст.
        tolerance (int): Допустимое отклонение между фактическим и предсказанным возрастом.
    
    Возвращает:
        accuracy (float): Точность предсказания в процентах.
    """
    correct_count = 0
    total_count = len(y_true)
    
    for true_age, pred_age in zip(y_true, y_pred):
        if abs(true_age - pred_age) <= tolerance:
            correct_count += 1
    
    accuracy = correct_count / total_count * 100
    return accuracy

# Оценка точности на обучающей выборке
train_accuracy = accuracy(y_train, predictions.flatten())
print(f'Training Accuracy: {train_accuracy:.2f}%')


# Сохранение модели
model.save('car_age_prediction_model_with_single_scaler.keras')
