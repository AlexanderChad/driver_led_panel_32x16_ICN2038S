import tkinter as tk
from tkinter import filedialog
import numpy as np
from PIL import Image

root = tk.Tk()
root.withdraw()

img_path=filedialog.askopenfilename(filetypes=(("Image files", "*.png;*.jpg;*.jpeg;*.bmp"),("All files", "*.*")))
img = Image.open(img_path)
x, y = img.size
obj = img.load()

raw_rgb3 = np.zeros((32,16),dtype=('uint8'))
raw_rgb3_uint32 = np.zeros((3,16),dtype=('uint32'))
for yi in range(y):
    for xi in range(x):
        r, g, b = obj[xi,yi]
        obj[xi,yi] = ((r>0)*255,(g>0)*255,(b>0)*255)
        raw_rgb3[xi][yi]=((r & 0b11111000) > 0) << 2 | ((g & 0b11111100) > 0) << 1 | (b > 0)
        if (r>0):
            raw_rgb3_uint32[0][yi]=raw_rgb3_uint32[0][yi]|(1 << xi)
        if (g>0):
            raw_rgb3_uint32[1][yi]=raw_rgb3_uint32[1][yi]|(1 << xi)
        if (b>0):
            raw_rgb3_uint32[2][yi]=raw_rgb3_uint32[2][yi]|(1 << xi)


img.show()

print("Массив rgb3:")
print(raw_rgb3)
raw_path=img_path+'.raw_rgb3'

file = open(raw_path, 'w')


for j in range(y):
    for i in range(x):
        if ((j==0)&(i==0)) :
            file.write(str(raw_rgb3[i,j]))
        else :
            file.write(','+str(raw_rgb3[i,j]))
file.close()
print("Сохранено в файл: ", raw_path)

raw_path=img_path+'.toArd3'
file = open(raw_path, 'w')
for i in range(x):
    for j in range(y):
        if ((j==0)&(i==0)) :
            file.write(str(raw_rgb3[i,j]))
        else :
            file.write(','+str(raw_rgb3[i,j]))
file.close()
print("Сохранено в файл: ", raw_path)


raw_path=img_path+'.toSTM8_3bit'
print("Массив rgb3 для stm8:")
for i in range(3):
    print('\n')
    for j in range(16):
        print(str(format(raw_rgb3_uint32[i,j], 'b')))

file = open(raw_path, 'w')
for i in range(3):
    for j in range(16):
        if ((j==0)&(i==0)) :
            file.write(str(raw_rgb3_uint32[i,j]))
        else :
            file.write(','+str(raw_rgb3_uint32[i,j]))
file.close()
print("Сохранено в файл: ", raw_path)