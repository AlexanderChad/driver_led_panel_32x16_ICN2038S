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

raw_rgb565 = np.empty((32,16),dtype=('uint16'))
for yi in range(y):
    for xi in range(x):
        r, g, b = obj[xi,yi]
        raw_rgb565[xi][yi]=((r & 0b11111000) << 8) | ((g & 0b11111100) << 3) | (b >> 3)
		
img.show()

print("Массив rgb565:")
print(raw_rgb565)
raw_path=img_path+'.raw_rgb565'

file = open(raw_path, 'w')


for j in range(y):
    for i in range(x):
        if ((j==0)&(i==0)) :
            file.write(str(raw_rgb565[i,j]))
        else :
            file.write(','+str(raw_rgb565[i,j]))
file.close()
print("Сохранено в файл: ", raw_path)

raw_path=img_path+'.toArd'
file = open(raw_path, 'w')
for i in range(x):
    for j in range(y):
        if ((j==0)&(i==0)) :
            file.write(str(raw_rgb565[i,j]))
        else :
            file.write(','+str(raw_rgb565[i,j]))
file.close()
print("Сохранено в файл: ", raw_path)