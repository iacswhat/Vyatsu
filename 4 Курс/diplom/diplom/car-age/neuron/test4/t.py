from sklearn.preprocessing import StandardScaler, OneHotEncoder
from sklearn.compose import ColumnTransformer
from sklearn.pipeline import Pipeline
from sklearn.preprocessing import StandardScaler
from sklearn.model_selection import train_test_split
import pandas as pd
import numpy as np
import tensorflow as tf
from sklearn.preprocessing import LabelEncoder

# Загрузка данных
data = pd.read_csv('data\pred.csv')

model = tf.keras.models.load_model('car_age_prediction_model_with_single_scaler.keras')


# Разделение на признаки и целевую переменную
X = data.drop('Age', axis=1)
y = data['Age']

# Создание преобразователя данных для нормализации столбца Year
numeric_features = ['Year']
numeric_transformer = Pipeline(steps=[
    ('scaler', StandardScaler())])

# Создание преобразователя данных для категориальных признаков
categorical_features = ['Make', 'Model', 'BodyType']
categorical_transformer = Pipeline(steps=[
    ('encoder', OneHotEncoder(handle_unknown='ignore'))])

# Объединение преобразователей
preprocessor = ColumnTransformer(
    transformers=[
        ('num', numeric_transformer, numeric_features),
        ('cat', categorical_transformer, categorical_features)])

# Преобразование данных
X_processed = preprocessor.fit_transform(X)

print(X_processed)

predictions = model.predict(X_processed)

# Вывод результатов в исходном формате
print("Predicted Age | Actual Age")
for predicted_age, actual_age in zip(predictions, y):
    print(f"{predicted_age[0]:.2f} | {actual_age:.2f}")


def accuracy(y_true, y_pred, tolerance=3):
    correct_count = 0
    total_count = len(y_true)
    
    for true_age, pred_age in zip(y_true, y_pred):
        if abs(true_age - pred_age) <= tolerance:
            correct_count += 1
    
    accuracy = correct_count / total_count * 100
    return accuracy

# Оценка точности на обучающей выборке
train_accuracy = accuracy(y, predictions.flatten())
print(f'Training Accuracy: {train_accuracy:.2f}%')