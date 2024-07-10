import pandas as pd
import numpy as np
import tensorflow as tf
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import OneHotEncoder

# Загрузка данных
data = pd.read_csv('../data/datanew.csv')

# Преобразование категориального столбца "Model" в числовые значения с помощью OneHotEncoding
encoder = OneHotEncoder()
model_encoded = encoder.fit_transform(data[['Model']]).toarray()

# Нормализация числовых данных (возраст)
age = data[['Age']].values
age_normalized = (age - np.mean(age)) / np.std(age)

# Объединение преобразованных данных
X = np.concatenate([age_normalized, model_encoded], axis=1)

# Выходные данные (интересы)
y = data[['Art', 'Sport', 'Book/Films', 'Science', 'Travel', 'Cooking', 'Politics']].values

# Разделение данных на обучающий и тестовый наборы
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

# Определение архитектуры нейронной сети
model = tf.keras.Sequential([
    tf.keras.layers.Dense(100, activation='relu', input_shape=(X.shape[1],)),
    tf.keras.layers.Dense(100, activation='relu'),
    tf.keras.layers.Dense(100, activation='relu'),
    tf.keras.layers.Dense(100, activation='relu'),
    tf.keras.layers.Dense(100, activation='relu'),
    tf.keras.layers.Dense(100, activation='relu'),
    tf.keras.layers.Dense(100, activation='relu'),
    tf.keras.layers.Dense(7, activation='sigmoid')  # 7 выходных нейронов для каждого параметра
])

# Компиляция модели
model.compile(optimizer='adam', loss='binary_crossentropy', metrics=['accuracy'])

# Обучение модели
# history = model.fit(X, y, epochs=100, batch_size=32, validation_data=(X_test, y_test))
history = model.fit(X, y, epochs=1000, batch_size=64)

# Оценка модели
loss, accuracy = model.evaluate(X, y)
print(f'Test Accuracy: {accuracy}')

# Сохранение модели
model.save('../models/modelnew.keras')
