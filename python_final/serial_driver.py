import time
import serial

# configure the serial connections (the parameters differs on the device you are connecting to)
ser = serial.Serial('/dev/ttyUSB0', 3000000)
#    parity=serial.PARITY_ODD,
#    stopbits=serial.STOPBITS_TWO,
#    bytesize=serial.SEVENBITS
#)

ser.isOpen()

print '\r\nEnter your commands below.\r\nInsert "exit" to leave the application.\r\n'
print 'For PWM control press <1> and then press the PWM (0-255).'

while 1 :

    # get keyboard input
    input = raw_input(">> ")
    print input
        # Python 3 users
         #input = input(">> ")
    if input == 'exit':
        ser.close()
        exit()
    elif input == '1':
        input = raw_input(">> ")

        if int(input) > 255:
            print "PWM command out of bounds"
            input = '255'
        elif int(input) < 0:
            print "PWM command out of bounds"
            input = '0'

        ser.write('#W:04' + str(hex(int(255-int(input)))[2:].zfill(8)) + '\r\n')

        #print input
        # send the character to the device
        # (note that I happend a \r\n carriage return and line feed to the characters - this is requested by my device)

        #out = '#W:04' + str(hex(int(input))[2:].zfill(8)) + '\r\n'
        #print out

        # Writes the PWM command to address 4
    elif input == '2':
        print "ok"
        for i in range (0,75):
            output = 255 -i
            print output
            ser.write('#W:04' + str(hex(output)[2:].zfill(8)) + '\r\n')
            time.sleep(0.5)
        print "Sent command of PWM = " + input + " Sent, press <1> again for new PWM command"
        out = ''
        # let's wait one second before reading output (let's give device time to answer)
        time.sleep(1)
        while ser.inWaiting() > 0:
            out += ser.read(1)

        if out != '':
            print ">>" + out
