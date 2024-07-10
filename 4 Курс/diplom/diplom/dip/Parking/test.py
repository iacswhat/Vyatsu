import os
from datetime import timedelta
from pathlib import Path
import matplotlib.pyplot as plt
import cv2
import numpy as np
import re
import imutils
import pytesseract
import pytesseract as tess
tess.pytesseract.tesseract_cmd = r'Tesseract-OCR\tesseract.exe'
from PyQt6 import uic
from PyQt6.QtGui import QPixmap
from PyQt6.QtWidgets import QApplication, QFileDialog, QMessageBox
from imutils import contours
from moviepy.editor import VideoFileClip
import json
import sqlite3
import itertools
import tensorflow as tf
from skimage.feature import canny
from skimage.transform import hough_line, hough_line_peaks
from skimage.transform import rotate
from skimage.color import rgb2gray

import matplotlib.gridspec as gridspec




SAVING_FRAMES_PER_SECOND = 1

Form, Window = uic.loadUiType("Parking.ui")

app = QApplication([])
window = Window()
form = Form()
form.setupUi(window)
window.show()

video_file = ''
image_file = ''
result = ''
arr=[]


def format_timedelta(td):
    result = str(td)
    try:
        result, ms = result.split(".")
    except ValueError:
        return result + ".00".replace(":", "-")

    ms = round(int(ms) / 10000)
    return f"{result}.{ms:02}".replace(":", "-")

def load_file():
    global arr

    global db
    global sql
    db = sqlite3.connect('server.db')
    sql = db.cursor()

    sql.execute("SELECT * FROM parking")
    arr = sql.fetchall()
    arr = list(map(lambda x: list(x), arr))

    print('load')


def load():
    global video_file
    video_file= QFileDialog.getOpenFileName()
    path=Path(video_file[0])
    video_file=path.name
    print("load")

def split():
    video_clip = VideoFileClip(video_file)
    filename, _ = os.path.splitext(video_file)

    if not os.path.isdir(filename):
        os.mkdir(filename)

    saving_frames_per_second = min(video_clip.fps, SAVING_FRAMES_PER_SECOND)
    step = 1 / video_clip.fps if saving_frames_per_second == 0 else 1 / saving_frames_per_second

    for current_duration in np.arange(0, video_clip.duration, step):
        frame_duration_formatted = format_timedelta(timedelta(seconds=current_duration)).replace(":", "-")
        frame_filename = os.path.join(filename, f"frame{frame_duration_formatted}.jpg")

        video_clip.save_frame(frame_filename, current_duration)
    print("split")


def check_format(variable):
    pattern = r'^[A-Z]\d{3}[A-Z]{2}\d{3}$'
    pattern2 = r'^[A-Z]\d{3}[A-Z]{2}\d{2}$'
    if re.match(pattern, variable) or re.match(pattern2, variable):
        return True
    else:
        return False

def choose():
    global image_file
    image_file = QFileDialog.getOpenFileName()
    image_file = image_file[0]
    form.label_6.setPixmap(QPixmap(image_file))
    form.label_6.setScaledContents(True)
    print("choose")


def carplate_text():
    global image_file

    image0 = cv2.imread(image_file)


    image_height, image_width, _ = image0.shape
    image = cv2.resize(image0, (1024, 1024))
    image = image.astype(np.float32)
    paths = './model_resnet.tflite'
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

    plt.imshow(img2)
    plt.xticks([]), plt.yticks([])  # Hides the graph ticks and x / y axis
    plt.show()

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

    paths = './model1_nomer.tflite'
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

def recognize():
    load_file()
    global result
    result=carplate_text().upper()
    print(result)
    if result=='':
        QMessageBox.information(None, "Ошибка распознания", "НЕ РАСПОЗНАНО")
    elif check_format(result)!=True:
        QMessageBox.information(None, "Ошибка формата", "Результат:"+result)
    else:
        form.label_7.setText(result)

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

        for i in range(len(arr)):
            if arr[i][0] == result:
                form.label_2.setText(str(arr[i][1]))
                if (arr[i][1]<5):
                    form.label_5.setText('0%')
                elif (arr[i][1]>=5 and arr[i][1]<10):
                    form.label_5.setText('5%')
                elif (arr[i][1]>=10 and arr[i][1]<20):
                    form.label_5.setText('10%')
                else:
                    form.label_5.setText('15%')
    print("recognize")

form.pushButton.clicked.connect(load)
form.pushButton_2.clicked.connect(split)
form.pushButton_3.clicked.connect(choose)
form.pushButton_4.clicked.connect(recognize)

app.exec()

