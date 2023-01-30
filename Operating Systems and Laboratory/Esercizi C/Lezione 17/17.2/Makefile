
all: upperserver upperclient

upperserver: upperserver.o common.o
	clang upperserver.o common.o -o upperserver
upperclient: upperclient.o common.o
	clang upperclient.o common.o -o upperclient

%.o: %.c common.h
	clang -c -g -o $@ $<

clean:
	rm -f *.o upperserver upperclient
