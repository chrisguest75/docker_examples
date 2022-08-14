# makefile

# Targets:
# make 
# make clean

# create executable
helloworld: helloworld.o
	g++ -o helloworld ./objs/helloworld.o

# create objs
helloworld.o: src/helloworld.cpp
	mkdir ./objs
	g++ -Wall -Wextra -Werror -c src/helloworld.cpp -o objs/helloworld.o

# clean 
clean: 
	rm -rf ./objs 
	rm -f helloworld