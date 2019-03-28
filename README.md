# cmake-fortran-template
This project is aimed at jump-starting a Fortran project that can build libraries, binaries and have a working unit test suite. When built, the project produces a static library, a command line binary, and a unit test. 

Cloning this project:
```
git clone https://github.com/Libavius/cmake-fortran-template.git
```

Initializing pFUnit:
```
git submodule update --init --recursive
```

Building this project:
```
cd cmake-fortran-template
mkdir build
cd build
cmake ..
make
```

Building this project with pFUnit and running tests:
```
cd cmake-fortran-template
mkdir build
cd build
cmake -DPFUNIT=ON ..
make
ctest
```
