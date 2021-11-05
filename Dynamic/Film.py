from Utilities import *


class Film:
    def __init__(self):
        self.year = 0
        self.title = ''
        pass

    def calculate(self):
        return self.year // len(self.title)

    def read(self, params):
        self.year = int(params[1])
        self.title = params[2]

    def to_string(self):
        return str(self.year) + ' ' + self.title

    def random(self):
        self.title = random_string()
        self.year = random_int(150) + 1900
