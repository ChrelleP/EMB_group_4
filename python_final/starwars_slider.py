import sys
from PyQt4.QtCore import Qt,QTimer
from PyQt4.QtGui import *
from time import sleep
import serial
import scipy.io.wavfile


class sliderdemo(QWidget):
   def __init__(self, parent = None):

      super(sliderdemo, self).__init__(parent)

      self.tone_starwars = [ (165,500), (1.0,150), (165,500),(1.0,150), (165,500),(1.0,150), (123,350),(1.0,150), (196,150),(1.0,50) ,(165,500),(1.0,150),(123,350),(1.0,150), (196,150),(1.0,50), (165,1000),(1.0,150) ]

      self.ser = serial.Serial('/dev/ttyUSB0', 3000000)
      layout = QVBoxLayout()

      # BUTTON FOR LOADING WAV FILE
      self.button_load = QPushButton('Read Wave File', self)
      self.button_load.clicked.connect(self.handleButton_load)
      layout.addWidget(self.button_load)

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

      # SLIDER FOR DURATION

      self.l3 = QLabel("Set freq. duration")
      self.l3.setAlignment(Qt.AlignCenter)
      layout.addWidget(self.l3)


      self.slDuration = QSlider(Qt.Horizontal)
      self.slDuration.setMinimum(0)
      self.slDuration.setMaximum(2000)
      self.slDuration.setValue(400)
      self.slDuration.setTickPosition(QSlider.TicksBelow)
      self.slDuration.setTickInterval(1)

      layout.addWidget(self.slDuration)
      self.slDuration.valueChanged.connect(self.valuechangeDuration)


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


      # Play sequence
      self.button_play = QPushButton('Play sequence', self)
      self.button_play.clicked.connect(self.handleButton_play)
      layout.addWidget(self.button_play)


      # Create a QTimer
      self.timer = QTimer()	
      # Connect it to f
      # Call f() every 5 seconds
#      self.timer.start()

      self.timer.timeout.connect(self.duration_callback)

      # SET LAYOUT
      self.setLayout(layout)
      self.setWindowTitle("BLDC Controller")

   def handleButton_play(self):
       print "Playing sequence"
       for tone in self.tone_starwars:
		freq, duration = tone
		freq = freq*2/(6*7)
		prescaler = (200*10**6)/(freq*6*7*2)

	        self.ser.write('#W:05' + str(hex(int(prescaler))[2:].zfill(8)) + '\r\n')
		sleep(duration*0.001)

   def duration_callback(self):
       print "ok"

   def valuechangeDuration(self):
       duration = int( self.slDuration.value() )
       print "duration: ", duration
       self.timer.start(duration)

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
        rate, data = scipy.io.wavfile.read('beep.wav')
	print 'Done!'

	print 'Normalizing...'
	max_val = max(data.max(axis = 0), abs(data.min(axis = 0)))
	print max_val
    	for i in range(0,data.size):
		data[i] = data[i] * 10 / float(max_val)
	print 'Done!'
   def handleButton_mode(self):
	identifier = int(self.sender().objectName())
        self.ser.write('#W:06' + str(hex(identifier)[2:].zfill(8)) + '\r\n')
	
	

def main():
   app = QApplication(sys.argv)
   ex = sliderdemo()
   ex.show()
   sys.exit(app.exec_())

if __name__ == '__main__':
   main()
