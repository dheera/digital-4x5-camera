#!/usr/bin/env python3
import numpy as np
import io
import cv2
import os
import random
import sys
import PIL.Image
import PIL.ExifTags

def parse_maker_note(maker_note):
    """Split the "maker note" EXIF field from a Raspberry Pi camera image into useful parameters"""
    camera_parameters = {}
    last_key = None
    for p in maker_note.decode().split(" "):
        # The maker note contains <thing>=<thing> entries, space delimited but with spaces in some values.
        # So, if there is an = then we assume we've got key=value, but if there is no = sign, we append
        # the current chunk to the latest value, because that's where it probably belongs...
        if "=" in p:
            last_key, v = p.split("=")
            camera_parameters[last_key] = v
        else:
            camera_parameters[last_key] += " " + p

    ccm_values = camera_parameters["ccm"].split(",")
    ccm_a = np.reshape(np.array(ccm_values[0:9], dtype = np.int32), (3,3))
    ccm_b = np.reshape(np.array(ccm_values[9:12], dtype = np.int32), (3,1))
    camera_parameters["ccm"] = (ccm_a, ccm_b)
    return camera_parameters

def downsample(array, factor):
    mod_0 = array.shape[0] % factor
    mod_1 = array.shape[1] % factor
    if mod_0 != 0:
        array = array[0:array.shape[0] - mod_0, :, :]
    if mod_1 != 0:
        array = array[:, 0:array.shape[1] - mod_1, :]

    print(array.shape)

    output = array[::factor, ::factor, :].copy()
    for i in range(factor - 1):
        for j in range(factor - 1):
            output += array[(i+1)::factor, (j+1)::factor, :]
    return output

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

def read_exif(fn):
    img = PIL.Image.open(fn)
    exif = {
        PIL.ExifTags.TAGS[k]: v
        for k, v in img._getexif().items()
        if k in PIL.ExifTags.TAGS
    }
    for k in exif:
        if type(exif[k]) is tuple and \
            len(exif[k]) == 2 and \
            type(exif[k][0]) is int and \
            type(exif[k][1]) is int:
            exif[k] = exif[k][0] / exif[k][1]
    exif["MakerNote"] = parse_maker_note(exif.get("MakerNote"))
    return exif

def superpixel_debayer(img):
    b = img[0::2, 0::2] << 1
    g = (img[1::2, 0::2] + img[0::2, 1::2])
    r = img[1::2, 1::2] << 1
    return np.dstack([b, g, r])

with open(os.path.join(os.path.dirname(__file__), "words.txt"), "r") as f:
    words = f.readlines()

def random_word():
    global words
    return random.choice(words).strip()
