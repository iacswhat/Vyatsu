# from imutils.perspective import four_point_transform
# from imutils import contours
# import numpy as np
# import argparse
# import imutils
# import cv2
# import csv
# import re
# import pytesseract


# ANSWER_KEY = {0: 0, 1: 0, 2: 0, 3: 0, 4: 0, 5: 0, 6: 0}

# pytesseract.pytesseract.tesseract_cmd = r'C:\\Program Files\\Tesseract-OCR\\tesseract.exe'

# custom_config = r'--oem 3 --psm 6'



# def process_exam(image_path):
#     image = cv2.imread(image_path)
#     gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
#     blurred = cv2.GaussianBlur(gray, (5, 5), 0)
#     edged = cv2.Canny(blurred, 75, 200)

#     cnts = cv2.findContours(edged.copy(), cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)
#     cnts = imutils.grab_contours(cnts)
#     docCnt = None

#     if len(cnts) > 0:
#         cnts = sorted(cnts, key=cv2.contourArea, reverse=True)
#         for c in cnts:
#             peri = cv2.arcLength(c, True)
#             approx = cv2.approxPolyDP(c, 0.02 * peri, True)
#             if len(approx) == 4:
#                 docCnt = approx
#                 break

#     paper = four_point_transform(image, docCnt.reshape(4, 2))
#     warped = four_point_transform(gray, docCnt.reshape(4, 2))

#     thresh = cv2.threshold(warped, 0, 255, cv2.THRESH_BINARY_INV | cv2.THRESH_OTSU)[1]

#     cnts = cv2.findContours(thresh.copy(), cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)
#     cnts = imutils.grab_contours(cnts)
#     questionCnts = []

#     for c in cnts:
#         (x, y, w, h) = cv2.boundingRect(c)
#         ar = w / float(h)
#         #if (w >= 20) and (h>=20) and (ar >= 0.9) and (ar <= 1.1):
#         if (w >= 50) and (h>=50) and (ar >= 0.9) and (ar <= 1.1):
#             questionCnts.append(c)

#     questionCnts = contours.sort_contours(questionCnts, method="top-to-bottom")[0]
#     results = []

#     for (q, i) in enumerate(np.arange(0, len(questionCnts), 2)):
#         cnts = contours.sort_contours(questionCnts[i:i + 2])[0]
#         bubbled = None
#         question_result = 0

#         for (j, c) in enumerate(cnts):
#             mask = np.zeros(thresh.shape, dtype="uint8")
#             cv2.drawContours(mask, [c], -1, 255, -1)

#             mask = cv2.bitwise_and(thresh, thresh, mask = mask)
#             total = cv2.countNonZero(mask)
#             if bubbled is None or total > bubbled[0]:
#                 bubbled = (total, j)

#         color = (0, 0, 255)
#         k = ANSWER_KEY[q]

#         if k == bubbled[1]:
#             question_result = 1
#             color = (0, 255, 0)

#         cv2.drawContours(paper, [cnts[k]], -1, color, 3)
#         results.append(question_result)

#     print(results)

#     cv2. imshow("Proc", paper)
#     cv2.waitKey(0)

#     return results

# def get_age(image_path):
#     image = cv2. imread(image_path)
#     gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
#     blurred = cv2.GaussianBlur(gray, (5, 5), 0)
#     edged = cv2.Canny(blurred, 75, 200)

#     cnts = cv2.findContours(edged.copy(), cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)
#     cnts = imutils.grab_contours(cnts)
#     docCnt = None

#     if len(cnts) > 0:
#         cnts = sorted(cnts, key=cv2.contourArea, reverse=True)
#         for c in cnts:
#             peri = cv2.arcLength(c, True)
#             approx = cv2.approxPolyDP(c, 0.02 * peri, True)
#             if len(approx) == 4:
#                 docCnt = approx
#                 break

#     paper = four_point_transform(image, docCnt.reshape(4, 2))

#     gray = cv2.cvtColor(paper, cv2.COLOR_BGR2GRAY)
#     blurred = cv2.GaussianBlur(gray, (5, 5), 0)
#     edged = cv2.Canny(blurred, 75, 200)

#     cnts = cv2.findContours(edged.copy(), cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)
#     cnts = imutils.grab_contours(cnts)
#     docCnt = None

#     if len(cnts) > 0:
#         cnts = sorted(cnts, key=cv2.contourArea, reverse=True)
#         for c in cnts:
#             peri = cv2.arcLength(c, True)
#             approx = cv2.approxPolyDP(c, 0.02 * peri, True)
#             if len(approx) == 4:
#                 docCnt = approx
#                 break

#     paper = four_point_transform(paper, docCnt.reshape(4, 2))

#     gray = cv2.cvtColor(paper, cv2.COLOR_BGR2GRAY)
#     thresh = cv2.threshold(gray, 0, 255, cv2.THRESH_BINARY_INV | cv2.THRESH_OTSU)[1]
#     #cv2.imshow("1", thresh)

#     #cv2.waitKey(0)
#     text = pytesseract.image_to_string(thresh, config=custom_config)
#     number = re.findall(r'\b\d+\b', text)
#     two_digit_numbers = ' '.join(num for num in number if len(num) == 2)
#     print(two_digit_numbers)
#     return two_digit_numbers


# def write_to_csv(filename, results):
#     with open(filename, mode='a', newline='') as file:
#         writer = csv.writer(file)
#         writer.writerow(results)

# def blank(path_in, path_out, model):
#     print(path_in)
#     print(path_out)
#     results = process_exam(path_in)
#     age = get_age(path_in)
#     results.insert(0, int(age))
#     results.insert(0, model)
#     print(results)
#     write_to_csv(path_out, results)
#     print("done")


# def main():
#     ap = argparse.ArgumentParser()
#     ap.add_argument("-i", "--image", required=True, help="path to the input image")
#     ap.add_argument("-o", "--output", required=True, help="path to save the output CSV file")
#     args = vars(ap.parse_args())
#     results = process_exam(args["image"])
#     age = get_age(args["image"])
#     results.insert(0, int(age))
#     print(results)
#     write_to_csv(args["output"], results)

# if __name__ == "__main__":
#     main()



from imutils.perspective import four_point_transform
from imutils import contours
import numpy as np
import argparse
import imutils
import cv2
import csv
import re
import pytesseract

# Define the correct answers for the exam (placeholder)
ANSWER_KEY = {0: 0, 1: 0, 2: 0, 3: 0, 4: 0, 5: 0, 6: 0}

# Path to Tesseract executable
pytesseract.pytesseract.tesseract_cmd = r'C:\\Program Files\\Tesseract-OCR\\tesseract.exe'

# Tesseract OCR configuration
custom_config = r'--oem 3 --psm 6'

def process_exam(image_path):
    # Read the input image
    image = cv2.imread(image_path)
    
    # Convert the image to grayscale
    gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
    
    # Apply GaussianBlur to reduce noise and detail in the image
    blurred = cv2.GaussianBlur(gray, (5, 5), 0)
    
    # Use Canny edge detector to find edges in the image
    edged = cv2.Canny(blurred, 75, 200)

    # Find contours in the edged image
    cnts = cv2.findContours(edged.copy(), cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)
    cnts = imutils.grab_contours(cnts)
    docCnt = None

    # Ensure at least one contour was found
    if len(cnts) > 0:
        # Sort the contours by area, keeping only the largest one
        cnts = sorted(cnts, key=cv2.contourArea, reverse=True)
        for c in cnts:
            # Approximate the contour
            peri = cv2.arcLength(c, True)
            approx = cv2.approxPolyDP(c, 0.02 * peri, True)
            
            # If the approximated contour has four points, assume it's the paper
            if len(approx) == 4:
                docCnt = approx
                break

    # Apply a perspective transform to obtain a top-down view of the paper
    paper = four_point_transform(image, docCnt.reshape(4, 2))
    warped = four_point_transform(gray, docCnt.reshape(4, 2))

    # Apply a binary threshold to the warped image
    thresh = cv2.threshold(warped, 0, 255, cv2.THRESH_BINARY_INV | cv2.THRESH_OTSU)[1]

    # Find contours in the thresholded image
    cnts = cv2.findContours(thresh.copy(), cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)
    cnts = imutils.grab_contours(cnts)
    questionCnts = []

    # Loop over the contours
    for c in cnts:
        (x, y, w, h) = cv2.boundingRect(c)
        ar = w / float(h)
        
        # Filter the contours to find those that correspond to question bubbles
        if (w >= 50) and (h >= 50) and (ar >= 0.9) and (ar <= 1.1):
            questionCnts.append(c)

    # Sort the question contours top-to-bottom
    questionCnts = contours.sort_contours(questionCnts, method="top-to-bottom")[0]
    results = []

    # Loop over the question groups
    for (q, i) in enumerate(np.arange(0, len(questionCnts), 2)):
        cnts = contours.sort_contours(questionCnts[i:i + 2])[0]
        bubbled = None
        question_result = 0

        # Loop over the sorted contours
        for (j, c) in enumerate(cnts):
            mask = np.zeros(thresh.shape, dtype="uint8")
            cv2.drawContours(mask, [c], -1, 255, -1)

            mask = cv2.bitwise_and(thresh, thresh, mask=mask)
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

# cv2.imshow("Proc", paper)
    cv2.waitKey(0)

    return results

def get_age(image_path):
    # Read the input image
    image = cv2.imread(image_path)
    
    # Convert the image to grayscale
    gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
    
    # Apply GaussianBlur to reduce noise and detail in the image
    blurred = cv2.GaussianBlur(gray, (5, 5), 0)
    
    # Use Canny edge detector to find edges in the image
    edged = cv2.Canny(blurred, 75, 200)

    # Find contours in the edged image
    cnts = cv2.findContours(edged.copy(), cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)
    cnts = imutils.grab_contours(cnts)
    docCnt = None

    # Ensure at least one contour was found
    if len(cnts) > 0:
        # Sort the contours by area, keeping only the largest one
        cnts = sorted(cnts, key=cv2.contourArea, reverse=True)
        for c in cnts:
            # Approximate the contour
            peri = cv2.arcLength(c, True)
            approx = cv2.approxPolyDP(c, 0.02 * peri, True)
            
            # If the approximated contour has four points, assume it's the paper
            if len(approx) == 4:
                docCnt = approx
                break

    # Apply a perspective transform to obtain a top-down view of the paper
    paper = four_point_transform(image, docCnt.reshape(4, 2))

    # Further process the transformed image to find the age
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
    
    # Use OCR to extract text from the thresholded image
    text = pytesseract.image_to_string(thresh, config=custom_config)
    
    # Find all two-digit numbers in the extracted text
    number = re.findall(r'\b\d+\b', text)
    two_digit_numbers = ' '.join(num for num in number if len(num) == 2)
    print(two_digit_numbers)
    return two_digit_numbers

def write_to_csv(filename, results):
    # Append the results to a CSV file
    with open(filename, mode='a', newline='') as file:
        writer = csv.writer(file)
        writer.writerow(results)

def blank(path_in, path_out, model):
    print(path_in)
    print(path_out)
    
    # Process the exam and get the age
    results = process_exam(path_in)
    age = get_age(path_in)
    
    # Insert model and age to the results
    results.insert(0, int(age))
    results.insert(0, model)
    
    print(results)
    write_to_csv(path_out, results)
    print("done")

def main():
    # Set up argument parser
    ap = argparse.ArgumentParser()
    ap.add_argument("-i", "--image", required=True, help="path to the input image")
    ap.add_argument("-o", "--output", required=True, help="path to save the output CSV file")
    args = vars(ap.parse_args())
    
    # Process the exam and get the age
    results = process_exam(args["image"])
    age = get_age(args["image"])
    
    # Insert age to the results
    results.insert(0, int(age))
    print(results)
    
    # Write results to the CSV file
    write_to_csv(args["output"], results)

if __name__ == "__main__":
    main()
