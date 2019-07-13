import cv2

img = cv2.imread('bulldog_01.jpg', 1)

print(img)

cv2.imshow('Bulldog', img)
k = cv2.waitKey(0) & 0xFF

if k == 27:
    cv2.destroyAllWindows()
elif k == ord('s'):
    cv2.imwrite('Bulldog_01.png', img)
    cv2.destroyAllWindows()
