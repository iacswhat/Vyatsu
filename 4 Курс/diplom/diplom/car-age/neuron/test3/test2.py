import pandas as pd
import numpy as np
import tensorflow as tf
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import LabelEncoder, StandardScaler
from sklearn.metrics import mean_absolute_error, mean_squared_error, r2_score

# Загрузка CSV файла в DataFrame
df = pd.read_csv('data\data_body.csv')

# Преобразование категориальных значений Make, Model и BodyType в числовые
label_encoder = LabelEncoder()
df['Make'] = label_encoder.fit_transform(df['Make'])
df['Model'] = label_encoder.fit_transform(df['Model'])
df['BodyType'] = label_encoder.fit_transform(df['BodyType'])

# Разделение данных на признаки (X) и целевую переменную (y)
X = df[['Make', 'Model', 'BodyType']].values
y = df['Age'].values

# Разделение данных на обучающий и тестовый наборы
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

# Нормализация данных
scaler = StandardScaler()
X_train = scaler.fit_transform(X_train)
X_test = scaler.transform(X_test)

# Создание модели нейронной сети
model = tf.keras.Sequential([
    tf.keras.layers.Dense(128, activation='relu', input_shape=(3,)),
    tf.keras.layers.Dense(128, activation='relu'),
    tf.keras.layers.Dense(128, activation='relu'),
    tf.keras.layers.Dense(128, activation='relu'),
    tf.keras.layers.Dense(128, activation='relu'),
    tf.keras.layers.Dense(1)
])

# Компиляция модели
model.compile(optimizer='adam', loss='mean_squared_error', metrics=['mae', 'mse'])

# Обучение модели
history = model.fit(X_train, y_train, epochs=100, batch_size=8, validation_data=(X_test, y_test), verbose=1)

# Прогнозирование на тестовом наборе
y_pred = model.predict(X_test)

# Оценка модели
loss, mae, mse = model.evaluate(X_test, y_test)
r2 = r2_score(y_test, y_pred)
print(f'Loss на тестовом наборе: {loss}')
print(f'Mean Absolute Error (MAE): {mae}')
print(f'Mean Squared Error (MSE): {mse}')
print("R-squared (R^2):", r2)

# Сохранение модели
model.save('model_with_body_types.keras')
