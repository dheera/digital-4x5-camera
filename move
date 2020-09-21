#!/usr/bin/env python3

import atexit
import sys
from stepper import Stepper

if __name__ == "__main__":
    axis = int(sys.argv[1])
    steps = int(sys.argv[2])
    s = Stepper(axis, coil_mapping = (0, 1, 2, 3), power = 63)
    atexit.register(lambda: s.off())
    s.go(steps)

