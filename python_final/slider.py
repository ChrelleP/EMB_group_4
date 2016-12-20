import sys
from PyQt4.QtCore import Qt
from PyQt4.QtGui import *
import serial
import scipy.io.wavfile
import time

class sliderdemo(QWidget):
   def __init__(self, parent = None):

      super(sliderdemo, self).__init__(parent)

#      self.ser = serial.Serial('/dev/ttyUSB0', 3000000)
      layout = QVBoxLayout()
      layout = QHBoxLayout()
      # BUTTON FOR LOADING WAV FILE
      self.button_load = QPushButton('Read Wave File', self)
      self.button_load.clicked.connect(self.handleButton_load)
      layout.addWidget(self.button_load)

      # BUTTON FOR PLAYING WAV FILE
      self.button_play = QPushButton('Play Wave File', self)
      self.button_play.clicked.connect(self.handleButton_play)
      layout.addWidget(self.button_play)

      # SLIDER FOR PWM
      self.l1 = QLabel("Set pwm freq")
      self.l1.setAlignment(Qt.AlignCenter)
      layout.addWidget(self.l1)

      self.slPwm = QSlider(Qt.Horizontal)
      self.slPwm.setMinimum(0)
      self.slPwm.setMaximum(255)
      self.slPwm.setValue(0)
      self.slPwm.setTickPosition(QSlider.TicksBelow)
      self.slPwm.setTickInterval(1)

      layout.addWidget(self.slPwm)
      self.slPwm.valueChanged.connect(self.valuechangePWM)

      # SLIDER FOR FREQUENCE
      self.l2 = QLabel("Set freq")
      self.l2.setAlignment(Qt.AlignCenter)
      layout.addWidget(self.l2)

      self.slFreq = QSlider(Qt.Horizontal)
      self.slFreq.setMinimum(1)
      self.slFreq.setMaximum(100)
      self.slFreq.setValue(0)
      self.slFreq.setTickPosition(QSlider.TicksBelow)
      self.slFreq.setTickInterval(1)

      layout.addWidget(self.slFreq)
      self.slFreq.valueChanged.connect(self.valuechangeFreq)

      # FOUR BUTTONS FOR MODES
      self.button_mode1 = QPushButton('Mode 1', self)
      self.button_mode1.setObjectName('0')
      self.button_mode1.clicked.connect(self.handleButton_mode)
      layout.addWidget(self.button_mode1)
      self.button_mode2 = QPushButton('Mode 2', self)
      self.button_mode2.setObjectName('1')
      self.button_mode2.clicked.connect(self.handleButton_mode)
      layout.addWidget(self.button_mode2)
      self.button_mode3 = QPushButton('Mode 3', self)
      self.button_mode3.setObjectName('2')
      self.button_mode3.clicked.connect(self.handleButton_mode)
      layout.addWidget(self.button_mode3)
      self.button_mode4 = QPushButton('Mode 4', self)
      self.button_mode4.setObjectName('3')
      self.button_mode4.clicked.connect(self.handleButton_mode)
      layout.addWidget(self.button_mode4)

      # SET LAYOUT
      self.setLayout(layout)
      self.setWindowTitle("BLDC Controller")

      # DECLARE DATA
      self.data = {}
      self.rate = 0

   def valuechangePWM(self):
    pwm = int(self.slPwm.value())
    self.ser.write('#W:04' + str(hex(255-pwm)[2:].zfill(8)) + '\r\n')

   def valuechangeFreq(self):
    freq = int(self.slFreq.value())
    print freq
    prescaler = (200*10**6)/(freq*6*7*2)
    self.ser.write('#W:05' + str(hex(prescaler)[2:].zfill(8)) + '\r\n')
    #print '#W:05' + str(hex(prescaler)[2:].zfill(8))

   def handleButton_load(self):
    self.button_load.setStyleSheet("background-color: green")
    print 'Loading WAV file...'
    wav_rate, wav_data = scipy.io.wavfile.read('modified.wav')
    print wav_rate

    print 'Normalizing...'
    max_val = max(wav_data.max(axis = 0), abs(wav_data.min(axis = 0)))
    for i in range(0,wav_data.size):
        wav_data[i] = wav_data[i] * 255 / float(max_val)

    self.data = wav_data
    self.rate = wav_rate
    print 'Done!'

   def handleButton_mode(self):
    identifier = int(self.sender().objectName())
    self.ser.write('#W:06' + str(hex(identifier)[2:].zfill(8)) + '\r\n')

   def handleButton_play(self):
    for i in range(0, self.data.size):
      if self.data[i] < 0:
          #print '#W:07' + '1'.zfill(6) + str(hex(255 - abs(self.data[i]))[2:]).zfill(2)  + '\r\n'
          self.ser.write('#W:07' + '1'.zfill(6) + str(hex(abs(self.data[i]))[2:]).zfill(2)  + '\r\n')
      else:
          #print '#W:07' + '0'.zfill(6) + str(hex(abs(self.data[i]))[2:]).zfill(2)  + '\r\n'
          self.ser.write('#W:07' + '0'.zfill(6) + str(hex(abs(self.data[i]))[2:]).zfill(2)  + '\r\n')
      time.sleep(1/self.rate)


def main():
   app = QApplication(sys.argv)
   ex = sliderdemo()
   ex.show()
   sys.exit(app.exec_())

if __name__ == '__main__':
   main()
