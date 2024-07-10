import pandas as pd
import numpy as np
import tensorflow as tf
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import LabelEncoder
from sklearn.preprocessing import StandardScaler

# Загрузка CSV файла в DataFrame
df = pd.read_csv('data\sorted_data.csv')

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
    tf.keras.layers.Dense(2, activation='relu', input_shape=(2,)),
    tf.keras.layers.Dense(50, activation='relu'),
    tf.keras.layers.Dense(25, activation='relu'),
    tf.keras.layers.Dense(1)
])

# Компиляция модели
model.compile(optimizer=tf.keras.optimizers.Adam(learning_rate=0.5), loss='mean_squared_error', metrics=['accuracy'])

# Обучение модели
history = model.fit(X_train, y_train, epochs=30, batch_size=32, validation_data=(X_test, y_test))

# Оценка модели
loss = model.evaluate(X_test, y_test)
print(f'Loss на тестовом наборе: {loss}')

# Сохранение модели
model.save('model.keras')


# import pandas as pd
# import numpy as np
# import tensorflow as tf
# from sklearn.model_selection import train_test_split
# from sklearn.preprocessing import LabelEncoder
# from sklearn.preprocessing import StandardScaler

# # Загрузка TXT файла в DataFrame
# df = pd.read_table('data\data.txt', sep=',')

# # Преобразование категориальных значений Make и Model в числовые
# label_encoder = LabelEncoder()
# df['Make'] = label_encoder.fit_transform(df['Make'])
# df['Model'] = label_encoder.fit_transform(df['Model'])

# # Разделение данных на обучающий и тестовый наборы
# X = df[['Make', 'Model']].values
# y = df['Age'].values
# X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

# # Нормализация данных
# scaler = StandardScaler()
# X_train = scaler.fit_transform(X_train)
# X_test = scaler.transform(X_test)

# # Создание модели нейронной сети
# model = tf.keras.Sequential([
#     tf.keras.layers.Dense(2, activation='relu', input_shape=(2,)),
#     tf.keras.layers.Dense(2, activation='relu'),
#     tf.keras.layers.Dense(1)
# ])

# # Компиляция модели
# model.compile(optimizer=tf.keras.optimizers.Adam(learning_rate=1.0), loss='mean_squared_error')

# # Обучение модели
# history = model.fit(X_train, y_train, epochs=30, batch_size=32, validation_data=(X_test, y_test))

# # Оценка модели
# loss = model.evaluate(X_test, y_test)
# print(f'Loss на тестовом наборе: {loss}')

# # Сохранение модели
# model.save('model.keras')
