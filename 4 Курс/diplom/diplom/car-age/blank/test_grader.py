from imutils.perspective import four_point_transform
from imutils import contours
import numpy as np
import argparse
import imutils
import cv2


def out():   
	# cv2.imshow("Original Image", image)
	# cv2.waitKey(0)

	# # Display the blurred image
	# cv2.imshow("Blurred Image", blurred)
	# cv2.waitKey(0)

	# # Display the edged image
	# cv2.imshow("Edged Image", edged)
	# cv2.waitKey(0)

	# # Display the perspective transformed image (original)
	# cv2.imshow("Perspective Transformed (Original)", paper)
	# cv2.waitKey(0)

	# # Display the perspective transformed image (grayscale)
	# cv2.imshow("Perspective Transformed (Grayscale)", warped)
	# cv2.waitKey(0)

	# # Display the thresholded image
	# cv2.imshow("Thresholded Image", thresh)
	# cv2.waitKey(0)
     
	# cv2.drawContours(paper, questionCnts, -1, (0, 0, 255), 2)
	# cv2.imshow("Contours", paper)
	# cv2.waitKey(0)


    output = paper.copy()
    colors = [(0, 0, 255), (0, 255, 0), (255, 0, 0), (255, 255, 0), (0, 255, 255)]

    for (q, i) in enumerate(np.arange(0, len(questionCnts), 5)):
        cnts = contours.sort_contours(questionCnts[i:i + 5])[0]
        for (j, c) in enumerate(cnts):
            ((x, y), r) = cv2.minEnclosingCircle(c)
            center = (int(x), int(y))
            cv2.circle(output, center, int(r), colors[q], 2)
        
    cv2.imshow("Bubbles Outlined", output)
    cv2.waitKey(0)
    
    cv2.destroyAllWindows()

def check():

    cv2.imshow("1", image)
    cv2.imshow("2", edged)
    cv2.imshow("3", paper)
    cv2.imshow("4", warped)
    cv2.imshow("5", thresh)
    cv2.waitKey(0)
    cv2.destroyAllWindows()



ap = argparse.ArgumentParser()
ap.add_argument("-i", "--image", required=True, help="path to the input image")
args = vars(ap.parse_args())
ANSWER_KEY = {0: 0, 1: 0, 2: 0, 3: 0, 4: 0}

image = cv2. imread(args["image"])
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
    if (w >= 20) and (h>=20) and (ar >= 0.9) and (ar <= 1.1):
        questionCnts.append(c)

questionCnts = contours.sort_contours(questionCnts, method="top-to-bottom")[0]
correct = 0

for (q, i) in enumerate(np.arange(0, len(questionCnts), 2)):
    cnts = contours.sort_contours(questionCnts[i:i + 2])[0]
    bubbled = None

    for (j, c) in enumerate(cnts):
        mask = np.zeros(thresh.shape, dtype="uint8")
        cv2.drawContours(mask, [c], -1, 255, -1)

        mask = cv2.bitwise_and(thresh, thresh, mask = mask)
        total = cv2.countNonZero(mask)
        if bubbled is None or total > bubbled[0]:
            bubbled = (total, j)

    color = (0, 0, 255)
    k = ANSWER_KEY[q]
    #print(k)

    if k == bubbled[1]:
        #print(bubbled[1])
        color = (0, 255, 0)
        correct +=1

    cv2.drawContours(paper, [cnts[k]], -1, color, 3)

score = (correct / 5) * 100
print("[INFO] score: {:.2f}%".format(score))
cv2.putText(paper, "{:.2f}%".format(score), (10, 30), cv2.FONT_HERSHEY_SIMPLEX, 0.9, (0, 0, 255), 2)
cv2. imshow("Original", image)
cv2. imshow("Exam", paper)
cv2.waitKey(0)