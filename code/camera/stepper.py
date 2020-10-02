#!/usr/bin/env python3

from .Raspi_PWM_Servo_Driver import PWM
import atexit
import time
import redis

ADDR = 0x6f
PWM_FREQ = 1600

pwm = PWM(ADDR, debug=False)
pwm.setPWMFreq(PWM_FREQ)

class Stepper(object):
    def __init__(self, num, coil_mapping = (0, 1, 2, 3), delay = 0.0005, power = 127):
        self.num = num
        self.red = redis.Redis()
        self.phase_key = "phase_%d" % self.num
        self._pwm = pwm

        self.delay = delay

        if (num == 0):
            self.PWMA = 8
            self.AIN2 = 9
            self.AIN1 = 10
            self.PWMB = 13
            self.BIN2 = 12
            self.BIN1 = 11
        elif (num == 1):
            self.PWMA = 2
            self.AIN2 = 3
            self.AIN1 = 4
            self.PWMB = 7
            self.BIN2 = 6
            self.BIN1 = 5
        else:
            raise NameError('MotorHAT Stepper must be between 1 and 2 inclusive')

        self.step2coils = [
            [1, 0, 0, 0], 
            [1, 0, 1, 0], 
            [0, 0, 1, 0],
            [0, 1, 1, 0],
            [0, 1, 0, 0],
            [0, 1, 0, 1],
            [0, 0, 0, 1],
            [1, 0, 0, 1],
        ]

        #self.step2coils = [
        #    [1, 0, 1, 0], 
        #    [0, 1, 1, 0],
        #    [0, 1, 0, 1],
        #    [1, 0, 0, 1],
        #    [1, 0, 1, 0], 
        #    [0, 1, 1, 0],
        #    [0, 1, 0, 1],
        #    [1, 0, 0, 1],
        #]

        self.coil_mapping = coil_mapping

        self.current_step = int(self.red.get(self.phase_key) or 0)

        pwm_a = pwm_b = min(max(power * 16, 0), 0x0FFF)
        self._pwm.setPWM(self.PWMA, pwm_a)
        self._pwm.setPWM(self.PWMB, pwm_b)

    def __del__(self):
        self.off()

    def _setPin(self, pin, value):
        if (pin < 0) or (pin > 15):
            raise NameError('PWM pin must be between 0 and 15 inclusive')
        if (value != 0) and (value != 1):
            raise NameError('Pin value must be 0 or 1!')
        if (value == 0):
            self._pwm.setPWM(pin, 0)
        if (value == 1):
            self._pwm.setPWM(pin, 0xFFF)

    def off(self):
        self._setPin(self.AIN1, 0)
        self._setPin(self.AIN2, 0)
        self._setPin(self.BIN1, 0)
        self._setPin(self.BIN2, 0)

    def go(self, num_steps, delay = None):
        if delay is None:
            delay = self.delay

        sign = 1

        if num_steps < 0:
            num_steps = -num_steps
            sign = -1

        old_coils = [0, 0, 0, 0]

        for i in range(num_steps):
            #if i < 100:
            #    actual_delay = delay * (100 - i)
            #elif (num_steps - i) < 100:
            #    actual_delay = delay * (100 - (num_steps - i))
            #else:
            #    actual_delay = delay
            #print(actual_delay)

            self.current_step += sign
            coils = self.step2coils[self.current_step % 8]
            if coils[self.coil_mapping[0]] != old_coils[self.coil_mapping[0]]:
                self._setPin(self.AIN1, coils[self.coil_mapping[0]])
            if coils[self.coil_mapping[1]] != old_coils[self.coil_mapping[1]]:
                self._setPin(self.AIN2, coils[self.coil_mapping[1]])
            if coils[self.coil_mapping[2]] != old_coils[self.coil_mapping[2]]:
                self._setPin(self.BIN1, coils[self.coil_mapping[2]])
            if coils[self.coil_mapping[3]] != old_coils[self.coil_mapping[3]]:
                self._setPin(self.BIN2, coils[self.coil_mapping[3]])

            old_coils = coils
            time.sleep(delay)

        self.red.set(self.phase_key, str(self.current_step))

def turnOffMotors():
    global s
    s.off()

if __name__ == "__main__":
    atexit.register(turnOffMotors)
    s = Stepper(0, coil_mapping = (0, 1, 2, 3))
    s.go(2000)

