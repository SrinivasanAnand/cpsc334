from gpiozero import Button

switch = Button(21)
button = Button(7)
joystick = Button(8)


while True:
	if (switch.is_pressed):
		if (joystick.is_pressed):
			if (button.is_pressed):
				print("Mode 3")
		else:
			if (button.is_pressed):
				print("Mode 1")
		
	else:
		if (button.is_pressed):
			print("Mode 2")
	
