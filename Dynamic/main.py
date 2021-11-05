import sys
import time
import os.path
from Container import Container


def main():
    start_time = time.time()

    try:
        if len(sys.argv) != 5:
            print('Incorrect input.')
            return

        if sys.argv[1] == '-f':
            if not os.path.isfile(sys.argv[2]):
                print('Input file does not exist.')
                return

            in_file = open(sys.argv[2], 'r')
            container = Container.read(in_file)
        else:
            container = Container.random(int(sys.argv[2]))
    except():
        print('Incorrect input.')
        return

    out_file = open(sys.argv[3], 'w')
    sorted_out_file = open(sys.argv[4], 'w')

    container.write(out_file)

    container.shell_sort()
    container.write(sorted_out_file)

    print(time.time() - start_time)


if __name__ == '__main__':
    main()
