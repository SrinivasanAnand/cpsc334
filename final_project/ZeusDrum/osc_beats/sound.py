import wave
import pyaudio
import subprocess


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

# Replace 'your_file.wav' with the path to your WAV file
def play_sound(file_path):
    try:
        # Run the aplay command in the terminal
        subprocess.run(["aplay", file_path], check=True)
    except subprocess.CalledProcessError as e:
        print(f"Error: {e}")

play_sound('GhatamSample1.wav')
