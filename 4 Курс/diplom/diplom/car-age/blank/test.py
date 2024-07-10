from imutils.perspective import four_point_transform
from imutils import contours
import numpy as np
import argparse
import imutils
import cv2
import csv
import re
import pytesseract


ANSWER_KEY = {0: 0, 1: 0, 2: 0, 3: 0, 4: 0, 5: 0, 6: 0}

pytesseract.pytesseract.tesseract_cmd = r'C:\\Program Files\\Tesseract-OCR\\tesseract.exe'

custom_config = r'--oem 3 --psm 6'



def process_exam(image_path):
    image = cv2.imread(image_path)
    gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
    blurred = cv2.GaussianBlur(gray, (5, 5), 0)
    edged = cv2.Canny(blurred, 75, 200)

    cnts = cv2.findContours(edged.copy(), cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)
    cnts = imutils.grab_contours(cnts)
    docCnt = None

    if len(cnts) > 0:
        cnts = sorted(cnts, key=cv2.contourArea, reverse=True)
        for c in cnts:
            peri = cv2.arcLength(c, True)
            approx = cv2.approxPolyDP(c, 0.02 * peri, True)
            if len(approx) == 4:
                docCnt = approx
                break

    paper = four_point_transform(image, docCnt.reshape(4, 2))
    warped = four_point_transform(gray, docCnt.reshape(4, 2))

    thresh = cv2.threshold(warped, 0, 255, cv2.THRESH_BINARY_INV | cv2.THRESH_OTSU)[1]

    cnts = cv2.findContours(thresh.copy(), cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)
    cnts = imutils.grab_contours(cnts)
    questionCnts = []

    for c in cnts:
        (x, y, w, h) = cv2.boundingRect(c)
        ar = w / float(h)
        #if (w >= 20) and (h>=20) and (ar >= 0.9) and (ar <= 1.1):
        if (w >= 50) and (h>=50) and (ar >= 0.9) and (ar <= 1.1):
            questionCnts.append(c)

    questionCnts = contours.sort_contours(questionCnts, method="top-to-bottom")[0]
    results = []

    for (q, i) in enumerate(np.arange(0, len(questionCnts), 2)):
        cnts = contours.sort_contours(questionCnts[i:i + 2])[0]
        bubbled = None
        question_result = 0

        for (j, c) in enumerate(cnts):
            mask = np.zeros(thresh.shape, dtype="uint8")
            cv2.drawContours(mask, [c], -1, 255, -1)

            mask = cv2.bitwise_and(thresh, thresh, mask = mask)
            total = cv2.countNonZero(mask)
            if bubbled is None or total > bubbled[0]:
                bubbled = (total, j)

        color = (0, 0, 255)
        k = ANSWER_KEY[q]

        if k == bubbled[1]:
            question_result = 1
            color = (0, 255, 0)

        cv2.drawContours(paper, [cnts[k]], -1, color, 3)
        results.append(question_result)

    print(results)

    cv2. imshow("Proc", paper)
    cv2.waitKey(0)

    return results

def get_age(image_path):
    image = cv2. imread(image_path)
    gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
    blurred = cv2.GaussianBlur(gray, (5, 5), 0)
    edged = cv2.Canny(blurred, 75, 200)

    cnts = cv2.findContours(edged.copy(), cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)
    cnts = imutils.grab_contours(cnts)
    docCnt = None

    if len(cnts) > 0:
        cnts = sorted(cnts, key=cv2.contourArea, reverse=True)
        for c in cnts:
            peri = cv2.arcLength(c, True)
            approx = cv2.approxPolyDP(c, 0.02 * peri, True)
            if len(approx) == 4:
                docCnt = approx
                break

    paper = four_point_transform(image, docCnt.reshape(4, 2))

    gray = cv2.cvtColor(paper, cv2.COLOR_BGR2GRAY)
    blurred = cv2.GaussianBlur(gray, (5, 5), 0)
    edged = cv2.Canny(blurred, 75, 200)

    cnts = cv2.findContours(edged.copy(), cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)
    cnts = imutils.grab_contours(cnts)
    docCnt = None

    if len(cnts) > 0:
        cnts = sorted(cnts, key=cv2.contourArea, reverse=True)
        for c in cnts:
            peri = cv2.arcLength(c, True)
            approx = cv2.approxPolyDP(c, 0.02 * peri, True)
            if len(approx) == 4:
                docCnt = approx
                break

    paper = four_point_transform(paper, docCnt.reshape(4, 2))

    gray = cv2.cvtColor(paper, cv2.COLOR_BGR2GRAY)
    thresh = cv2.threshold(gray, 0, 255, cv2.THRESH_BINARY_INV | cv2.THRESH_OTSU)[1]
    cv2.imshow("1", thresh)

    cv2.waitKey(0)
    text = pytesseract.image_to_string(thresh, config=custom_config)
    number = re.findall(r'\b\d+\b', text)
    two_digit_numbers = ' '.join(num for num in number if len(num) == 2)
    print(two_digit_numbers)
    return two_digit_numbers


def write_to_csv(filename, results):
    with open(filename, mode='a', newline='') as file:
        writer = csv.writer(file)
        writer.writerow(results)


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("-i", "--image", required=True, help="path to the input image")
    ap.add_argument("-o", "--output", required=True, help="path to save the output CSV file")
    args = vars(ap.parse_args())
    results = process_exam(args["image"])
    age = get_age(args["image"])
    results.insert(0, int(age))
    print(results)
    write_to_csv(args["output"], results)

if __name__ == "__main__":
    main()