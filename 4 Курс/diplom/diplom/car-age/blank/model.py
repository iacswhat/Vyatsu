import pytesseract
from PIL import Image
import imutils
import cv2
from imutils.perspective import four_point_transform
from imutils import contours
import re


pytesseract.pytesseract.tesseract_cmd = r'C:\\Program Files\\Tesseract-OCR\\tesseract.exe'

#custom_config = r'--oem 3 --psm 6'
custom_config = r'--psm 6 --oem 3 -c tessedit_char_whitelist=0123456789'

image = cv2. imread('image/41.jpg')
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
cv2.imshow("1", paper)


gray = cv2.cvtColor(paper, cv2.COLOR_BGR2GRAY)
thresh = cv2.threshold(gray, 0, 255, cv2.THRESH_BINARY_INV + cv2.THRESH_OTSU)[1]
thresh = cv2.GaussianBlur(thresh, (3,3), 0)


#thresh = cv2.threshold(gray, 0, 255, cv2.THRESH_BINARY_INV | cv2.THRESH_OTSU)[1]
cv2.imshow("1", thresh)


cv2.waitKey(0)
text = pytesseract.image_to_string(thresh, config=custom_config)
print("1", text)

#number = re.search(r'\d+', text)
number = re.findall(r'\b\d+\b', text)
print(number)
two_digit_numbers = ' '.join(num for num in number if len(num) == 2)
#two_digit_numbers = [int(num) for num in number if len(num) == 2]
#extracted_number = number.group()
print("text ", str(two_digit_numbers))