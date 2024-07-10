import pandas as pd
import numpy as np
import tensorflow as tf
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import LabelEncoder
from sklearn.preprocessing import StandardScaler

# Загрузка CSV файла в DataFrame
df = pd.read_csv('data\data.csv')

# Преобразование категориальных значений Make и Model в числовые
label_encoder = LabelEncoder()
df['Make'] = label_encoder.fit_transform(df['Make'])
df['Model'] = label_encoder.fit_transform(df['Model'])

# Разделение данных на обучающий и тестовый наборы
X = df[['Make', 'Model']].values
y = df['Age'].values

# Нормализация данных
scaler = StandardScaler()
X = scaler.fit_transform(X)

# Разделение данных на обучающий и тестовый наборы
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

# Преобразование данных в последовательности
X_train_sequence = []
y_train_sequence = []
X_test_sequence = []
y_test_sequence = []

sequence_length = 3  # Длина последовательности

for i in range(len(X_train) - sequence_length):
    X_train_sequence.append(X_train[i:i+sequence_length])
    y_train_sequence.append(y_train[i+sequence_length])

for i in range(len(X_test) - sequence_length):
    X_test_sequence.append(X_test[i:i+sequence_length])
    y_test_sequence.append(y_test[i+sequence_length])

X_train_sequence = np.array(X_train_sequence)
y_train_sequence = np.array(y_train_sequence)
X_test_sequence = np.array(X_test_sequence)
y_test_sequence = np.array(y_test_sequence)

# Создание и обучение RNN
model = tf.keras.Sequential([
    tf.keras.layers.LSTM(128, input_shape=(sequence_length, 2)),
    tf.keras.layers.Dense(1)
])

model.compile(optimizer='adam', loss='mean_squared_error')
model.fit(X_train_sequence, y_train_sequence, epochs=50, batch_size=32, validation_data=(X_test_sequence, y_test_sequence))

# Оценка модели
loss = model.evaluate(X_test_sequence, y_test_sequence)
print(f'Loss на тестовом наборе: {loss}')

# Сохранение модели
model.save('model1.keras')
