from Film import Film
from Utilities import *


class Cartoon(Film):
    def __init__(self):
        super().__init__()
        self.animation = ''

    def read(self, params):
        super().read(params)
        self.animation = params[3]

    def to_string(self):
        return 'cartoon ' + super().to_string() + ' ' + self.animation

    def random(self):
        super().random()

        animation_type = random_int(3)
        if animation_type == 0:
            self.animation = 'stopmotion'
        elif animation_type == 1:
            self.animation = 'claymotion'
        else:
            self.animation = 'animation'
