
import tensorflow as tf
from tensorflow import keras
import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import OneHotEncoder

# Загрузите данные
data = pd.read_csv('data\data_cleaned_fix.txt', names=['model', 'body', 'age'], delimiter=', ')

# Преобразуйте модели машин в числовые значения
encoder = OneHotEncoder()
onehot_model = encoder.fit_transform(data['model'].values.reshape(-1, 1))
onehot_body = encoder.fit_transform(data['body'].values.reshape(-1, 1))

# Создайте имена столбцов
feature_name_model = ['model_' + str(i) for i in range(onehot_model.shape[1])]
feature_name_body = ['body_' + str(i) for i in range(onehot_body.shape[1])]

# Создайте DataFrame
onehot_model_df = pd.DataFrame(onehot_model.toarray(), columns=feature_name_model)
onehot_body_df = pd.DataFrame(onehot_body.toarray(), columns=feature_name_body)

# Объедините преобразованные данные с исходными данными
data = pd.concat([data, onehot_model_df, onehot_body_df], axis=1).drop(['model', 'body'], axis=1)

# Разделите данные на обучающую и тестовую выборки
train_data, test_data, train_labels, test_labels = train_test_split(data.drop(['age'], axis=1), data['age'], test_size=0.2)

# Создайте модель
model = keras.Sequential([
    keras.layers.Dense(64, activation='relu', input_shape=[len(train_data.keys())]),
    keras.layers.Dense(64, activation='relu'),
    keras.layers.Dense(64, activation='relu'),
    keras.layers.Dense(1)
])

# Скомпилируйте модель
model.compile(loss='mean_squared_error', optimizer='adam')

# Обучите модель
model.fit(train_data, train_labels, epochs=200, validation_split=0.2)

# Оцените модель
loss = model.evaluate(test_data, test_labels)
print(f"Mean Squared Error: {loss}")

# Сохранение модели
model.save('model.h5')