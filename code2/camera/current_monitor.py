#!/usr/bin/env python3

import board
import busio
import adafruit_ina219
import time

i2c = busio.I2C(board.SCL, board.SDA)
ina219 = adafruit_ina219.INA219(i2c)

current_average = 0.0

while True:
    print(chr(27)+'[2j')
    print('\033c')
    print('\x1bc')
    print("Bus Voltage:   {} V".format(ina219.bus_voltage))
    #print("Shunt Voltage: {} mV".format(ina219.shunt_voltage / 1000))
    #print("Current:       {} mA".format(ina219.current))
    current = ina219.current
    voltage = ina219.bus_voltage

    current_average = 0.9*current_average + 0.1*current

    print("voltage: ", voltage)
    print("current: ", current)
    print("current_average:", current_average)
    time.sleep(0.1)
