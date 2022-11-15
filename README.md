# cmake-fortran-template
This project is aimed at jump-starting a Fortran project that can build libraries, binaries and have a working unit test suite. When built, the project produces a static library, a command line binary, and a unit test. 

Cloning this project:
```
git clone https://github.com/Leonard-Reuter/cmake-fortran-template.git
```

Building this project and running the tests:
```
cd cmake-fortran-template
mkdir build
cd build
cmake ..
make
ctest -L allocator
```

