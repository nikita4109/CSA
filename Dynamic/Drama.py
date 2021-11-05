from Film import Film
from Utilities import *


class Drama(Film):
    def __init__(self):
        super().__init__()
        self.director = ''

    def read(self, params):
        super().read(params)
        self.director = params[3]

    def to_string(self):
        return 'drama ' + super().to_string() + ' ' + self.director

    def random(self):
        super().random()
        self.director = random_string()
