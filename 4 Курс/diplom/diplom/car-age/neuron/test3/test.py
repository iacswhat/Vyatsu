import pandas as pd
import numpy as np
import tensorflow as tf
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import LabelEncoder
from sklearn.preprocessing import StandardScaler
from sklearn.metrics import mean_absolute_error, mean_squared_error, r2_score

# Загрузка CSV файла в DataFrame
df = pd.read_csv('data\data.csv')

# Преобразование категориальных значений Make и Model в числовые
label_encoder = LabelEncoder()
df['Make'] = label_encoder.fit_transform(df['Make'])
df['Model'] = label_encoder.fit_transform(df['Model'])

# Разделение данных на обучающий и тестовый наборы
X = df[['Make', 'Model']].values
y = df['Age'].values
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

# Нормализация данных
scaler = StandardScaler()
X_train = scaler.fit_transform(X_train)
X_test = scaler.transform(X_test)

# Создание модели нейронной сети
model = tf.keras.Sequential([
    tf.keras.layers.Dense(128, activation='relu', input_shape=(2,)),
    tf.keras.layers.Dense(128, activation='relu'),
    tf.keras.layers.Dense(128, activation='relu'),
    tf.keras.layers.Dense(128, activation='relu'),
    tf.keras.layers.Dense(128, activation='relu'),
    tf.keras.layers.Dense(1)
])

# Компиляция модели
model.compile(optimizer='adam', loss='mean_squared_error', metrics=['accuracy'])

# Обучение модели с большим количеством эпох и без валидационного набора данных
history = model.fit(X_train, y_train, epochs=50, batch_size=8, validation_data=(X_test, y_test), verbose=1)

y_pred = model.predict(X_test)

# Оценка модели
loss = model.evaluate(X_test, y_test)
r2 = r2_score(y_test, y_pred)
print(f'Loss на тестовом наборе: {loss}')
print("R-squared (R^2):", r2)

# Сохранение модели
model.save('overfit_model.keras')
