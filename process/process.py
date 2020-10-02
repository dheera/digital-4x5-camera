#!/usr/bin/env python3

import glob
import os
import sys
import cv2
import numpy as np
from helpers import *

image_files = []
nbounds = [-1, -1]

print("Reading file list ...")
for fn in os.listdir(sys.argv[1]):
    if not fn.endswith(".jpg"):
        continue
    if not fn.startswith("img_"):
        continue
    tokens = fn.replace("img_", "").replace(".jpg", "").split("_")
    if len(tokens) != 2:
        continue
    xn = int(tokens[0])
    yn = int(tokens[1])
    if xn > nbounds[0]:
        nbounds[0] = xn
    if yn > nbounds[1]:
        nbounds[1] = yn
    if -xn > nbounds[0]:
        nbounds[0] = -xn
    if -yn > nbounds[1]:
        nbounds[1] = -yn
    image_files.append(fn)

print("Checking completeness of file list ...")
for xn in range(-nbounds[0], nbounds[0]+1):
    for yn in range(-nbounds[1], nbounds[1]+1):
        assert("img_%d_%d.jpg" % (xn, yn) in image_files)

for xn in range(-nbounds[0], nbounds[0]+1):
    for yn in range(-nbounds[1], nbounds[1]+1):
        print("Processing (%d, %d)" % (xn, yn))
        data = read_raw(os.path.join(sys.argv[1], "img_%d_%d.jpg" % (xn, yn)))
        data = superpixel_debayer(data)
        print(data.shape)
        cv2.imshow("data", (data >> 4).astype(np.uint8))
        cv2.waitKey(0)
