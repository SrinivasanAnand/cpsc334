import pyaudio
import wave
import sys
import serial
import threading
#import numpy as np
from lib import *

wf = wave.open("/Users/anandsrinivasan/cpsc334/mod4_task2/classic_electric_piano_chromatic.wav", 'rb')
p = pyaudio.PyAudio()
ser = serial.Serial('/dev/tty.usbserial-10')


button_val = False
switch_val = False
break_sig = False
playback = False
def get_keyboard_input():
    global button_val
    global switch_val
    global playback
    global break_sig
    while(True):
        button_input = input("")
        if (button_input == "p"):
            button_val = True
        elif (button_input == "s"):
            switch_val = not switch_val
            playback = False
        elif (button_input == "r"):
            playback = True
        elif (button_input == "b"):
            break_sig = True
            return
        else:
            button_val = False

#t1 = threading.Thread(target = get_keyboard_input)
#t1.start()

pos = -1
button = False
switch = False

def read_serial_input(ser):
    global pos
    global button
    global switch

    while(True):
        line = ser.readline()
        line_pos = 13
        string_pos = ""
        while(line_pos < len(line)):
            if line[line_pos] == 124:
                break
            else:
                string_pos += chr(line[line_pos])
            line_pos = line_pos + 1
        
        try:
            pos = int(string_pos)
            button_int = int(chr(line[line_pos + 1]))
            if (button_int == 0):
                button = False
            else:
                button = True
            switch_int = int(chr(line[line_pos + 3]))
            if (switch_int == 0):
                switch = False
            else:
                switch = True
        except:
            print("Error in converting read pos to string for pos: " + string_pos)
            pos = -1
            button = False
            switch = False
            #return -1, -1, -1

t1 = threading.Thread(target = read_serial_input, args=[ser])
t1.start()

chunk = 1024
framerate = wf.getframerate()

stream = p.open(format =
                p.get_format_from_width(wf.getsampwidth()),
                channels = wf.getnchannels(),
                rate = framerate,
                output = True)

playback_stream = p.open(format =
                p.get_format_from_width(wf.getsampwidth()),
                channels = wf.getnchannels(),
                rate = framerate,
                output = True)



playing_note = False
not_initialized = False
reached_end = False

current_note = -1
next_note = -1
frame_start = -1
frame_end = -1

count = 0
note_list = []
play_pos = 0

recording = []
recording_len = 0
recording_duration = 8
total_frames = int(recording_duration * framerate)
n_chunks = total_frames // chunk
print(n_chunks)

def playback():
    global recording
    global playback
    global switch
    playback = False    
    while(playback and switch):
        print("starting playback")
        for i in range(len(recording)):
            playback_stream.write(recording[i])


#recording_thread = threading.Thread(target=playback)
#recording_thread.start()

rewind = []
playback_mode = False
playback_pos = 0

started = False
detected_switch = False
data_null = True
count = 0

while(True):
    
    #print(pos)
    note = get_note_from_pos(pos)
    data = b'\x00\x00' * chunk

    # if (note == -1):
    #     print("continuing")
    #     continue

    if (switch):
        detected_switch = True
        continue
    if ((not switch) and detected_switch):
        print("Rewinding...")
        detected_switch = False
        playback_mode = True
        continue
    if (playback_mode):
        if (playback_pos < len(rewind)):
            playback_stream.write(rewind[playback_pos])
            playback_pos += 1
        else:
            playback_mode = False
            playback_pos = 0
        continue  

    if (button and (not playing_note) and (not reached_end)):
        not_initialized = True
        playing_note = True

    if (not_initialized):

        if (note == -1):
            continue
        current_note = note
        start_time = current_note * 2
        duration = 1.95
        frame_start = int(start_time * framerate)
        frame_end = int((start_time + duration) * framerate)
        wf.setpos(frame_start)

        not_initialized = False

    if (button == False):
        reached_end = False #reset so can play new note
    
    if (button and playing_note and (not reached_end)):
        data = wf.readframes(chunk)
        
        if (len(rewind) < n_chunks):
            rewind.append(data)
        else:
            rewind.pop(0)
            rewind.append(data)
        data_null = False

        stream.write(data)
        if (wf.tell() >= frame_end):
            playing_note = False
            reached_end = True
    else:
        playing_note = False
    
    # if (playback):
        # for i in range(len(recording)):
        #     playback_stream.write(recording[i])
    
    if (data_null):
        if (len(rewind) < n_chunks):
            rewind.append(data)
        else:
            rewind.pop(0)
            rewind.append(data)

    
    
    count = (count + 1) % 20
    # if (switch):
        
    #     if (recording_len < n_chunks):
    #         print("switch is on")
    #         recording.append(data)
    #         recording_len += 1
    #     else:
    #         playback = True
    #         ("playback set to true and switch is on")

    if (break_sig):
        break
    

    
    # if (len(note_list) == 0):
    #     note_list.append(note)
    
    # if (note != note_list[-1]):
    #     note_list.append(note)

    #print(note_list)
    #pos = int(string_pos)
    #print(pos)

# cleanup stuff.

t1.join()
wf.close()
stream.close()    
p.terminate()