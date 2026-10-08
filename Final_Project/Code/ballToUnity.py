# Dr. Kaputa
#simple python link to Unity

import time
import socket
import binascii
import struct
import sys
import mmap

packer = struct.Struct('f f f f f f f f')
host = '192.168.1.12'
port = 55001
f = open("/dev/mem", "r+b")
mem = mmap.mmap(f.fileno(), 1000, offset=0xfffc1000)

s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.connect((host,port))

while(True):
    mem.seek(0)
    x = struct.unpack('f', mem.read(4))[0]
    y = struct.unpack('f', mem.read(4))[0]
    z = struct.unpack('f', mem.read(4))[0]
    print "X: " + str(x) + " Y: " +str(y) + " Z: " + str(z)
    values = (640, 480, x,y,z,0,0,0)
    packed_data = packer.pack(*values)
    s.sendall(packed_data)
    time.sleep(1)
s.close()