from random import randrange
import string


def random_int(max_value):
    return randrange(max_value)


def random_string():
    length = random_int(10) + 1
    result = ''
    for i in range(0, length):
        result += string.ascii_lowercase[random_int(26)]

    return result
