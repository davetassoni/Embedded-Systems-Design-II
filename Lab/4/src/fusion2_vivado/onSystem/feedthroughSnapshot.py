import cv2
import numpy as np
import time
import mmap
import struct
import sys, random
import ctypes
import copy
from frameGrabber import ImageFeedthrough

global camera
camera = ImageFeedthrough()

time.sleep(1)
frameLeft,frameRight = camera.getStereoRGB()
cv2.imwrite("left.jpg", frameLeft)
cv2.imwrite("right.jpg", frameRight)