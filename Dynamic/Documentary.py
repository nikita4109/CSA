from Film import Film
from Utilities import *


class Documentary(Film):
    def __init__(self):
        super().__init__()
        self.duration = 0

    def read(self, params):
        super().read(params)
        self.duration = int(params[3])

    def to_string(self):
        return 'documentary ' + super().to_string() + ' ' + str(self.duration)

    def random(self):
        super().random()
        self.duration = random_int(400)
