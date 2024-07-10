import numpy as np
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import LabelEncoder
from keras.models import Sequential
from keras.layers import Dense

# Загрузка данных из файла
data = []
with open('data_cleaned_fix.txt', 'r', encoding='utf-8') as file:
    for line in file:
        line = line.strip().split(',')
        line = [value.strip() for value in line]  # удалить лишние пробелы из каждого элемента
        data.append(line)

# Разделение данных на признаки и целевую переменную
X = np.array([[line[0], line[1]] for line in data], dtype=object)
y = np.array([float(line[2]) for line in data])

# Кодирование категориальных признаков
label_encoders = [LabelEncoder() for _ in range(X.shape[1])]
for i in range(X.shape[1]):
    X[:, i] = label_encoders[i].fit_transform(X[:, i])

# Разделение данных на обучающую и тестовую выборки
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

# Создание нейронной сети
model = Sequential()
model.add(Dense(64, input_dim=X.shape[1], activation='relu'))
model.add(Dense(64, activation='relu'))
model.add(Dense(64, activation='relu'))
model.add(Dense(1, activation='linear'))

# Компиляция модели
model.compile(loss='mean_squared_error', optimizer='adam', metrics=['mae'])

# Обучение модели
X_train = X_train.astype(float)
X_test = X_test.astype(float)
model.fit(X_train, y_train, epochs=50, batch_size=8, validation_split=0.1)

loss, mae = model.evaluate(X_test, y_test)
print("Средняя абсолютная ошибка (MAE) на тестовой выборке:", mae)

# Сохранение модели
model.save('car_age_prediction_model.h5')
