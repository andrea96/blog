from sys import argv
from PIL import Image
from math import sin, cos, pi
import random


def choosePoint(commit):
    r = 0.7885
    a = (int(commit[:20], 16) / (2**80-1)) * 2 * pi
    return r*cos(a), r*sin(a)

def main(commit): 
    w, h, zoom = 640,400,1
    bitmap = Image.new("RGB", (w, h), "white") 
    pix = bitmap.load() 
    cX, cY = choosePoint(commit)
    moveX, moveY = 0.0, 0.0
    maxIter = 300
    k = int(int(commit[:20], 16) / (2**80-1) * 20) + 10
   
    for x in range(w): 
        for y in range(h): 
            zx = 1.5*(x - w/2)/(0.5*zoom*w) + moveX 
            zy = 1.0*(y - h/2)/(0.5*zoom*h) + moveY 
            i = maxIter 
            while zx*zx + zy*zy < 4 and i > 1: 
                tmp = zx*zx - zy*zy + cX 
                zy,zx = 2.0*zx*zy + cY, tmp 
                i -= 1

            pix[x,y] = (i << k) + (i << (k-10)) + i*8
  
    bitmap.save(f'public/images/julia.png') 


if __name__ == '__main__' and len(argv) == 2:
    main(hex(random.getrandbits(160))[2:])
    #main(argv[1])
else:
    print('No commit hash provided')
    exit(-1)
