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


button = False
switch = False
break_sig = False
playback = False
def get_button_input():
    global button
    global switch
    global playback
    global break_sig
    while(True):
        button_input = input("")
        if (button_input == "p"):
            button = True
        elif (button_input == "s"):
            switch = not switch
            playback = False
        elif (button_input == "r"):
            playback = True
        elif (button_input == "b"):
            break_sig = True
            return
        else:
            button = False

t1 = threading.Thread(target = get_button_input)
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

def playback():    
    while(playback and switch):
        for i in range(len(recording)):
            playback_stream.write(recording[i])


recording_thread = threading.Thread(target=playback)
recording_thread.start()
started = False

while(True):
    
    # maybe do this in a thread
    (pos, button_val, switch_val) = read_serial_input(ser)
    #print(button_val)
    note = get_note_from_pos(pos)
    data = b'\x00\x00' * chunk

    # if (note == -1):
    #     print("continuing")
    #     continue

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
        stream.write(data)
        if (wf.tell() >= frame_end):
            playing_note = False
            reached_end = True
    else:
        playing_note = False
    
    # if (playback):
        # for i in range(len(recording)):
        #     playback_stream.write(recording[i])
    
    if (switch):
        if (recording_len < n_chunks):
            recording.append(data)
            recording_len += 1

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