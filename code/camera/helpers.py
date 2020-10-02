#!/usr/bin/env python3
import numpy as np
import io
import cv2
import sys

img = sys.argv[1]

def read_raw(fn):
    file = open(fn, 'rb')
    file_stream = io.BytesIO(file.read())
    offset = 18711040 # pi hq cam
    reshape, crop = (3056, 6112), (3040, 6084) # pi hq cam
    data = file_stream.getvalue()[-offset:]
    assert data[:4] == 'BRCM'.encode("ascii")
    data = data[32768:]
    data = np.frombuffer(data, dtype=np.uint8)
    data = data.reshape(reshape)[:crop[0], :crop[1]]
    data = data.astype(np.uint16)
    shape = data.shape
    unpacked_data = np.zeros((shape[0], int(shape[1] / 3 * 2)), dtype=np.uint16)
    unpacked_data[:, ::2] = (data[:, ::3] << 4) + (data[:, 2::3] & 0x0F)
    unpacked_data[:, 1::2] = (data[:, 1::3] << 4) + ((data[:, 2::3] >> 4) & 0x0F)
    data = unpacked_data
    return data

def superpixel_debayer(img):
    b = img[0::2, 0::2] << 1
    g = img[1::2, 0::2] + img[0::2, 1::2]
    r = img[1::2, 1::2] << 1
    return np.dstack([b, g, r])
