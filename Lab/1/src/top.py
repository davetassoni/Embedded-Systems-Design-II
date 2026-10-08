# Dr. Kaputa
# PyQt4 OpenCV Integration
# Edited by David Tassoni
# ESDII Lab 1

import sys
from PyQt4.QtGui import *
from PyQt4.QtCore import *
from faceTracker import *
from calibration import *
from globals import globals

# main window class that holds everything
class MainWindow(QMainWindow):
    def __init__(self):
        super(MainWindow, self).__init__()

        self.setWindowTitle("ESDII: Lab 1 Tennis Ball Detection")
        self.settings = QSettings("RIT", "DTassoni")

            # instantiate the dock widgets
        self.faceTracker = FaceTrackerHolder(self)
        self.calibration = Calibration(self)

        # load in the docks
        self.setupDocks()

        # load in the style sheet
        styleFile = "styleSheet.txt"
        with open(styleFile, "r") as fh:
            self.setStyleSheet(fh.read())

        # restore dock locations
        if self.settings.value("state"):
            self.restoreGeometry(self.settings.value("geometry").toByteArray())
            self.restoreState(self.settings.value("state").toByteArray())
            self.move(self.settings.value("windowPos", QVariant(QPoint(40, 40))).toPoint())
            self.resize(self.settings.value("windowSize", QVariant(QSize(400, 400))).toSize())
            self.setWindowState(Qt.WindowState(self.settings.value("windowState").toInt()[0]))

    def setupDocks(self):
        
        self.faceTrackerDock = QDockWidget(self)
        self.faceTrackerDock.setWidget(self.faceTracker)
        self.faceTrackerDock.setWindowTitle("Image")
        self.faceTrackerDock.setObjectName("Image")
        self.faceTrackerDock.setContentsMargins(0, 0, 0, 0)
        self.faceTrackerDock.setFeatures(QDockWidget.AllDockWidgetFeatures)
        self.faceTrackerDock.setAllowedAreas(Qt.AllDockWidgetAreas)
        self.addDockWidget(Qt.LeftDockWidgetArea, self.faceTrackerDock)

        self.calibrationDock = QDockWidget(self)
        self.calibrationDock.setWidget(self.calibration)
        self.calibrationDock.setWindowTitle("Filter Settings")
        self.calibrationDock.setObjectName("Filter Settings")
        self.calibrationDock.setContentsMargins(0, 0, 0, 0)
        self.calibrationDock.setFeatures(QDockWidget.AllDockWidgetFeatures)
        self.calibrationDock.setAllowedAreas(Qt.AllDockWidgetAreas)
        self.addDockWidget(Qt.LeftDockWidgetArea, self.calibrationDock)

        # Requirement 1: "shall be able to load in various images via a file menu"
        loadAction = QtGui.QAction(QtGui.QIcon('open.png'), '&Open Image', self)
        loadAction.setShortcut('Ctrl+O')
        loadAction.setStatusTip('Select Image to open')
        loadAction.triggered.connect(self.openImage)
        
        exitAction = QtGui.QAction(QtGui.QIcon('quit.png'), '&Quit Application', self)
        exitAction.setShortcut('Ctrl+Q')
        exitAction.setStatusTip('Quit application')
        exitAction.triggered.connect(QtGui.qApp.quit)
        
        menubar = self.menuBar()
        fileMenu = menubar.addMenu("File")
        fileMenu.addAction(loadAction)
        fileMenu.addAction(exitAction)
        
        DOCKOPTIONS = QMainWindow.AllowTabbedDocks
        DOCKOPTIONS = DOCKOPTIONS | QMainWindow.AllowNestedDocks
        DOCKOPTIONS = DOCKOPTIONS | QMainWindow.AnimatedDocks
        self.setDockOptions(DOCKOPTIONS)
        self.setTabPosition(Qt.AllDockWidgetAreas, QTabWidget.North)
        
        self.show()

    def closeEvent(self, event):
        self.settings.setValue('geometry', self.saveGeometry())
        self.settings.setValue('state', self.saveState())
        self.settings.setValue("windowState", QVariant(self.windowState()))
        self.settings.setValue("windowSize", QVariant(self.size()))
        self.settings.setValue("windowPos", QVariant(self.pos()))
        self.settings.sync()
        QMainWindow.closeEvent(self, event)

    def openImage(self):
        fileName = QtGui.QFileDialog.getOpenFileName(self, "Select Image", "", "Image File (*.jpg)")
        if not fileName:
            pass
        else:
            globals.image_filepath = fileName
            
# start of the program that instantiates a MainWindow class
def main():
    app = QApplication(sys.argv)
    mainWindow = MainWindow()
    sys.exit(app.exec_())

if __name__ == '__main__':
    main()
