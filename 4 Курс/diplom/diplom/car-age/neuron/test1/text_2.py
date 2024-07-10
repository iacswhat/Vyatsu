import tensorflow as tf
from tensorflow import keras
import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import OneHotEncoder

# Загрузите данные
data = pd.read_csv('..\data\data_cleaned_fix.txt', names=['model', 'body', 'age'], delimiter=', ', encoding='utf-8')

# Преобразуйте модели машин в числовые значения
encoder = OneHotEncoder()
onehot_data = encoder.fit_transform(data[['model', 'body']])

# Создайте имена столбцов
feature_names = encoder.get_feature_names_out(['model', 'body'])

# Создайте DataFrame из закодированных данных
onehot_data_df = pd.DataFrame(onehot_data.toarray(), columns=feature_names)

# Объедините преобразованные данные с исходными данными
data_encoded = pd.concat([data.drop(['model', 'body'], axis=1), onehot_data_df], axis=1)

# Разделите данные на обучающую и тестовую выборки
train_data, test_data, train_labels, test_labels = train_test_split(data_encoded.drop(['age'], axis=1), data_encoded['age'], test_size=0.2)

# Создайте модель
model = keras.Sequential([
    keras.layers.Dense(64, activation='relu', input_shape=[train_data.shape[1]]),
    keras.layers.Dense(64, activation='relu'),
    keras.layers.Dense(64, activation='relu'),
    keras.layers.Dense(1)
])

# Скомпилируйте модель
model.compile(loss='mean_squared_error', optimizer='adam')

# Обучите модель
model.fit(train_data, train_labels, epochs=100, validation_split=0.2)

# Оцените модель
loss = model.evaluate(test_data, test_labels)
print(f"Mean Squared Error: {loss}")

# Сохранение модели
model.save('model2.h5')
