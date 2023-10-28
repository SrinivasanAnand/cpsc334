import pygame

vol = 0.5
pygame.init()
pygame.mixer.init()

pygame.mixer.music.load('fireplace.aiff')
pygame.mixer.music.set_volume(vol)
pygame.mixer.music.play(loops=-1)

while True: 
      
    query = input("  ") 
      
    if query == 'p': 
        pygame.mixer.music.pause()      
    elif query == 'r': 
        pygame.mixer.music.unpause() 
    elif query == 'i':
        vol += 0.1
        pygame.mixer.music.set_volume(vol)
    elif query == 'd':
        vol -= 0.1
        pygame.mixer.music.set_volume(vol)
    elif query == 'e': 
        pygame.mixer.music.stop() 
        break
