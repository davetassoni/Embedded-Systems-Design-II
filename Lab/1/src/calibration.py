# Dr. Kaputa
# Edited by David Tassoni
# Lab 1

import sys
from PyQt4 import QtGui, QtCore

from globals import globals


class Calibration(QtGui.QWidget):
    def __init__(self, parent=None):
        super(Calibration, self).__init__(parent)

        self.labelrMinTitle = QtGui.QLabel(self)
        self.labelrMinTitle.setText("Red Minimum")
        self.rMin = QtGui.QSlider(QtCore.Qt.Horizontal, self)
        self.rMin.setSingleStep(1)
        self.rMin.setMinimum(0)
        self.rMin.setMaximum(255)
        self.rMin.valueChanged[int].connect(self.rMinChanged)
        self.rMinEdit = QtGui.QLineEdit(self)
        self.rMinEdit.returnPressed.connect(self.rMinEditChanged)
        self.rMinGroup = QtGui.QGroupBox()
        layoutrMin = QtGui.QHBoxLayout()
        layoutrMin.addWidget(self.labelrMinTitle)
        layoutrMin.addWidget(self.rMinEdit)
        layoutrMinVertical = QtGui.QVBoxLayout()
        layoutrMinVertical.addLayout(layoutrMin)
        layoutrMinVertical.addWidget(self.rMin)
        self.rMinGroup.setLayout(layoutrMinVertical)

        self.labelrMaxTitle = QtGui.QLabel(self)
        self.labelrMaxTitle.setText("Red Maximum")
        self.rMax = QtGui.QSlider(QtCore.Qt.Horizontal, self)
        self.rMax.setSingleStep(1)
        self.rMax.setMinimum(0)
        self.rMax.setMaximum(255)
        self.rMax.valueChanged[int].connect(self.rMaxChanged)
        self.rMaxEdit = QtGui.QLineEdit(self)
        self.rMaxEdit.returnPressed.connect(self.rMaxEditChanged)
        self.rMaxGroup = QtGui.QGroupBox()
        layoutrMax = QtGui.QHBoxLayout()
        layoutrMax.addWidget(self.labelrMaxTitle)
        layoutrMax.addWidget(self.rMaxEdit)
        layoutrMaxVertical = QtGui.QVBoxLayout()
        layoutrMaxVertical.addLayout(layoutrMax)
        layoutrMaxVertical.addWidget(self.rMax)
        self.rMaxGroup.setLayout(layoutrMaxVertical)

        self.labelgMinTitle = QtGui.QLabel(self)
        self.labelgMinTitle.setText("Green Minimum")
        self.gMin = QtGui.QSlider(QtCore.Qt.Horizontal, self)
        self.gMin.setSingleStep(1)
        self.gMin.setMinimum(0)
        self.gMin.setMaximum(255)
        self.gMin.valueChanged[int].connect(self.gMinChanged)
        self.gMinEdit = QtGui.QLineEdit(self)
        self.gMinEdit.returnPressed.connect(self.gMinEditChanged)
        self.gMinGroup = QtGui.QGroupBox()
        layoutgMin = QtGui.QHBoxLayout()
        layoutgMin.addWidget(self.labelgMinTitle)
        layoutgMin.addWidget(self.gMinEdit)
        layoutgMinVertical = QtGui.QVBoxLayout()
        layoutgMinVertical.addLayout(layoutgMin)
        layoutgMinVertical.addWidget(self.gMin)
        self.gMinGroup.setLayout(layoutgMinVertical)

        self.labelgMaxTitle = QtGui.QLabel(self)
        self.labelgMaxTitle.setText("Green Maximum")
        self.gMax = QtGui.QSlider(QtCore.Qt.Horizontal, self)
        self.gMax.setSingleStep(1)
        self.gMax.setMinimum(0)
        self.gMax.setMaximum(255)
        self.gMax.valueChanged[int].connect(self.gMaxChanged)
        self.gMaxEdit = QtGui.QLineEdit(self)
        self.gMaxEdit.returnPressed.connect(self.gMaxEditChanged)
        self.gMaxGroup = QtGui.QGroupBox()
        layoutgMax = QtGui.QHBoxLayout()
        layoutgMax.addWidget(self.labelgMaxTitle)
        layoutgMax.addWidget(self.gMaxEdit)
        layoutgMaxVertical = QtGui.QVBoxLayout()
        layoutgMaxVertical.addLayout(layoutgMax)
        layoutgMaxVertical.addWidget(self.gMax)
        self.gMaxGroup.setLayout(layoutgMaxVertical)

        self.labelbMinTitle = QtGui.QLabel(self)
        self.labelbMinTitle.setText("Blue Minimum")
        self.bMin = QtGui.QSlider(QtCore.Qt.Horizontal, self)
        self.bMin.setSingleStep(1)
        self.bMin.setMinimum(0)
        self.bMin.setMaximum(255)
        self.bMin.valueChanged[int].connect(self.bMinChanged)
        self.bMinEdit = QtGui.QLineEdit(self)
        self.bMinEdit.returnPressed.connect(self.bMinEditChanged)
        self.bMinGroup = QtGui.QGroupBox()
        layoutbMin = QtGui.QHBoxLayout()
        layoutbMin.addWidget(self.labelbMinTitle)
        layoutbMin.addWidget(self.bMinEdit)
        layoutbMinVertical = QtGui.QVBoxLayout()
        layoutbMinVertical.addLayout(layoutbMin)
        layoutbMinVertical.addWidget(self.bMin)
        self.bMinGroup.setLayout(layoutbMinVertical)

        self.labelbMaxTitle = QtGui.QLabel(self)
        self.labelbMaxTitle.setText("Blue Maximum")
        self.bMax = QtGui.QSlider(QtCore.Qt.Horizontal, self)
        self.bMax.setSingleStep(1)
        self.bMax.setMinimum(0)
        self.bMax.setMaximum(255)
        self.bMax.valueChanged[int].connect(self.bMaxChanged)
        self.bMaxEdit = QtGui.QLineEdit(self)
        self.bMaxEdit.returnPressed.connect(self.bMaxEditChanged)
        self.bMaxGroup = QtGui.QGroupBox()
        layoutbMax = QtGui.QHBoxLayout()
        layoutbMax.addWidget(self.labelbMaxTitle)
        layoutbMax.addWidget(self.bMaxEdit)
        layoutbMaxVertical = QtGui.QVBoxLayout()
        layoutbMaxVertical.addLayout(layoutbMax)
        layoutbMaxVertical.addWidget(self.bMax)
        self.bMaxGroup.setLayout(layoutbMaxVertical)

        self.activateFilter = QtGui.QPushButton("Activate Selected Filter", self)
        self.activateFilter.setCheckable(True)
        self.activateFilter.clicked[bool].connect(self.filters)

        # Requirement 2: "shall be able to select whether to detect a green or blue tennis ball"
        self.blueRadioButton = QtGui.QRadioButton("Detect Blue Tennis Ball")
        self.blueRadioButton.toggled.connect(lambda: self.checkRadioButton(self.blueRadioButton))

        self.greenRadioButton = QtGui.QRadioButton("Detect Green Tennis Ball")
        self.greenRadioButton.toggled.connect(lambda: self.checkRadioButton(self.greenRadioButton))

        # Requirement 3: "shall be able to save and load various parameters used for tennis ball detection from a configuration file"
        self.loadFileButton = QtGui.QPushButton("Load Configuration File")
        self.loadFileButton.clicked[bool].connect(self.loadFileButtonClicked)

        self.saveFileButton = QtGui.QPushButton("Save Configuration File")
        self.saveFileButton.clicked[bool].connect(self.saveFileButtonClicked)

        layout2 = QtGui.QHBoxLayout()
        layout2.addWidget(self.loadFileButton)
        layout2.addWidget(self.saveFileButton)
        layout3 = QtGui.QHBoxLayout()
        layout3.addWidget(self.blueRadioButton)
        layout3.addWidget(self.greenRadioButton)
        layout3.addWidget(self.activateFilter)
        layout = QtGui.QVBoxLayout()
        layout.addWidget(self.rMinGroup)
        layout.addWidget(self.rMaxGroup)
        layout.addWidget(self.gMinGroup)
        layout.addWidget(self.gMaxGroup)
        layout.addWidget(self.bMinGroup)
        layout.addWidget(self.bMaxGroup)

        layout.addLayout(layout3)
        layout.addLayout(layout2)
        self.setLayout(layout)

        # set some default values for the sliders
        self.rMin.setValue(1)
        self.rMax.setValue(255)
        self.bMin.setValue(1)
        self.bMax.setValue(255)
        self.gMin.setValue(1)
        self.gMax.setValue(255)

        self.show()

    ###############################################################################
    # link the edit boxes to the sliders
    ###############################################################################

    def rMinChanged(self, value):
        globals.rMin = value
        self.rMinEdit.setText(str(value))

    def rMinEditChanged(self):
        globals.rMin = float(self.rMinEdit.text())
        self.rMin.setValue(globals.rMin)

    def rMaxChanged(self, value):
        globals.rMax = value
        self.rMaxEdit.setText(str(value))

    def rMaxEditChanged(self):
        globals.rMax = float(self.rMaxEdit.text())
        self.rMax.setValue(globals.rMax)

    def gMinChanged(self, value):
        globals.gMin = value
        self.gMinEdit.setText(str(value))

    def gMinEditChanged(self):
        globals.gMin = float(self.gMinEdit.text())
        self.gMin.setValue(globals.gMin)

    def gMaxChanged(self, value):
        globals.gMax = value
        self.gMaxEdit.setText(str(value))

    def gMaxEditChanged(self):
        globals.gMax = float(self.gMaxEdit.text())
        self.gMax.setValue(globals.gMax)
        
    def bMinChanged(self, value):
        globals.bMin = value
        self.bMinEdit.setText(str(value))

    def bMinEditChanged(self):
        globals.bMin = float(self.bMinEdit.text())
        self.bMin.setValue(globals.bMin)

    def bMaxChanged(self, value):
        globals.bMax = value
        self.bMaxEdit.setText(str(value))

    def bMaxEditChanged(self):
        globals.bMax = float(self.bMaxEdit.text())
        self.bMax.setValue(globals.bMax)

    def filters(self, pressed):
        if pressed:
            self.rMin.setValue(globals.rMin)
            self.rMax.setValue(globals.rMax)
            self.gMin.setValue(globals.gMin)
            self.gMax.setValue(globals.gMax)
            self.bMin.setValue(globals.bMin)
            self.bMax.setValue(globals.bMax)
            globals.filterOption = 1
        pass

    def checkRadioButton(self, button):
    # Check which radio button is chosen, and load the associated RGB parameters
        if button.text() == "Detect Blue Tennis Ball":
            if button.isChecked():
                with open("parameters_blue.txt") as f:
                    globals.rMin = float(f.readline().split("= ")[1])
                    globals.rMax = float(f.readline().split("= ")[1])
                    globals.gMin = float(f.readline().split("= ")[1])
                    globals.gMax = float(f.readline().split("= ")[1])
                    globals.bMin = float(f.readline().split("= ")[1])
                    globals.bMax = float(f.readline().split("= ")[1])
                self.rMin.setValue(globals.rMin)
                self.rMax.setValue(globals.rMax)
                self.gMin.setValue(globals.gMin)
                self.gMax.setValue(globals.gMax)
                self.bMin.setValue(globals.bMin)
                self.bMax.setValue(globals.bMax)

            else:
                pass

        if button.text() == "Detect Green Tennis Ball":
            if button.isChecked():
                with open("parameters_green.txt") as f:
                    globals.rMin = float(f.readline().split("= ")[1])
                    globals.rMax = float(f.readline().split("= ")[1])
                    globals.gMin = float(f.readline().split("= ")[1])
                    globals.gMax = float(f.readline().split("= ")[1])
                    globals.bMin = float(f.readline().split("= ")[1])
                    globals.bMax = float(f.readline().split("= ")[1])
                self.rMin.setValue(globals.rMin)
                self.rMax.setValue(globals.rMax)
                self.gMin.setValue(globals.gMin)
                self.gMax.setValue(globals.gMax)
                self.bMin.setValue(globals.bMin)
                self.bMax.setValue(globals.bMax)
                
            else:
                pass

    ###############################################################################
    # save and load calibration files
    ###############################################################################
    def loadFileButtonClicked(self):
        fileName = QtGui.QFileDialog.getOpenFileName(None, "Select File", ".txt", "Text document (*.txt)")
        if not fileName:
            pass
        else:
            with open(fileName) as f:
                globals.rMin = float(f.readline().split("= ")[1])
                globals.rMax = float(f.readline().split("= ")[1])
                globals.gMin = float(f.readline().split("= ")[1])
                globals.gMax = float(f.readline().split("= ")[1])
                globals.bMin = float(f.readline().split("= ")[1])
                globals.bMax = float(f.readline().split("= ")[1])
            self.rMin.setValue(globals.rMin)
            self.rMax.setValue(globals.rMax)
            self.gMin.setValue(globals.gMin)
            self.gMax.setValue(globals.gMax)
            self.bMin.setValue(globals.bMin)
            self.bMax.setValue(globals.bMax)

    def saveFileButtonClicked(self):
        fileName = QtGui.QFileDialog.getSaveFileName(None, "Enter Filename", ".txt", "Text document (*.txt)")
        if fileName == "":
            return
        with open(fileName, "w") as f:
            f.write("rMin = " + str(globals.rMin) + "\n")
            f.write("rMax = " + str(globals.rMax) + "\n")
            f.write("gMin = " + str(globals.gMin) + "\n")
            f.write("gMax = " + str(globals.gMax) + "\n")
            f.write("bMin = " + str(globals.bMin) + "\n")
            f.write("bMax = " + str(globals.bMax))
