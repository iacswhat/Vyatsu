import pandas as pd
import numpy as np
import tensorflow as tf
from tensorflow import keras
from sklearn.model_selection import train_test_split, GridSearchCV
from sklearn.preprocessing import OneHotEncoder
from scikeras.wrappers import KerasClassifier
from tensorflow.python.keras.callbacks import EarlyStopping

# Загрузка данных
data = pd.read_csv('datanew2.csv')

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

# Функция для создания модели с указанными параметрами
def create_model(optimizer='adam', num_hidden_layers=2, num_neurons=20, activation='relu', dropout_rate=0.2, learning_rate=0.001, epochs=10):
    model = tf.keras.Sequential()
    model.add(tf.keras.layers.Dense(num_neurons, activation=activation, input_shape=(X.shape[1],)))
    model.add(tf.keras.layers.Dropout(dropout_rate))
    
    for _ in range(num_hidden_layers - 1):
        model.add(tf.keras.layers.Dense(num_neurons, activation=activation))
        model.add(tf.keras.layers.Dropout(dropout_rate))
    
    model.add(tf.keras.layers.Dense(7, activation='sigmoid'))
    
    if optimizer == 'adam':
        optimizer = tf.keras.optimizers.Adam(learning_rate=learning_rate)
    elif optimizer == 'rmsprop':
        optimizer = tf.keras.optimizers.RMSprop(learning_rate=learning_rate)
    elif optimizer == 'sgd':
        optimizer = tf.keras.optimizers.SGD(learning_rate=learning_rate)
    
    model.compile(optimizer=optimizer, loss='binary_crossentropy', metrics=['accuracy'])
    return model

# Создание модели KerasClassifier
model = KerasClassifier(build_fn=create_model, verbose=0)

# Задание сетки параметров для подбора
param_grid = {
    'num_hidden_layers': [2, 3, 4, 5],
    'num_neurons': [20, 30, 40],
    'activation': ['relu', 'tanh'],
    'dropout_rate': [0.1, 0.2],
    'optimizer': ['adam', 'rmsprop', 'sgd'],
    'learning_rate': [0.001, 0.01, 0.1],
    'epochs': [10, 20, 30, 40, 50, 100, 150]
}

# Создание объекта GridSearchCV
grid_search = GridSearchCV(estimator=model, param_grid=param_grid, cv=3, verbose=1)

# Определение обратного вызова EarlyStopping
early_stopping = EarlyStopping(monitor='val_loss', patience=5, restore_best_weights=True)

# Подгонка объекта GridSearchCV к данным с использованием обратного вызова EarlyStopping
grid_result = grid_search.fit(X_train, y_train, callbacks=[early_stopping])

# Вывод наилучших параметров
print("Best: %f using %s" % (grid_result.best_score_, grid_result.best_params_))

# Оценка модели с лучшими параметрами
best_model = grid_search.best_estimator_
loss, accuracy = best_model.evaluate(X_test, y_test)
print(f'Test Accuracy: {accuracy}')
