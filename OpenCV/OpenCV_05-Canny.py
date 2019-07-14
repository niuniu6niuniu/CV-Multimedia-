import cv2
import numpy as np

img = cv2.imread('hand_01.jpg', 1)

# Gaussian blur
blurImg = cv2.GaussianBlur(img, (9, 9), 0)
# Canny edge detector
cannyImg = cv2.Canny(blurImg, 80, 160)
# Canny inverse
cannyImg_inv = cv2.bitwise_not(cannyImg)
# Convert to BGR
cannyImg_mask = cv2.cvtColor(cannyImg_inv, cv2.COLOR_GRAY2BGR)
# Combine mask and img
cannySrcImg = cv2.bitwise_and(img, cannyImg_mask)
# Canny img inverse
cannyImg_mask = cv2.bitwise_not(cannyImg_mask)
# Mark mask as green
cannyImg_mask[:, :, [0, 1]] = 0
# Add img and mask
cannyImg_target = cv2.add(cannySrcImg, cannyImg_mask)

cv2.imshow('Canny', cannyImg_target)

cv2.waitKey()
cv2.destroyAllWindows()
