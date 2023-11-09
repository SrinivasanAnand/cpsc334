from musicpy import *

guitar = (C('CM7', 3, 1/4, 1/8)^2 |
          C('G7sus', 2, 1/4, 1/8)^2 |
          C('A7sus', 2, 1/4, 1/8)^2 |
          C('Em7', 2, 1/4, 1/8)^2 | 
          C('FM7', 2, 1/4, 1/8)^2 |
          C('CM7', 3, 1/4, 1/8)@1 |
          C('AbM7', 2, 1/4, 1/8)^2 |
          C('G7sus', 2, 1/4, 1/8)^2) * 2

#play(guitar, bpm=100, instrument=25)

a = C('Dmaj7') % (1/4,1/4) | C('Cmaj7') | C('Fadd9',3) | C('D#maj7',4) | (C('Dmaj7',3)/-2) % (5/4,)
b = chord('F#5, G5, A5, B5, G5', 1/8, 1/8)   
play(a & b, 140, instrument=1)