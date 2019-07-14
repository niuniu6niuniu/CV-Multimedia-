import cv2

cap = cv2.VideoCapture(0)   # Web cam capture
fourcc = cv2.VideoWriter_fourcc(*'XVID')
out = cv2.VideoWriter('Me.avi', fourcc, 20.0, (640, 480))

# Get width of the frame
# print(cap.get(cv2.CAP_PROP_FRAME_WIDTH))
# Get height of the frame
# print(cap.get(cv2.CAP_PROP_FRAME_HEIGHT))

while cap.isOpened():
    ret, frame = cap.read()   # ret stores True and False, frame stores video
    if ret:
        out.write(frame)
        gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
        cv2.imshow('frame', gray)
        if cv2.waitKey(1) & 0xFF == ord('q'):
            break
    else:
        break

cap.release()
out.release()
cv2.destroyAllWindows()
