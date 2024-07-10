import matplotlib.pyplot as plt

# Результаты оценки
correctly_recognized = 85  # Количество правильно распознанных номеров
total_images = 100  # Общее количество изображений в тестовом наборе
accuracy = correctly_recognized / total_images * 100  # Точность в процентах

# Построение диаграммы
labels = ['Правильно распознано', 'Неправильно распознано']
sizes = [correctly_recognized, total_images - correctly_recognized]
colors = ['lightgreen', 'lightcoral']
explode = (0.1, 0)  # Выделение сегмента "Правильно распознано"

plt.figure(figsize=(6, 6))
plt.pie(sizes, explode=explode, labels=labels, colors=colors, autopct='%1.1f%%', shadow=True, startangle=140)
plt.title('Точность распознавания номеров')
plt.axis('equal')  # Equal aspect ratio ensures that pie is drawn as a circle.
plt.show()

print(f'Точность распознавания: {accuracy:.2f}%')
