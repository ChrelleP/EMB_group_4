import sys
from PyQt4.QtCore import Qt
from PyQt4.QtGui import *
import serial
import scipy.io.wavfile

class sliderdemo(QWidget):
   def __init__(self, parent = None):

      super(sliderdemo, self).__init__(parent)

      self.ser = serial.Serial('/dev/ttyUSB0', 3000000)
      layout = QVBoxLayout()
      self.l1 = QLabel("Set pwm freq")
      self.l1.setAlignment(Qt.AlignCenter)
      layout.addWidget(self.l1)

      self.button = QPushButton('Read Wave File', self)
      self.button.clicked.connect(self.handleButton)

      layout.addWidget(self.button)

      self.slPwm = QSlider(Qt.Horizontal)
      self.slPwm.setMinimum(0)
      self.slPwm.setMaximum(255)
      self.slPwm.setValue(0)
      self.slPwm.setTickPosition(QSlider.TicksBelow)
      self.slPwm.setTickInterval(1)

      layout.addWidget(self.slPwm)
      self.slPwm.valueChanged.connect(self.valuechangePWM)

      self.l2 = QLabel("Set freq")
      self.l2.setAlignment(Qt.AlignCenter)
      layout.addWidget(self.l2)

      self.slFreq = QSlider(Qt.Horizontal)
      self.slFreq.setMinimum(1)
      self.slFreq.setMaximum(100)
      self.slFreq.setValue(0)
      self.slFreq.setTickPosition(QSlider.TicksBelow)
      self.slFreq.setTickInterval(1)

      layout.addWidget(self.slState)

      self.l3 = QLabel("Set State")
      self.l3.setAlignment(Qt.AlignCenter)
      layout.addWidget(self.l3)

      self.slState = QSlider(Qt.Horizontal)
      self.slState.setMinimum(1)
      self.slState.setMaximum(4)
      self.slState.setValue(1)
      self.slState.setTickPosition(QSlider.TicksBelow)
      self.slState.setTickInterval(1)

      layout.addWidget(self.slFreq)

      self.slFreq.valueChanged.connect(self.valuechangeFreq)
      self.setLayout(layout)
      self.setWindowTitle("BLDC Controller")

   def valuechangePWM(self):
	pwm = int(self.slPwm.value())
        self.ser.write('#W:04' + str(hex(255-pwm)[2:].zfill(8)) + '\r\n')

   def valuechangeFreq(self):
	freq = int(self.slFreq.value())
	print freq
	prescaler = (200*10**6)/(freq*6*7*2)
        self.ser.write('#W:05' + str(hex(prescaler)[2:].zfill(8)) + '\r\n')
        #print '#W:05' + str(hex(prescaler)[2:].zfill(8))
   def handleButton(self):
	self.button.setStyleSheet("background-color: green")
	print 'Loading WAV file...'
        rate, data = scipy.io.wavfile.read('beep.wav')
	print 'Done!'

	print 'Normalizing...'
	max_val = max(data.max(axis = 0), abs(data.min(axis = 0)))
	print max_val
    	for i in range(0,data.size):
		data[i] = data[i] * 10 / float(max_val)
	print 'Done!'

def main():
   app = QApplication(sys.argv)
   ex = sliderdemo()
   ex.show()
   sys.exit(app.exec_())

if __name__ == '__main__':
   main()
