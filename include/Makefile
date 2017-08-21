CXX=g++ $(COMPILEFLAGS)
COMPILEFLAGS=-s -O3 -std=c++0x -I.

all: libIni.a libArguments.a libRandom.a


libIni.a: Ini.o
	ar rc ../lib/libIni.a Ini.o
	ranlib ../lib/libIni.a

Ini.o: Ini/Ini.cpp ../include/Ini.h
	$(CXX) $(COMPILEFLAGS) -I../include Ini/Ini.cpp -c -o Ini.o


libArguments.a: Arguments.o
	ar rc ../lib/libArguments.a Arguments.o
	ranlib ../lib/libArguments.a

Arguments.o: Arguments/Arguments.cpp ../include/Arguments.h
	$(CXX) $(COMPILEFLAGS) -I../include Arguments/Arguments.cpp -c -o Arguments.o


libRandom.a: Random.o
	ar rc ../lib/libRandom.a Random.o
	ranlib ../lib/libRandom.a

Random.o: Random/Random.cpp ../include/Random.h
	$(CXX) $(COMPILEFLAGS) -I../include Random/Random.cpp -c


clean:
	rm -f ../lib/libIni.a ../lib/libArguments.a ../lib/libRandom.a 
	rm -f *.o
