from pythonosc import dispatcher
from pythonosc import osc_server
import subprocess
import pyaudio
import wave
import sys
# Set the IP address and port for receiving OSC messages
receiver_ip = "127.0.0.1"
receiver_port = 57120

def play_wav(file_path):
    # Open the WAV file
    wave_file = wave.open(file_path, 'rb')

    # Initialize PyAudio
    p = pyaudio.PyAudio()

    # Open a stream
    stream = p.open(
        format=p.get_format_from_width(wave_file.getsampwidth()),
        channels=wave_file.getnchannels(),
        rate=wave_file.getframerate(),
        output=True,
        output_device_index=0
    )

    # Read data from the WAV file and play it
    data = wave_file.readframes(1024)
    while data:
        stream.write(data)
        data = wave_file.readframes(1024)

    # Cleanup
    stream.stop_stream()
    stream.close()
    p.terminate()
    wave_file.close()

def play_wav_with_aplay(file_path):
    try:
        # Run the aplay command in the terminal
        subprocess.run(["aplay", file_path], check=True)
    except subprocess.CalledProcessError as e:
        print(f"Error: {e}")

ghatam_file_prefix = "GhatamSample"
# Create a dispatcher to handle incoming OSC messages
def handler(index):
    sound_file = ghatam_file_prefix + str(args[0] + 1) + ".wav"
    play_wav_with_aplay(sound_file)

while True:
    for line in sys.stdin:
        print("received msg")
        handler(line)
