import serial
import socket
from pythonosc import udp_client
from gpiozero import Button

switch = Button(21)

OFFSET = 48
ONE = 49
ser = serial.Serial('/dev/ttyUSB0')

localPort=8888
bufferSize=1024


#sock = socket.socket(socket.AF_INET,socket.SOCK_DGRAM)  ## Internet,UDP

# def get_ip_address():
#     """get host ip address"""
#     ip_address = '';
#     s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
#     s.connect(("8.8.8.8",80))
#     ip_address = s.getsockname()[0]
#     s.close()
#     return ip_address

# def init():
#     sock.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEPORT, 1)
#     sock.setsockopt(socket.SOL_SOCKET, socket.SO_BROADCAST, 1) #enable broadcasting mode
#     sock.bind(('', localPort))
#     print("UDP server : {}:{}".format(get_ip_address(),localPort))



sc_ip = "127.0.0.1"
sc_port = 57120
client = udp_client.SimpleUDPClient(sc_ip, sc_port)
address = '/aMessage'

count = 0

NUM_SENSORS = 4

on_list = []
for i in range(NUM_SENSORS):
    on_list.append(False)

def handle_piezo(reading, index, instrument):
    signal_check = 1 << index
    touch_detected = reading & signal_check > 0
    if (touch_detected and on_list[index]):
        return
    elif (on_list[index]):
        on_list[index] = False #reset if touch detected as Off
    elif (touch_detected):
        print(index)
        #on_list[index] = True
        client.send_message(address, [index, instrument])


last_state = switch.is_pressed
instrument = 0
num_instruments = 5
while True:
    line = ser.readline()
    if(switch.is_pressed != last_state):
        instrument = (instrument + 1) % num_instruments
        last_state = switch.is_pressed

    #line, addr = sock.recvfrom(1024)
    reading = int(line[0]) - OFFSET

    for i in range(NUM_SENSORS):
        handle_piezo(reading, i, instrument)
    




