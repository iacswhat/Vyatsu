import pandas as pd
import numpy as np
import tensorflow as tf
from tensorflow import keras
from sklearn.model_selection import train_test_split, GridSearchCV
from sklearn.preprocessing import OneHotEncoder
from scikeras.wrappers import KerasClassifier
from tensorflow.python.keras.callbacks import EarlyStopping, ModelCheckpoint
from tqdm.keras import TqdmCallback

# Загрузка данных
data = pd.read_csv('datanew2.csv')

# Преобразование категориального столбца "Model" в числовые значения с помощью OneHotEncoder
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
def create_model(optimizer='adam', num_hidden_layers=2, num_neurons=20, activation='relu', dropout_rate=0.2, learning_rate=0.001):
    inputs = tf.keras.Input(shape=(X.shape[1],))
    x = tf.keras.layers.Dense(num_neurons, activation=activation)(inputs)
    x = tf.keras.layers.Dropout(dropout_rate)(x)
    
    for _ in range(num_hidden_layers - 1):
        x = tf.keras.layers.Dense(num_neurons, activation=activation)(x)
        x = tf.keras.layers.Dropout(dropout_rate)(x)
    
    outputs = tf.keras.layers.Dense(7, activation='sigmoid')(x)
    
    model = tf.keras.Model(inputs=inputs, outputs=outputs)
    
    if optimizer == 'adam':
        optimizer = tf.keras.optimizers.Adam(learning_rate=learning_rate)
    elif optimizer == 'rmsprop':
        optimizer = tf.keras.optimizers.RMSprop(learning_rate=learning_rate)
    elif optimizer == 'sgd':
        optimizer = tf.keras.optimizers.SGD(learning_rate=learning_rate)
    
    model.compile(optimizer=optimizer, loss='binary_crossentropy', metrics=['accuracy'])
    return model

# Создание модели KerasClassifier
model = KerasClassifier(model=create_model, verbose=0, epochs=100)

# Задание сетки параметров для подбора
param_grid = {
    'model__num_hidden_layers': [2, 3, 4, 5],
    'model__num_neurons': [20, 30, 40],
    'model__activation': ['relu', 'tanh'],
    'model__dropout_rate': [0.1, 0.2],
    'model__optimizer': ['adam', 'rmsprop', 'sgd'],
    'model__learning_rate': [0.001, 0.01, 0.1]
}

# Создание объекта GridSearchCV
grid_search = GridSearchCV(estimator=model, param_grid=param_grid, cv=3, verbose=1, n_jobs=-1)

# Подгонка объекта GridSearchCV к данным без обратных вызовов
grid_search.fit(X_train, y_train)

# Вывод наилучших параметров
print("Best: %f using %s" % (grid_search.best_score_, grid_search.best_params_))

# Получение лучших параметров и создание модели с этими параметрами
best_params = grid_search.best_params_
best_model = create_model(
    optimizer=best_params['model__optimizer'],
    num_hidden_layers=best_params['model__num_hidden_layers'],
    num_neurons=best_params['model__num_neurons'],
    activation=best_params['model__activation'],
    dropout_rate=best_params['model__dropout_rate'],
    learning_rate=best_params['model__learning_rate']
)

# Определение обратных вызовов для обучения лучшей модели
early_stopping = EarlyStopping(monitor='val_loss', patience=5, restore_best_weights=True)
model_checkpoint = ModelCheckpoint('model.keras', save_best_only=True, monitor='val_loss', mode='min')
tqdm_callback = TqdmCallback(verbose=1)

# Обучение лучшей модели с обратными вызовами
history = best_model.fit(
    X_train, y_train,
    validation_split=0.2,
    epochs=100,
    callbacks=[early_stopping, model_checkpoint, tqdm_callback],
    verbose=0
)

# Оценка модели с лучшими параметрами
loss, accuracy = best_model.evaluate(X_test, y_test)
print(f'Test Accuracy: {accuracy}')
