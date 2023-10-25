import serial

ser = serial.Serial('/dev/tty.usbserial-10', 9600)

while True:
    readedText = ser.readline()
    print(readedText)
ser.close()
