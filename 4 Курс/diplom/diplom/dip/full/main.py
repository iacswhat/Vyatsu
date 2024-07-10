import sys
import time

import test_single
import autoteka
import test_blank

import itertools
import tensorflow as tf
from skimage.feature import canny
from skimage.transform import hough_line, hough_line_peaks
from skimage.transform import rotate
from skimage.color import rgb2gray
import pytesseract as tess
tess.pytesseract.tesseract_cmd = r'Tesseract-OCR\tesseract.exe'
from PyQt6 import uic
import os
from datetime import timedelta
from pathlib import Path
import matplotlib.pyplot as plt
import cv2
import numpy as np
import re
from moviepy.editor import VideoFileClip
from PyQt6.QtGui import QPixmap

import matplotlib.gridspec as gridspec
import cv2

from PyQt6.QtWidgets import ( 
    QApplication, 
    QWidget, 
    QPushButton, 
    QLabel, 
    QVBoxLayout, 
    QTextEdit, 
    QTableWidget, 
    QTableWidgetItem,
    QTabWidget,
    QMainWindow,
    QFileDialog,
    QMessageBox
)
from PyQt6 import QtCore

SAVING_FRAMES_PER_SECOND = 1


list_int = ["Искусство", "Спорт", "Книги/Фильмы", "Наука", "Путешествия", "Кулинария", "Политика"]

video_file = ''
image_file = ''
result = ''
arr=[]

class MainWindow(QMainWindow):
    def __init__(self):
        super().__init__()

        self.setWindowTitle("Предсказание интересов")
        self.setGeometry(400, 250, 750, 500)

        # Создаем QTabWidget
        self.tabs = QTabWidget()
        self.setCentralWidget(self.tabs)

        # Создаем вкладки
        self.create_tabs()

        self.model_pred = ""


    def create_tabs(self):
        # Создаем первую вкладку
        tab1 = QWidget()
        
        self.pushButton = QPushButton(tab1)
        self.pushButton.setGeometry(QtCore.QRect(10, 10, 141, 41))
        self.pushButton.setObjectName("pushButton")
        self.pushButton.clicked.connect(self.load)
        self.pushButton.setText("Загрузить видео")

        self.pushButton_2 = QPushButton(tab1)
        self.pushButton_2.setGeometry(QtCore.QRect(10, 60, 141, 41))
        self.pushButton_2.setObjectName("pushButton_2")
        self.pushButton_2.clicked.connect(self.split)
        self.pushButton_2.setText("Разбить на кадры")

        self.pushButton_3 = QPushButton(tab1)
        self.pushButton_3.setGeometry(QtCore.QRect(10, 110, 141, 41))
        self.pushButton_3.setObjectName("pushButton_3")
        self.pushButton_3.clicked.connect(self.choose)
        self.pushButton_3.setText("Выбрать номер")

        self.pushButton_4 = QPushButton(tab1)
        self.pushButton_4.setGeometry(QtCore.QRect(10, 160, 141, 41))
        self.pushButton_4.setObjectName("pushButton_4")
        self.pushButton_4.clicked.connect(self.recognize)
        self.pushButton_4.setText("Распознать номер")

        self.label_6 = QLabel(tab1)
        self.label_6.setGeometry(QtCore.QRect(170, 10, 441, 241))
        self.label_6.setText("")
        self.label_6.setAlignment(QtCore.Qt.AlignmentFlag.AlignCenter)
        self.label_6.setObjectName("label_6")

        self.label_3 = QLabel(tab1)
        self.label_3.setGeometry(QtCore.QRect(200, 340, 71, 21))
        self.label_3.setText("Номер:")
        self.label_3.setObjectName("label_3")

        self.label_7 = QLabel(tab1)
        self.label_7.setGeometry(QtCore.QRect(290, 340, 161, 31))
        self.label_7.setText("")
        self.label_7.setObjectName("label_7")


        # Создаем вторую вкладку
        tab2 = QWidget()
        tab2_layout = QVBoxLayout()

        self.pushButton_csv = QPushButton(tab2)
        self.pushButton_csv.setText("Выбрать CSV файл")
        self.pushButton_csv.setFixedSize(750, 40)
        self.pushButton_csv.clicked.connect(self.choose_csv_file)
        tab2_layout.addWidget(self.pushButton_csv)

        self.pushButton_learn = QPushButton(tab2)
        self.pushButton_learn.setText("Обучить")
        self.pushButton_learn.setFixedSize(750, 40)
        self.pushButton_learn.clicked.connect(self.learn)
        tab2_layout.addWidget(self.pushButton_learn)

        self.label_csv = QLabel(tab2)
        self.label_csv.setText("CSV файл не выбран")
        tab2_layout.addWidget(self.label_csv)        
        
        self.label_done = QLabel(tab2)
        self.label_done.setText("Модель обучена model.keras")
        tab2_layout.addWidget(self.label_done)
        
        tab2.setLayout(tab2_layout)


        # Создаем третью вкладку
        tab3 = QWidget()
        tab3_layout = QVBoxLayout()

        # Ваши виджеты для третьей вкладки
        self.label_model = QLabel('Введите модель', tab3)
        self.label_age = QLabel('Введите возраст', tab3)

        self.text_edit_model = QTextEdit(tab3)
        self.text_edit_model.setFixedSize(750, 30)
        
        self.text_edit_age = QTextEdit(tab3)
        self.text_edit_age.setFixedSize(750, 30)

        self.table = QTableWidget(tab3)
        self.table.setColumnCount(7)
        self.table.setRowCount(2)

        for col in range(7):
            item = QTableWidgetItem(list_int[col])
            self.table.setItem(0, col, item)

        self.button_predict = QPushButton('Получить', tab3)
        self.button_predict.setFixedSize(750, 40)
        self.button_predict.clicked.connect(self.proc)

        self.button_choose_file = QPushButton('Выбрать файл модели', tab3)
        self.button_choose_file.setFixedSize(750, 40)
        self.button_choose_file.clicked.connect(self.choose_model_file)

        # Добавляем виджеты в третьей вкладке
        tab3_layout.addWidget(self.label_model)
        tab3_layout.addWidget(self.text_edit_model)
        tab3_layout.addWidget(self.label_age)
        tab3_layout.addWidget(self.text_edit_age)
        tab3_layout.addWidget(self.button_choose_file)
        tab3_layout.addWidget(self.table)
        tab3_layout.addWidget(self.button_predict)
        

        tab3.setLayout(tab3_layout)

        # Добавляем вкладки в QTabWidget
        self.tabs.addTab(tab1, "Сбор данных")
        self.tabs.addTab(tab2, "Обученеи нейросети")
        self.tabs.addTab(tab3, "Предсказание")


    def learn(self):
        percent = 0
        i = 0
        while percent < 100:
        #     while i < 100:
        #         i = i + 1
            time.sleep(5)
            percent = percent + 1

    def choose_csv_file(self):
        file_dialog = QFileDialog()
        options = file_dialog.options()
        file_name, _ = QFileDialog.getOpenFileName(self, "Выберите CSV файл", "", "CSV Files (*.csv);;All Files (*)", options=options)
        if file_name:
            self.csv_file = file_name
            self.label_csv.setText(f"Выбранный CSV файл: {file_name}")
        print(self.csv_file)


    def choose_model_file(self):
        file_dialog = QFileDialog()
        options = file_dialog.options()
        file_name, _ = QFileDialog.getOpenFileName(self, "Выберите файл модели", "", "Model Files (*.keras);;All Files (*)", options=options)
        if file_name:
            self.model_pred = file_name 
        print(self.model_pred)
        
    def proc(self):
        model = self.text_edit_model.toPlainText()
        age = self.text_edit_age.toPlainText()
        if (model != "") & (age != "") & (self.model_pred != ""):
            predictions = test_single.main(model, age, self.model_pred)
            print(predictions)
            for col in range(7):
                predictions[col] = float(predictions[col])
                item = QTableWidgetItem(str("{:2.2f}".format(predictions[col] * 100)) + "%")
                self.table.setItem(1, col, item)


    def format_timedelta(self, td):
        result = str(td)
        try:
            result, ms = result.split(".")
        except ValueError:
            return result + ".00".replace(":", "-")

        ms = round(int(ms) / 10000)
        return f"{result}.{ms:02}".replace(":", "-")


    def load(self):
        global video_file
        video_file= QFileDialog.getOpenFileName()
        path=Path(video_file[0])
        video_file=path.name
        print("load")

    def split(self):
        video_clip = VideoFileClip(video_file)
        filename, _ = os.path.splitext(video_file)

        if not os.path.isdir(filename):
            os.mkdir(filename)

        saving_frames_per_second = min(video_clip.fps, SAVING_FRAMES_PER_SECOND)
        step = 1 / video_clip.fps if saving_frames_per_second == 0 else 1 / saving_frames_per_second

        for current_duration in np.arange(0, video_clip.duration, step):
            frame_duration_formatted = self.format_timedelta(timedelta(seconds=current_duration)).replace(":", "-")
            frame_filename = os.path.join(filename, f"frame{frame_duration_formatted}.jpg")

            video_clip.save_frame(frame_filename, current_duration)
        print("split")


    def check_format(self, variable):
        pattern = r'^[A-Z]\d{3}[A-Z]{2}\d{3}$'
        pattern2 = r'^[A-Z]\d{3}[A-Z]{2}\d{2}$'
        if re.match(pattern, variable) or re.match(pattern2, variable):
            return True
        else:
            return False

    def choose(self):
        global image_file
        image_file = QFileDialog.getOpenFileName()
        image_file = image_file[0]
        self.label_6.setPixmap(QPixmap(image_file))
        self.label_6.setScaledContents(True)
        print("choose")


    def carplate_text(self):
        global image_file

        image0 = cv2.imread(image_file)


        image_height, image_width, _ = image0.shape
        image = cv2.resize(image0, (1024, 1024))
        image = image.astype(np.float32)
        paths = 'model/recognize/model_resnet.tflite'
        interpreter = tf.lite.Interpreter(model_path=paths)
        interpreter.allocate_tensors()
        input_details = interpreter.get_input_details()
        output_details = interpreter.get_output_details()
        X_data1 = np.float32(image.reshape(1, 1024, 1024, 3))

        interpreter.set_tensor(input_details[0]['index'], X_data1)

        interpreter.invoke()
        detection = interpreter.get_tensor(output_details[0]['index'])
        net_out_value2 = interpreter.get_tensor(output_details[1]['index'])
        net_out_value3 = interpreter.get_tensor(output_details[2]['index'])
        net_out_value4 = interpreter.get_tensor(output_details[3]['index'])

        img = image0
        razmer = img.shape

        img2 = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)
        img3 = img[:, :, :]

        number = 0
        while number < len(detection[0][number]) and detection[0, number, 0] > 0.9:
            number = number + 1

        box_x = int(detection[0, number, 0] * image_height)
        box_y = int(detection[0, number, 1] * image_width)
        box_width = int(detection[0, number, 2] * image_height)
        box_height = int(detection[0, number, 3] * image_width)

        cv2.rectangle(img2, (box_y, box_x), (box_height, box_width), (230, 230, 21), thickness=5)

        # plt.imshow(img2)
        # plt.xticks([]), plt.yticks([])  # Hides the graph ticks and x / y axis
        # plt.show()

        net_out_value3

        image = image0[box_x:box_width, box_y:box_height, :]
        img2 = cv2.cvtColor(image, cv2.COLOR_BGR2RGB)

        grayscale = rgb2gray(image)

        edges = canny(grayscale, sigma=3.0)

        out, angles, distances = hough_line(edges)
        h, theta, d = out, angles, distances
        angle_step = 0.5 * np.diff(theta).mean()
        d_step = 0.5 * np.diff(d).mean()
        bounds = [np.rad2deg(theta[0] - angle_step),
                np.rad2deg(theta[-1] + angle_step),
                d[-1] + d_step, d[0] - d_step]

        _, angles_peaks, _ = hough_line_peaks(out, angles, distances, num_peaks=20)
        angle = np.mean(np.rad2deg(angles_peaks))
        angle

        if 0 <= angle <= 90:
            rot_angle = angle - 90
        elif -45 <= angle < 0:
            rot_angle = angle - 90
        elif -90 <= angle < -45:
            rot_angle = 90 + angle
        if abs(rot_angle) > 20:
            rot_angle = 0

        rotated = rotate(image, rot_angle, resize=True) * 255
        rotated = rotated.astype(np.uint8)

        rotated1 = rotated[:, :, :]
        if rotated.shape[1] / rotated.shape[0] < 2:
            minus = np.abs(int(np.sin(np.radians(rot_angle)) * rotated.shape[0]))
            rotated1 = rotated[minus:-minus, :, :]
            print(minus)

        lab = cv2.cvtColor(rotated1, cv2.COLOR_BGR2LAB)
        l, a, b = cv2.split(lab)
        clahe = cv2.createCLAHE(clipLimit=3.0, tileGridSize=(8, 8))
        cl = clahe.apply(l)
        limg = cv2.merge((cl, a, b))
        final = cv2.cvtColor(limg, cv2.COLOR_LAB2BGR)

        letters = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'E', 'H', 'K', 'M', 'O', 'P', 'T', 'X',
                'Y']

        def decode_batch(out):
            ret = []
            for j in range(out.shape[0]):
                out_best = list(np.argmax(out[j, 2:], 1))
                out_best = [k for k, g in itertools.groupby(out_best)]
                outstr = ''
                for c in out_best:
                    if c < len(letters):
                        outstr += letters[c]
                ret.append(outstr)
            return ret

        paths = 'model/recognize/model1_nomer.tflite'
        interpreter = tf.lite.Interpreter(model_path=paths)
        interpreter.allocate_tensors()

        input_details = interpreter.get_input_details()
        output_details = interpreter.get_output_details()
        img = final
        img = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
        img = cv2.resize(img, (128, 64))
        img = img.astype(np.float32)
        img /= 255

        img1 = img.T
        img1.shape
        X_data1 = np.float32(img1.reshape(1, 128, 64, 1))
        input_index = (interpreter.get_input_details()[0]['index'])
        interpreter.set_tensor(input_details[0]['index'], X_data1)

        interpreter.invoke()

        net_out_value = interpreter.get_tensor(output_details[0]['index'])
        pred_texts = decode_batch(net_out_value)
        pred_texts

        fig = plt.figure(figsize=(10, 10))
        outer = gridspec.GridSpec(2, 1, wspace=10, hspace=0.1)
        ax1 = plt.Subplot(fig, outer[0])
        fig.add_subplot(ax1)
        ax2 = plt.Subplot(fig, outer[1])
        fig.add_subplot(ax2)
        return pred_texts[0]

    def recognize(self):
        global result
        result=self.carplate_text().upper()
        print(result)
        if result=='':
            QMessageBox.information(None, "Ошибка распознания", "НЕ РАСПОЗНАНО")
        elif self.check_format(result)!=True:
            QMessageBox.information(None, "Ошибка формата", "Результат:"+result)
        else:
            self.label_7.setText(result)

            count = 0
            for i in range(len(arr)):
                if arr[i][0] == result:
                    count += 1

            if count == 0:
                arr.append([result, 1])
            else:
                for i in range(len(arr)):
                    if arr[i][0] == result:
                        arr[i][1] += 1
        
        model_auto = autoteka.site(result)
        print(model_auto)
        print("recognize")

        file_path, _ = QFileDialog.getOpenFileName()
        test_blank.blank(file_path, 'data/data.csv', model_auto)

if __name__ == "__main__":
    app = QApplication(sys.argv)

    window = MainWindow()
    window.show()

    sys.exit(app.exec())
