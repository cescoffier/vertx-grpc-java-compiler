# vertx-grpc-java-compiler

This is a custom protobuf compiled for java targetting the Vert.x programming model.

Not much to see for now...

## Build it

gRPC assumes you already have a couple of dependencies on your system:

* Java >=1.7
* `libprotoc` and `libprotobuf`
* a (not to old) Working C++ compiler toolchain

## Fedora build machine dependencies

* gcc
* gcc-c++
* mingw32-gcc
* mingw32-gcc-c++
* mingw64-gcc
* mingw64-gcc-c++

## Build the protobuf dependency

```
cd build
./build-linux.sh
./build-win32.sh
./build-linux.sh
```

You should have now the dependencies to build the plugin.

## Build the plugin

```
make clean
make

make -f Makefile.win32 clean
make -f Makefile.win32

make -f Makefile.win64 clean
make -f Makefile.win64
```

## Archive the maven artifacts

```
mvn install
```

## Building it on mac

### Prerequisites:

* g++ need to be installed, check with `g++ -version`
* automake, autoconf and libtool need to be installed:

```
brew install libtool autoconf automake
```

### Building protobuf

```
cd build
./build-linux.sh
cd ..
ls -la lib/linux/
```

You should have something like:

```
drwxr-xr-x  6 clement  staff       204 Jan 12 13:58 .
drwxr-xr-x  3 clement  staff       102 Jan 12 13:58 ..
-rw-r--r--  1 clement  staff  10008648 Jan 12 13:58 libprotobuf.a
-rw-r--r--  1 clement  staff       956 Jan 12 13:58 libprotobuf.la
-rw-r--r--  1 clement  staff   8949624 Jan 12 13:58 libprotoc.a
-rw-r--r--  1 clement  staff      1046 Jan 12 13:58 libprotoc.la
```

### Building the plugin

Edit the `Makefile` and change the first section to:

```
protoc-gen-grpc-java-osx-x86_64.exe: java_generator.o java_plugin.o
	g++ -o protoc-gen-grpc-java-osx-x86_64.exe java_plugin.o java_generator.o -lpthread lib/linux/libprotoc.a lib/linux/libprotobuf.a -m64 -s
	mkdir -p bin
	cp protoc-gen-grpc-java-osx-x86_64.exe bin
```

Then, issue:

```
make clean; make
```

### Installing the dependency to the local maven repo

```
mvn install:install-file \
    -Dfile=bin/protoc-gen-grpc-java-osx-x86_64.exe \
    -DgroupId=io.vertx \
    -DartifactId=protoc-gen-grpc-java \
    -Dversion=1.0.3 \
    -Dclassifier=osx-x86_64 \
    -Dpackaging=exe
```




