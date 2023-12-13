from pythonosc import dispatcher
from pythonosc import osc_server
import subprocess
import pyaudio
import wave
from gpiozero import Button

switch = Button(21)

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
prefix_list = [ghatam_file_prefix]
# Create a dispatcher to handle incoming OSC messages
def handler(address, *args):
    print(f"Received OSC message from {address}: {args}")
    sound_file = prefix_list[args[1]] + str(args[0] + 1) + ".wav"
    play_wav_with_aplay(sound_file)

dispatcher_instance = dispatcher.Dispatcher()
dispatcher_instance.map("/aMessage", handler)

# Create an OSC server and start listening for messages
server = osc_server.ThreadingOSCUDPServer((receiver_ip, receiver_port), dispatcher_instance)
print(f"Listening for OSC messages on {receiver_ip}:{receiver_port}")
server.serve_forever()
