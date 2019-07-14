import numpy as np
import cv2

img = cv2.imread('lena.jpg', 1)

# Simple line
img = cv2.line(img, (0, 0), (255, 255), (0, 0, 255), 5)
# Arrowed line
img = cv2.arrowedLine(img, (512, 0), (255, 255), (255, 0, 0), 10)
# Rectangle
img = cv2.rectangle(img, (210, 200), (360, 385), (0, 255, 0), 5)
# Circle
img = cv2.circle(img, (280, 290), 95, (220, 135, 90), 5)
# Text
font = cv2.FONT_HERSHEY_DUPLEX
img = cv2.putText(img, 'OpenCV', (80, 475), font, 3, (0, 255, 255), 4, cv2.LINE_AA)

cv2.imshow('image', img)
cv2.waitKey(0)
cv2.destroyAllWindows()