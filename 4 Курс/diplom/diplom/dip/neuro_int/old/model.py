import numpy as np
import pandas as pd
import tensorflow as tf
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler, OneHotEncoder
from sklearn.compose import ColumnTransformer

# Загрузка данных
data = pd.read_csv("data/data.csv")

# Разделение на входные и выходные данные
X = data[['Model', 'Age']].values  # Входные данные
y = data[['Art', 'Sport', 'Book/Films', 'Science', 'Travel', 'Cooking', 'Politics']].values  # Выходные данные

# Преобразование категориального признака "Model" с помощью One-Hot Encoding
ct = ColumnTransformer(
    [('one_hot_encoder', OneHotEncoder(categories='auto'), [0])],    # The column numbers to be transformed (here is [0] but can be [0, 1, 3])
    remainder='passthrough'  # Leave the rest of the columns untouched
)
X = ct.fit_transform(X)

# Преобразование sparse matrix в dense array
X = X.toarray()

# Масштабирование числовых входных данных
scaler = StandardScaler()
X[:, -1:] = scaler.fit_transform(X[:, -1:])

# Разделение на обучающую и тестовую выборки
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

# Определение архитектуры модели
model = tf.keras.models.Sequential([
    tf.keras.layers.Dense(128, activation='relu', input_shape=(X_train.shape[1],)),
    tf.keras.layers.Dense(64, activation='relu'),
    tf.keras.layers.Dense(y_train.shape[1], activation='sigmoid')
    # tf.keras.layers.Dense(64, activation='sigmoid'),
    # tf.keras.layers.Dense(32, activation='sigmoid'),
    # tf.keras.layers.Dense(64, activation='sigmoid'),
    # tf.keras.layers.Dense(64, activation='sigmoid'),
    # tf.keras.layers.Dense(32, activation='sigmoid'),
    # tf.keras.layers.Dense(64, activation='sigmoid'),
    # tf.keras.layers.Dense(7, activation='sigmoid')
])

# Компиляция модели
model.compile(optimizer='adam', loss='binary_crossentropy', metrics=['accuracy'])

# Обучение модели
history = model.fit(X_train, y_train, epochs=100, batch_size=64, validation_split=0.2)

# Оценка производительности модели на тестовой выборке
loss, accuracy = model.evaluate(X_train, y_train)
print("Test Loss:", loss)
print("Test Accuracy:", accuracy)

model.save("trained_model1.keras")