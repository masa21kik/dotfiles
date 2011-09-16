CC = gcc
CXX = g++
CFLAGS = -O2 -W -Werror -Wall

SRCS1 =
OBJS1 = $(SRCS1:%.cpp=%.o)

TARGET = main

all: $(TARGET)
main: $(OBJS1)
	$(CXX) $(CFLAGS) -o $@ $(OBJS1)

%.o:%.c
	$(CC) $(CFLAGS) -c -o $@ $<
%.o:%.cpp
	$(CXX) $(CFLAGS) -c -o $@ $<
clean:
	rm -f $(TARGET) *.o *~
