import numpy as np
import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import LabelEncoder, StandardScaler
from tensorflow import keras
from keras.layers import Dense
from keras.models import Sequential, load_model

# Загрузка данных из CSV файла
data = pd.read_csv('data\data_new.csv')

# Преобразование текстовых меток в числовые значения
label_encoder = LabelEncoder()
data['Марка'] = label_encoder.fit_transform(data['Марка'])
data['Тип кузова'] = label_encoder.fit_transform(data['Тип кузова'])

# Разделение данных на признаки (X) и целевую переменную (y)
X = data[['Марка', 'Тип кузова']]
y = data['Возраст']

# Нормализация признаков
scaler = StandardScaler()
X_scaled = scaler.fit_transform(X)

# Разделение данных на обучающий и тестовый наборы
X_train, X_test, y_train, y_test = train_test_split(X_scaled, y, test_size=0.2, random_state=42)

# Создание модели нейронной сети
model = Sequential([
    Dense(64, activation='relu', input_shape=(X_train.shape[1],)),
    Dense(64, activation='relu'),
    Dense(1)
])

# Компиляция модели
model.compile(optimizer='adam', loss='mse', metrics=['mae'])

# Обучение модели
model.fit(X_train, y_train, epochs=50, batch_size=32, validation_data=(X_test, y_test))
