import tkinter as tk
from tkinter import filedialog
import serial
import time

root = tk.Tk()
root.withdraw()

 #import numpy as np
raw_path=filedialog.askopenfilename(filetypes=(("Image RGB3", ".raw_rgb3"),("Image RGB565", ".raw_rgb565"),("All files", "*.*")))
print("Массив:")
 #raw_rgb565=np.loadtxt(raw_path, delimiter=',', dtype=np.uint16)
 #print(raw_rgb565)
file = open(raw_path, 'r')
str_raw_rgb = file.read()
file.close()
str_raw_rgb='$'+str_raw_rgb+';'
print(str_raw_rgb)

print("Отправка...")
port='COM3'
sp = serial.Serial(port, baudrate=57600, bytesize=8, parity=serial.PARITY_NONE, stopbits=1, timeout = 1)
sp.close()
sp.open()
time.sleep(3)
sp.write(str_raw_rgb.encode())
print("Отправлено.")