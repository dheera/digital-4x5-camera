from .stepper import Stepper
import redis

class CalibratedStepper(Stepper):
    def __init__(self, num, coil_mapping = (0, 1, 2, 3), delay = 0.0005, power = 63, limit_min = 0, limit_max = 40000):
        super().__init__(num, coil_mapping = coil_mapping, delay = delay, power = power)
        self.red = redis.Redis()
        self.pos_key = "step_%d" % self.num
        self.limit_min = limit_min
        self.limit_max = limit_max

    def zero(self):
        self.red.set(self.pos_key, str(0))

    def goto(self, target):
        target = max(min(target, self.limit_max), self.limit_min)
        diff = target - int(self.red.get(self.pos_key))
        self.go(diff)
        self.red.set(self.pos_key, str(target))
