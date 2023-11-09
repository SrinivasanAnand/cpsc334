import pyaudio
from pydub import AudioSegment
from pydub.generators import Sine

# Create an audio segment (e.g., note_A as defined in the previous code)
# ...

def play_audio(audio_segment):
    chunk = 1024
    p = pyaudio.PyAudio()
    stream = p.open(format=p.get_format_from_width(audio_segment.sample_width),
                    channels=audio_segment.channels,
                    rate=audio_segment.frame_rate,
                    output=True)
    data = audio_segment.raw_data
    stream.write(data)
    stream.stop_stream()
    stream.close()
    p.terminate()


#soundfont_file = "/Users/anandsrinivasan/cpsc334/mod4_task2/198_Hot_Saxophone_VS!.sf2"

note_A = Sine(440)
note_B = Sine(493.88)  # 493.88 Hz for note B
note_C = Sine(523.25)  # 523.25 Hz for note C
note_D = Sine(587.33)
note_E = Sine(659.25)
note_F = Sine(698.46)
note_G = Sine(783.99)
note_A_high = Sine(880)

scale = [note_A, note_B, note_C, note_D, note_E, note_F, note_G, note_A_high]

note_duration = 500
audio_A = note_A.to_audio_segment(duration=note_duration)
audio_B = note_B.to_audio_segment(duration=note_duration)
audio_C = note_C.to_audio_segment(duration=note_duration)


#soundfont = AudioSegment.from_file(soundfont_file, format="sf2")

# Define a melody with instrument sounds
melody = [
    (60, 500),  # Note C4 for 500 milliseconds
    (64, 500),  # Note E4 for 500 milliseconds
    (67, 500),  # Note G4 for 500 milliseconds
    (60, 500),  # Note C4 for 500 milliseconds
]


p = pyaudio.PyAudio()
stream = p.open(format=p.get_format_from_width(audio_A.sample_width),
                channels=audio_A.channels,
                rate=audio_A.frame_rate,
                output=True)


for note in scale:
    stream.write((note.to_audio_segment(duration=note_duration)).raw_data)

# count = 10
# while(count > 0):
#     if (count % 2 == 0):
#         note = audio_A.raw_data
#     else:
#         note = audio_B.raw_data
#     stream.write(note)
#     count -= 1

stream.stop_stream()
stream.close()
p.terminate()
