# Fusion 2 April Tag Feedthrough Server With Point Inversion
import io
import time
import cv2
import csv
import threading
import remi.gui as gui
from remi import start, App
from frameGrabber import ImageFeedthrough
from frameGrabber import ImageProcessing
import logging
import numpy as np
import mmap
import struct
import sys, random
import ctypes
import copy
import os
import apriltag
import matplotlib.pyplot as plt
from matplotlib.figure import Figure
from matplotlib.backends.backend_agg import FigureCanvasAgg

global camera
camera = ImageFeedthrough()

class VideoDisplayWidget(gui.Image):
    def __init__(self,memCam, fps=5, **kwargs):
        super(VideoDisplayWidget, self).__init__("/%s/get_image_data" % id(self), **kwargs)
        self.memCam = memCam
        self.flag = True
        self.fps = fps
        self.redMin = 96
        self.redMax = 255
        self.greenMin = 113
        self.greenMax = 255
        self.blueMin = 58
        self.blueMax = 255
        self.detector = apriltag.Detector()
        self.headers = {'Content-type': 'image/jpeg'}
        javascript_code = gui.Tag()
        javascript_code.type = 'script'
        javascript_code.attributes['type'] = 'text/javascript'
        javascript_code.add_child('code', """
            function update_image%(id)s(){
                var url = '/%(id)s/get_image_data';
                var xhr = new XMLHttpRequest();
                xhr.open('GET', url, true);
                xhr.responseType = 'blob'
                xhr.onload = function(e){
                    var urlCreator = window.URL || window.webkitURL;
                    var imageUrl = urlCreator.createObjectURL(this.response);
                    document.getElementById('%(id)s').src = imageUrl;
                }
                xhr.send();
            };
            setInterval( update_image%(id)s, %(update_rate)s );
            """ % {'id': id(self), 'update_rate': 1000.0 / self.fps})

        self.add_child('javascript_code', javascript_code)
        
    def get_image_data(self):
        global camera
        self.frameLeft,self.frameRight = camera.getStereoAll()
        tempImageLeft = np.ascontiguousarray(self.frameLeft[:,:,0:3], dtype=np.uint8)   # must make it contiguous for opencv processing to work
        tempImageRight = np.ascontiguousarray(self.frameRight[:,:,0:3], dtype=np.uint8)   # must make it contiguous for opencv processing to work

        grayImageLeft = self.frameLeft[:,:,3]  
        grayImageRight = self.frameRight[:,:,3]   
        
        f = 5.878
        b = 62.9692
        pixelSize = .006
        cxLeft = 422.2
        cyLeft = 194.1
        fxLeft = 1047.6
        fyLeft = 1043.4
        cxRight = 345.8939
        cyRight = 171.4773
        fxRight = 983.3412
        fyRight = 975.1861
        tagSize = .155


        # Define camera matrix for left camera.  This data is from Matlab but sometimes the upper right values
        # and middle right value are shown as the lower left and lower middle value in matlab.  Make sure to 
        # load in the matrix in this format.
        mtxLeft =  np.array([[fxLeft,    0,      cxLeft],
                             [0,         fyLeft, cyLeft],
                             [0,         0,          1]])
        
        # Define distortion coefficients.  These are the radial distortion coeffs from matlab.
        dist = np.array([-0.5379, 2.1765, 0,0])

        # can do undistortion if you like as shown below
        tempImageLeft = cv2.undistort(tempImageLeft, mtxLeft, dist)
        grayImageLeft = cv2.undistort(grayImageLeft, mtxLeft, dist)
        resultLeft = self.detector.detect(grayImageLeft)
        
        # Define camera matrix for right camera.  This data is from Matlab but sometimes the upper right values
        # and middle right value are shown as the lower left and lower middle value in matlab.  Make sure to 
        # load in the matrix in this format.
        mtxRight =  np.array([[fxRight, 0,        cxRight],
                              [0,         fyRight, cyRight],
                              [0,         0,        1]])
        
        # Define distortion coefficients.  These are the radial distortion coeffs from matlab.
        dist = np.array([-0.5185, 2.4942, 0,0])

        # can do undistortion if you like as shown below
        tempImageRight = cv2.undistort(tempImageRight, mtxRight, dist)
        grayImageRight = cv2.undistort(grayImageRight, mtxRight, dist)
        resultRight = self.detector.detect(grayImageRight)

        # define the various parameters that are for your camera.  the cxLeft, cyLeft, cxRight, cyRight
        # are just from the camera matrices above
        # f = 5.878; # focal length [mm]
        # b = 58.8104 # baseline [mm]
        # pixelSize = .006;  # [mm]
        # cxLeft = 310.7146 # left camera principal pt
        # cyLeft = 261.7735 # left camera principal pt
        # cxRight = 346.9222 # right camera principal pt
        # cyRight = 290.9704 # right camera principal pt
        # tagSize = .1 # this is for a 10 cm x 10 cm tag
                
        # display blue bounding box around left tag
        if not resultLeft:
            # no detections
            pass
        else:
            x1 = int(resultLeft[0].corners[0][0])
            y1 = int(resultLeft[0].corners[0][1])
            x2 = int(resultLeft[0].corners[1][0])
            y2 = int(resultLeft[0].corners[1][1])
            x3 = int(resultLeft[0].corners[2][0])
            y3 = int(resultLeft[0].corners[2][1])
            x4 = int(resultLeft[0].corners[3][0])
            y4 = int(resultLeft[0].corners[3][1])
            cv2.line(tempImageLeft,(x1,y1),(x2,y2),(255,255,0),3)
            cv2.line(tempImageLeft,(x2,y2),(x3,y3),(255,255,0),3)
            cv2.line(tempImageLeft,(x3,y3),(x4,y4),(255,255,0),3)
            cv2.line(tempImageLeft,(x4,y4),(x1,y1),(255,255,0),3)
    
        # display blue bounding box around right tag
        if not resultRight:
            # no detections
            pass
        else:
            x1 = int(resultRight[0].corners[0][0])
            y1 = int(resultRight[0].corners[0][1])
            x2 = int(resultRight[0].corners[1][0])
            y2 = int(resultRight[0].corners[1][1])
            x3 = int(resultRight[0].corners[2][0])
            y3 = int(resultRight[0].corners[2][1])
            x4 = int(resultRight[0].corners[3][0])
            y4 = int(resultRight[0].corners[3][1])
            cv2.line(tempImageRight,(x1,y1),(x2,y2),(255,255,0),3)
            cv2.line(tempImageRight,(x2,y2),(x3,y3),(255,255,0),3)
            cv2.line(tempImageRight,(x3,y3),(x4,y4),(255,255,0),3)
            cv2.line(tempImageRight,(x4,y4),(x1,y1),(255,255,0),3)
        
        if not resultLeft:
            # no detections
            pass
        else:
            lower = np.array([self.redMin, self.greenMin, self.blueMin])
            upper = np.array([self.redMax, self.greenMax, self.blueMax])
            
            mask = cv2.inRange(tempImageLeft, lower, upper)
            mask = cv2.erode(mask, None, iterations=2)
            mask = cv2.dilate(mask, None, iterations=2)
            
            maskedImage = cv2.bitwise_and(tempImageLeft, tempImageLeft, mask=mask)
            
            cnts = cv2.findContours(mask.copy(), cv2.RETR_EXTERNAL,cv2.CHAIN_APPROX_SIMPLE)[-2]
            center = None
            # only proceed if at least one contour was found
            x1 = 0
            y1 = 0
            if len(cnts) > 0:
                #print "counts" + str(len(cnts))
                # find the largest contour in the mask, then use
                # it to compute the minimum enclosing circle and
                # centroid
                c = max(cnts, key=cv2.contourArea)
                ((x, y), radius) = cv2.minEnclosingCircle(c)
                M = cv2.moments(c)
                center = (int(M["m10"] / M["m00"]), int(M["m01"] / M["m00"]))
        
                # only proceed if the radius meets a minimum size
                if radius > 10:
                    # draw the circle and centroid on the frame,
                    # then update the list of tracked points
                    cv2.circle(tempImageLeft, (int(x), int(y)), int(radius),(0, 255, 255), 2)
                    cv2.circle(tempImageLeft, center, 5, (0, 255, 255), -1)
                    #print("X: " + str(int(x)))
                    #print("Y: " + str(int(y)))
                    #cv2.circle(clone_img, center, 5, (0, 0, 255), -1)
                    x1 = x
                    y1 = y
            
            mask = cv2.inRange(tempImageRight, lower, upper)
            mask = cv2.erode(mask, None, iterations=2)
            mask = cv2.dilate(mask, None, iterations=2)
            
            maskedImage = cv2.bitwise_and(tempImageRight, tempImageRight, mask=mask)
            
            cnts = cv2.findContours(mask.copy(), cv2.RETR_EXTERNAL,cv2.CHAIN_APPROX_SIMPLE)[-2]
            center = None
            # only proceed if at least one contour was found
            x2 = 0
            y2 = 0
            if len(cnts) > 0:
                #print "counts" + str(len(cnts))
                # find the largest contour in the mask, then use
                # it to compute the minimum enclosing circle and
                # centroid
                c = max(cnts, key=cv2.contourArea)
                ((x, y), radius) = cv2.minEnclosingCircle(c)
                M = cv2.moments(c)
                center = (int(M["m10"] / M["m00"]), int(M["m01"] / M["m00"]))
        
                # only proceed if the radius meets a minimum size
                if radius > 10:
                    # draw the circle and centroid on the frame,
                    # then update the list of tracked points
                    cv2.circle(tempImageRight, (int(x), int(y)), int(radius),(0, 255, 255), 2)
                    cv2.circle(tempImageRight, center, 5, (0, 255, 255), -1)
                    #print("X: " + str(int(x)))
                    #print("Y: " + str(int(y)))
                    #cv2.circle(clone_img, center, 5, (0, 0, 255), -1)
                    x2 = x
                    y2 = y
            
            Z = (b * f)/(abs((x1-cxLeft)-(x2-cxRight))*pixelSize);
                
            X = (Z * (x1-cxLeft)*pixelSize)/f;
            
            Y = (Z * (y1-cyLeft)*pixelSize)/f;
            
            # conver to m
            X = X/1000.0
            Y = Y/1000.0
            Z = Z/1000.0
            
            camPt = np.array([X,Y,Z,1]).T
            
            pose = self.detector.detection_pose(resultLeft[0],(fxLeft, fxLeft, cxLeft, cyLeft ), tagSize, 1)
            
            position = np.dot(np.linalg.inv(pose[0]),camPt)
                
            # convert to centimeters
            positionCentimeters = position[0:3] * 100
            
            self.memCam.seek(0)
            self.memCam.write(struct.pack('f', positionCentimeters[0]))
            self.memCam.write(struct.pack('f', positionCentimeters[1]))
            self.memCam.write(struct.pack('f', positionCentimeters[2]))

            #self.image = self.get_qimage(clone_img)
            # update() calls the paintEvent() function below
            #self.update()

        ###########################################################################################
        # if both tags are found then do the below code.  There are two different sections here but
        # both sections need the relative pose between the camera and the tag so that step is listed
        # out separately.
        # 
        # part 1:  this grabs the upper left corner pixel of the tag from both the left and right 
        #          images.  This pixel exists as [-5,-5,0] in cm as the tag is 10 cm wide and the 
        #          upper left corner pixel is therefore shifted 5 px up and to the left which are 
        #          both in the negative direction.  The goal is for the camera to detect the upper
        #          left corner pixel in the left and right images and to determine:
        #          a] the position in pixel coordinates for the left and rigth images
        #          b] the location in camera X,Y,Z coordinates 
        #          c] the location in april tag coordintes which should be close to [-5,-5 0]
        #
        # part 2:  this step involves converting a series of points from the april tag coordinate system
        #          to the camera pixel 2D coordinate system.  This allows for the visualization of various
        #          world points as an overlay.  I have chosen points in the april tag coordinate system
        #          that map out a cube with side lengths of 5 cm each.
        #          a] convert the 4x4 pose matrix into a rotation vector and translation vector
        #          b] specify april tag pts, project to camera pixels, assign to x and y, plot lines 
        ###########################################################################################
        if resultLeft:
            if resultRight:   
                # determine the pose of the left camera relative to the april tag.  The 4 values listed in
                # parens are the fx,fy,cx,cy from the left calibration matrix.  The tagSize value is the size of 
                # the april tag [which for me was .1 m or 10 cm].  The last value of 1 was to determine
                # which direction the z vecto should be, and it should remain as 1.  The resultLeft[0] struct
                # is sent to the function as that contains the homography which is used along with the 
                # camera params and tag size to compute the pose matrix which is a 4x4 matrix.
                pose = self.detector.detection_pose(resultLeft[0],(fxLeft, fyLeft, cxLeft, cyLeft ), tagSize, 1)

                ###################################################################################
                # part 1a: determine x1,y1 and x2,y2 which are the upper left corner of the tag for
                #          both left and right images in pixel coordinates
                x1 = float(resultLeft[0].corners[0][0])
                y1 = float(resultLeft[0].corners[0][1])
        
                x2 = float(resultRight[0].corners[0][0])
                y2 = float(resultRight[0].corners[0][1])    
        
                # part 1b: determine the X,Y,Z camera coordinate of the upper left corner of the tag.
                #          note that the depth is determined with both cameras but the X and Y are 
                #          determined with just the left camera.  There might be better optimizations 
                #          than doing it this way but this will get pretty good results.  The equations
                #          below are straight from the doc posted on the education site.
                Z = (b * f)/(abs((x1-cxLeft)-(x2-cxRight))*pixelSize);
                
                X = (Z * (x1-cxLeft)*pixelSize)/f;
                
                Y = (Z * (y1-cyLeft)*pixelSize)/f;
                
                # conver to m
                X = X/1000.0
                Y = Y/1000.0
                Z = Z/1000.0
                
                # since this vector will be multiplied by a 4x4 pose matrix a 1 must be appended to it
                camPt = np.array([X,Y,Z,1]).T
                
                # part 1c:  determine the position in the april tag coordinate system by performing
                #           a matrix multiplication of the inverse of the pose matrix times the 3D
                #           camera coordinate point.  This takes the camera coordinate which could
                #           be anything [based on the camera position] and maps it to what should be
                #           a static value as the tag is not moving.
                position = np.dot(np.linalg.inv(pose[0]),camPt)
                
                # convert to centimeters
                positionCentimeters = position[0:3] * 100
                
                # this print out should be close to [-5,-5,0] which is the location of the upper left
                # corner of the tag for my 10 cm wide tag.
                print positionCentimeters
                ###################################################################################

                # part 2a: pull out the rotation vector and translation vector from the pose matrix
                rotMat = pose[0][0:3,0:3]       # slice out the 3x3 rotation matrix from the 4x4 matrix
                rvec,_ = cv2.Rodrigues(rotMat)  # convert 3x3 rotation matrix to rotation vector
                tvec = pose[0][0:3,3]           # slice out the 3x1 translation vector
                
                # part 2b: the same process is repeated 3 times as the first section of point make a frame
                #          around the april tag, the second section of points make a frame that exists 5 cm
                #          away from the way, and the third section of points connect up the two frames
                
                # plot points around tag [only works for 10 cm x 10 cm tag].  If you have a different size
                # tag then just change the values here.  For example: a 12 cm tag, these would be -.06 etc..
                halfTagSize = tagSize/2
                points =  np.array([[-halfTagSize , -halfTagSize , 0],
                                    [halfTagSize , -halfTagSize , 0] ,
                                    [halfTagSize , halfTagSize , 0],
                                    [-halfTagSize,halfTagSize, 0]])
                
                # convert april tag coordinate points to camera pixel points.  Need camera calibration 
                # matrix as well as the rotation and translation vectors
                result = cv2.projectPoints(points, rvec, tvec, mtxLeft, None)

                #for n in range(len(points)):
                #    print points[n], '==>', result[0][n]
                
                # just map the results to x's and y's.  Looks confusing and there is probably a much more
                # elegant way of doing this
                x1 = int(result[0][0][0][0])
                y1 = int(result[0][0][0][1])
                x2 = int(result[0][1][0][0])
                y2 = int(result[0][1][0][1])
                x3 = int(result[0][2][0][0])
                y3 = int(result[0][2][0][1])
                x4 = int(result[0][3][0][0])
                y4 = int(result[0][3][0][1])
                
                # plot the line segments in camera pixel coordinates
                cv2.line(tempImageLeft,(x1,y1),(x2,y2),(0,255,0),3)
                cv2.line(tempImageLeft,(x2,y2),(x3,y3),(0,255,0),3)
                cv2.line(tempImageLeft,(x3,y3),(x4,y4),(0,255,0),3)
                cv2.line(tempImageLeft,(x4,y4),(x1,y1),(0,255,0),3)

                # plot outer square
                points =  np.array([[-halfTagSize , -halfTagSize , -.1],
                                    [halfTagSize , -halfTagSize , -.1] ,
                                    [halfTagSize , halfTagSize , -.1],
                                    [-halfTagSize,halfTagSize, -.1]])
                
                # convert april tag coordinate points to camera pixel points.  Need camera calibration 
                # matrix as well as the rotation and translation vectors
                result = cv2.projectPoints(points, rvec, tvec, mtxLeft, None)

                #for n in range(len(points)):
                #    print points[n], '==>', result[0][n]
                 
                x1 = int(result[0][0][0][0])
                y1 = int(result[0][0][0][1])
                x2 = int(result[0][1][0][0])
                y2 = int(result[0][1][0][1])
                x3 = int(result[0][2][0][0])
                y3 = int(result[0][2][0][1])
                x4 = int(result[0][3][0][0])
                y4 = int(result[0][3][0][1])
                
                # plot the line segments in camera pixel coordinates
                cv2.line(tempImageLeft,(x1,y1),(x2,y2),(0,255,0),3)
                cv2.line(tempImageLeft,(x2,y2),(x3,y3),(0,255,0),3)
                cv2.line(tempImageLeft,(x3,y3),(x4,y4),(0,255,0),3)
                cv2.line(tempImageLeft,(x4,y4),(x1,y1),(0,255,0),3)

                # plot connecting secments
                points =  np.array([[-halfTagSize , -halfTagSize , 0],
                                    [-halfTagSize , -halfTagSize , -.1],
                                    [halfTagSize , -halfTagSize , 0] ,
                                    [halfTagSize , -halfTagSize , -.1] ,
                                    [halfTagSize , halfTagSize , 0],
                                    [halfTagSize , halfTagSize , -.1],
                                    [-halfTagSize,halfTagSize, 0],
                                    [-halfTagSize,halfTagSize, -.1]])
                
                # convert april tag coordinate points to camera pixel points.  Need camera calibration 
                # matrix as well as the rotation and translation vectors
                result = cv2.projectPoints(points, rvec, tvec, mtxLeft, None)

                # for n in range(len(points)):
                    # print points[n], '==>', result[0][n]
                 
                x1 = int(result[0][0][0][0])
                y1 = int(result[0][0][0][1])
                x2 = int(result[0][1][0][0])
                y2 = int(result[0][1][0][1])
                x3 = int(result[0][2][0][0])
                y3 = int(result[0][2][0][1])
                x4 = int(result[0][3][0][0])
                y4 = int(result[0][3][0][1])
                x5 = int(result[0][4][0][0])
                y5 = int(result[0][4][0][1])
                x6 = int(result[0][5][0][0])
                y6 = int(result[0][5][0][1])
                x7 = int(result[0][6][0][0])
                y7 = int(result[0][6][0][1])
                x8 = int(result[0][7][0][0])
                y8 = int(result[0][7][0][1])

                # plot the line segments in camera pixel coordinates
                cv2.line(tempImageLeft,(x1,y1),(x2,y2),(0,255,0),3)
                cv2.line(tempImageLeft,(x3,y3),(x4,y4),(0,255,0),3)
                cv2.line(tempImageLeft,(x5,y5),(x6,y6),(0,255,0),3)
                cv2.line(tempImageLeft,(x7,y7),(x8,y8),(0,255,0),3)

                #print "X: " + str(X) + " Y: " + str(Y) + " Z: " + str(Z)

        self.frame = np.concatenate((tempImageLeft,tempImageRight),axis=1)
        ret,self.jpeg = cv2.imencode('.jpg', self.frame)
        return [self.jpeg.tostring(), self.headers]

#----------------------------------------------------------------
class MatplotImage(gui.Image):
    ax = None

    def __init__(self, **kwargs):
        super(MatplotImage, self).__init__("/%s/get_image_data?update_index=0" % id(self), **kwargs)
        self._buf = None
        self._buflock = threading.Lock()

        self._fig = Figure(figsize=(5, 5))
        self.ax = self._fig.add_subplot(111)

        self.redraw()

    def redraw(self):
        canv = FigureCanvasAgg(self._fig)
        buf = io.BytesIO()
        canv.print_figure(buf, format='png')
        with self._buflock:
            if self._buf is not None:
                self._buf.close()
            self._buf = buf

        i = int(time.time() * 1e6)
        self.attributes['src'] = "/%s/get_image_data?update_index=%d" % (id(self), i)

        super(MatplotImage, self).redraw()

    def get_image_data(self, update_index):
        with self._buflock:
            if self._buf is None:
                return None
            self._buf.seek(0)
            data = self._buf.read()

        return [data, {'Content-type': 'image/png'}]
#----------------------------------------------------------------

class MyApp(App):
    def __init__(self, *args):
        super(MyApp, self).__init__(*args)
        
    def main(self, name='world'):
        f = open("/dev/mem", "r+b")
        memCam = mmap.mmap(f.fileno(), 100, offset=0xfffc1000)
        
        verticalContainer = gui.Container(width=1524, height = 600, layout_orientation=gui.Container.LAYOUT_VERTICAL, 
                             margin='0px auto', style={'display': 'block', 'overflow': 'hidden'})
        horizontalContainer = gui.Container(width='100%', layout_orientation=gui.Container.LAYOUT_HORIZONTAL, margin='0px', style={'display': 'block', 'overflow': 'auto'})
        horizontalContainer2 = gui.Container(width='100%', layout_orientation=gui.Container.LAYOUT_HORIZONTAL, margin='0px', style={'display': 'block', 'overflow': 'auto'})
        
        self.videoDisplay = VideoDisplayWidget(memCam, 5, width=1504, height=480)
        self.videoDisplay.style['margin'] = '10px'
        
        self.bt1 = gui.Button('Capture', width=150, height=30, margin='10px')
        self.bt2 = gui.Button('Mode', width=150, height=30, margin='10px')
        self.close_btn = gui.Button('Close', width=150, height=30, margin='10px')
        self.plot_btn = gui.Button('Display Plot', width=150, height=30, margin='10px')
        
        self.bt1.onclick.do(self.on_button_pressed1)
        self.bt2.onclick.do(self.on_button_pressed2)
        self.close_btn.onclick.do(self.on_button_pressed3)
        self.plot_btn.onclick.do(self.plot_btn_clicked)
        
        self.lblRed  = gui.Label('Red Min', width=50, height=30, margin='10px')
        self.spinRed = gui.SpinBox(min=0, max=5000, width=50, height=30, margin='10px')
        self.spinRed.set_value(0)
        self.spinRed.onchange.do(self.spinChangedRed)
        
        self.lblGreen  = gui.Label('Green Min', width=50, height=30, margin='10px')
        self.spinGreen = gui.SpinBox(min=0, max=5000, width=50, height=30, margin='10px')
        self.spinGreen.set_value(0)
        self.spinGreen.onchange.do(self.spinChangedGreen)
        
        self.lblBlue  = gui.Label('Blue Min', width=50, height=30, margin='10px')
        self.spinBlue = gui.SpinBox(min=0, max=5000, width=50, height=30, margin='10px')
        self.spinBlue.set_value(0)
        self.spinBlue.onchange.do(self.spinChangedBlue)
        
        self.lblRedMax  = gui.Label('Red Max', width=50, height=30, margin='10px')
        self.spinRedMax = gui.SpinBox(min=0, max=5000, width=50, height=30, margin='10px')
        self.spinRedMax.set_value(255)
        self.spinRedMax.onchange.do(self.spinChangedRedMax)
        
        self.lblGreenMax  = gui.Label('Green Max', width=50, height=30, margin='10px')
        self.spinGreenMax = gui.SpinBox(min=0, max=5000, width=50, height=30, margin='10px')
        self.spinGreenMax.set_value(255)
        self.spinGreenMax.onchange.do(self.spinChangedGreenMax)
        
        self.lblBlueMax  = gui.Label('Blue Max', width=50, height=30, margin='10px')
        self.spinBlueMax = gui.SpinBox(min=0, max=5000, width=50, height=30, margin='10px')
        self.spinBlueMax.set_value(255)
        self.spinBlueMax.onchange.do(self.spinChangedBlueMax)
        
        #------------------------------------------------------------#
        self.mpl = MatplotImage(width=400, height=400)
        self.mpl.style['margin'] = '10px'
        self.mpl.ax.set_title("System Analysis Plot (Sample Data)")
        self.mpl.ax.set_xlabel("X Axis")
        self.mpl.ax.set_ylabel("Y Axis") 
        #------------------------------------------------------------#

        self.mpl.redraw()
        
        horizontalContainer.append(self.close_btn)
        horizontalContainer.append(self.bt1)
        horizontalContainer.append(self.bt2)        
        horizontalContainer.append(self.plot_btn)
        horizontalContainer.append(self.lblRed)
        horizontalContainer.append(self.spinRed)
        horizontalContainer.append(self.lblGreen)
        horizontalContainer.append(self.spinGreen)
        horizontalContainer.append(self.lblBlue)
        horizontalContainer.append(self.spinBlue)
        horizontalContainer.append(self.lblRedMax)
        horizontalContainer.append(self.spinRedMax)
        horizontalContainer.append(self.lblGreenMax)
        horizontalContainer.append(self.spinGreenMax)
        horizontalContainer.append(self.lblBlueMax)
        horizontalContainer.append(self.spinBlueMax)
        
        horizontalContainer2.append(self.videoDisplay)
                
        verticalContainer.append(horizontalContainer)
        verticalContainer.append(horizontalContainer2)
        
        return verticalContainer
      
    def on_button_pressed1(self, widget):
        i = 1
        while os.path.exists("left%s.jpg" % i):
            i += 1
        
        saveString = "Saved Image Set: " + str(i)
        #self.bt1.set_text(str(i))
        self.bt1.set_text(saveString)
                
        cv2.imwrite("left%s.jpg" % i, self.videoDisplay.frameLeft)
        cv2.imwrite("right%s.jpg" % i, self.videoDisplay.frameRight)

    def on_button_pressed2(self, widget):
        self.videoDisplay.flag = not self.videoDisplay.flag
        
    def on_button_pressed3(self, _):
        self.close()  # closes the application
    
    def spinChangedRed(self,widget,value):
        self.videoDisplay.redMin = int(value)
 
    def spinChangedGreen(self,widget,value):    
        self.videoDisplay.greenMin = int(value)
 
    def spinChangedBlue(self,widget,value):    
        self.videoDisplay.blueMin = int(value)
        
    def spinChangedRedMax(self,widget,value):    
        self.videoDisplay.redMax = int(value)
        
    def spinChangedGreenMax(self,widget,value):    
        self.videoDisplay.greenMax = int(value)
        
    def spinChangedBlueMax(self,widget,value):    
        self.videoDisplay.blueMax = int(value)

    def plot_btn_clicked(self, widget):
        
        self.dialog = gui.GenericDialog(title='System Accuracy Analysis', message='Click OK to Return to Home Page', width='900px')
        self.horizontal_container = gui.Container(width='100%', layout_orientation=gui.Container.LAYOUT_HORIZONTAL, 
                               margin='0px', style={'display': 'block', 'overflow': 'hidden'})
                               
        

        self.dialog.confirm_dialog.do(self.dialog_confirm)
        
        with open("Test_Data.csv",'r') as i:               #open a file in directory of this script for reading
            raw_data = list(csv.reader(i,delimiter=","))   #make a list of data in file
        
        ex_data = np.array(raw_data[1:],dtype=np.float)    #convert to data array
        
        #Blue Line
        x_data = ex_data[:,0]
        y_data = ex_data[:,1]
        
        #Green Line
        x2_data = ex_data[:,1]  
        y2_data = ex_data[:,0] 
        
        self.mpl.ax.set_xlabel(raw_data[0][0])
        self.mpl.ax.set_ylabel(raw_data[0][1])
        self.mpl.ax.plot(x_data, y_data, x2_data, y2_data, marker =".", markeredgecolor = "red", markeredgewidth = 2)
        self.mpl.redraw()
        
        print("Data now on screen")
        
        self.horizontal_container.append(self.mpl)   
        
        self.dialog.add_field('horizontal_container', self.horizontal_container)
        
        self.dialog.show(self)

    def dialog_confirm(self, widget):
        pass        
        
    def on_close(self):
        print("closing server")
        super(MyApp, self).on_close()

    #this is required to override the BaseHTTPRequestHandler logger
    def log_message(self, *args, **kwargs):
        pass
        
if __name__ == "__main__":
    logging.getLogger('remi').setLevel(logging.WARNING)
    logging.getLogger('remi').disabled = True
    logging.getLogger('remi.server.ws').disabled = True
    logging.getLogger('remi.server').disabled = True
    logging.getLogger('remi.request').disabled = True
    start(MyApp, debug=False, address='0.0.0.0', port=8081, start_browser=False, multiple_instance=False)