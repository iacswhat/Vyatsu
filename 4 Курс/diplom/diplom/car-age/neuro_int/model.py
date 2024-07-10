import pandas as pd
import numpy as np
import tensorflow as tf
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import OneHotEncoder
from tensorflow.python.keras.callbacks import EarlyStopping, ModelCheckpoint

# Загрузка данных
data = pd.read_csv('data/datanew.csv')

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
    tf.keras.layers.Dense(10, activation='relu', input_shape=(X.shape[1],)),
    tf.keras.layers.Dropout(0.2),  
    tf.keras.layers.Dense(20, activation='relu'),
    tf.keras.layers.Dropout(0.2),  
    tf.keras.layers.Dense(15, activation='relu'),
    tf.keras.layers.Dropout(0.2),  
    tf.keras.layers.Dense(10, activation='relu'),
    tf.keras.layers.Dropout(0.2),
    tf.keras.layers.Dense(7, activation='sigmoid')
])

# Компиляция модели
model.compile(optimizer='adam', loss='binary_crossentropy', metrics=['accuracy'])

# Определение обратного вызова EarlyStopping
early_stopping = EarlyStopping(monitor='val_loss', patience=5, restore_best_weights=True)

# Определение обратного вызова ModelCheckpoint
model_checkpoint = ModelCheckpoint('model.keras', monitor='val_loss', save_best_only=True)

# Обучение модели с использованием обратных вызовов
history = model.fit(X_train, y_train, epochs=60, batch_size=32, validation_data=(X_test, y_test), callbacks=[early_stopping, model_checkpoint])

# Оценка модели
loss, accuracy = model.evaluate(X_test, y_test)
print(f'Test Accuracy: {accuracy}')

# Загрузка лучшей сохраненной модели
best_model = tf.keras.models.load_model('modelnew.keras')
