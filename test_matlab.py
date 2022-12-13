import matlab
import matlab.engine
import cv2
engine = matlab.engine.start_matlab()
img = "USAF.png"
img = cv2.imread(img,0)
img= matlab.double(img.tolist())
signal = engine.gaussian_pulse(matlab.double(img))
print (signal)