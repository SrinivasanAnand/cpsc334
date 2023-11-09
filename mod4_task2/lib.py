import pyaudio

def play_note(wf, stream, note, duration=2):
    start_time = note * 2
    frame_start = int(start_time * wf.getframerate())
    frame_end = int((start_time + duration) * wf.getframerate())
    wf.setpos(frame_start)
    while wf.tell() < frame_end:
        data = wf.readframes(1024)  # Read and play 1024 frames at a time
        stream.write(data)

def read_serial_input(ser):
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
        button = int(chr(line[line_pos + 1]))
        switch = int(chr(line[line_pos + 3]))
        return pos, button, switch
    except:
        print("Error in converting read pos to string for pos: " + string_pos)
        return -1, -1, -1
    
def get_note_from_pos(pos):
    note = pos // 256
    if (note == 8):
        note = note - 1
    return note

def record(duration, fs):
    nsamples = duration*fs
    p = pyaudio.PyAudio()
    stream = p.open(format=pyaudio.paInt16, channels=1, rate=fs, input=True,
                    frames_per_buffer=nsamples)
    buffer = stream.read(nsamples)
    array = np.frombuffer(buffer, dtype='int16')
    stream.stop_stream()
    stream.close()
    p.terminate()
    return array
    

