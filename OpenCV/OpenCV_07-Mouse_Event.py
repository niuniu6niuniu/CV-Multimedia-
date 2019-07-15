# ------Readme------ #
# Input: image
# Left click: return the x & y coordinates
# Right click: return the RGB value

import cv2
import numpy as np

img = cv2.imread('lena.jpg')


def click_event(event, x, y, flags, param):
    if event == cv2.EVENT_LBUTTONDOWN:
        # print(x, ', ', y)
        font = cv2.FONT_HERSHEY_DUPLEX
        strXY = '(' + str(x) + ', ' + str(y) + ')'
        cv2.putText(img, strXY, (x, y), font, .5, (255, 255, 0), 1)
        cv2.imshow('image', img)
    if event == cv2.EVENT_RBUTTONDOWN:
        blue = img[x, y, 0]
        green = img[x, y, 1]
        red = img[x, y, 2]
        font = cv2.FONT_HERSHEY_DUPLEX
        strRGB = '(' + str(blue) + ', ' + str(green) + ', ' + str(red) + ')'
        cv2.putText(img, strRGB, (x, y), font, .5, (0, 255, 255), 1)
        cv2.imshow('image', img)


cv2.imshow('image', img)

cv2.setMouseCallback('image', click_event)

cv2.waitKey(0)
cv2.destroyAllWindows()