cmake_minimum_required(VERSION 3.20)
project(Threads)

set(CMAKE_CXX_STANDARD 17)
set (CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} -fno-omit-frame-pointer -fsanitize=address -Wall -Werror -fno-sanitize-recover=all")
set (CMAKE_LINKER_FLAGS_DEBUG "${CMAKE_LINKER_FLAGS_DEBUG} -fno-omit-frame-pointer -fsanitize=address -Wall -Werror -fno-sanitize-recover=all")
SET(CMAKE_CXX_FLAGS -pthread)

add_executable(Threads main.cpp Thief.cpp Thief.h Loader.cpp Loader.h Accountant.cpp Accountant.h Storage.cpp Storage.h Container.cpp Container.h)
