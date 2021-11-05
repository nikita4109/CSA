from Drama import Drama
from Cartoon import Cartoon
from Documentary import Documentary
from Utilities import random_int


class Container:
    def __init__(self, length):
        self.length = length
        self.films = list()

    @staticmethod
    def read(file):
        length = int(file.readline())
        container = Container(length)

        for i in range(0, length):
            params = file.readline().split()
            if params[0] == 'drama':
                film = Drama()
            elif params[0] == 'cartoon':
                film = Cartoon()
            else:
                film = Documentary()

            film.read(params)
            container.films.append(film)

        return container

    def write(self, file):
        file.write(str(self.length) + '\n')

        for film in self.films:
            file.write(film.to_string() + '\n')

    @staticmethod
    def random(length):
        container = Container(length)

        for i in range(0, length):
            film_type = random_int(3)

            if film_type == 0:
                film = Drama()
            elif film_type == 1:
                film = Cartoon()
            else:
                film = Documentary()

            film.random()
            container.films.append(film)

        return container

    def shell_sort(self):
        s = self.length // 2

        while s > 0:
            for i in range(0, self.length):

                j = i + s
                while j < self.length:
                    if self.films[i].calculate() > self.films[j].calculate():
                        temp = self.films[i]
                        self.films[i] = self.films[j]
                        self.films[j] = temp
                    j += s

            s //= 2
