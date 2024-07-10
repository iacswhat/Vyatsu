
# import pandas as pd
# import numpy as np
# from sklearn.preprocessing import LabelEncoder
# from sklearn.preprocessing import StandardScaler
# import tensorflow as tf

# # Загрузка CSV файла с новыми данными
# new_data = pd.read_csv('data\data1.csv')

# # Преобразование категориальных значений Make и Model в числовые
# label_encoder = LabelEncoder()
# new_data['Make'] = label_encoder.fit_transform(new_data['Make'])
# new_data['Model'] = label_encoder.fit_transform(new_data['Model'])

# # Нормализация данных
# scaler = StandardScaler()
# new_data_scaled = scaler.fit_transform(new_data[['Make', 'Model']].values)

# # Загрузка обученной модели
# model = tf.keras.models.load_model('model.keras')

# # Предсказание возраста на новых данных
# predicted_age = model.predict(new_data_scaled)

# # Вывод предсказанных значений
# for i in range(len(predicted_age)):
#     print(f'Предсказанный возраст для данных {new_data_scaled[i]}: {predicted_age[i][0]}')


import pandas as pd
import numpy as np
from sklearn.preprocessing import LabelEncoder, StandardScaler
import tensorflow as tf

# Загрузка CSV файла с новыми данными
new_data = pd.read_csv('data\data_body.csv')

# Преобразование категориальных значений Make, Model и BodyType в числовые
label_encoder = LabelEncoder()
new_data['Make'] = label_encoder.fit_transform(new_data['Make'])
new_data['Model'] = label_encoder.fit_transform(new_data['Model'])
new_data['BodyType'] = label_encoder.fit_transform(new_data['BodyType'])

# Нормализация данных
scaler = StandardScaler()
new_data_scaled = scaler.fit_transform(new_data[['Make', 'Model', 'BodyType']].values)

# Загрузка обученной модели
model = tf.keras.models.load_model('model_with_body_types.keras')

# Предсказание возраста на новых данных
predicted_age = model.predict(new_data_scaled)

# Вывод предсказанных значений
for i in range(len(predicted_age)):
    print(f'Предсказанный возраст для данных {new_data_scaled[i]}: {predicted_age[i][0]}')

