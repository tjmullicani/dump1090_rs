FROM ghcr.io/cross-rs/aarch64-unknown-linux-gnu:0.2.4

RUN apt-get update -y && apt-get install -y cmake git llvm-dev libclang-common-8-dev pkg-config clang-8

RUN \
    git clone https://github.com/pothosware/SoapySDR.git &&\
    cd SoapySDR &&\
    git checkout soapy-sdr-0.8.1 &&\
    mkdir build &&\
    cd build &&\
    cmake \
        -D CMAKE_C_COMPILER=/usr/bin/aarch64-linux-gnu-gcc \
        -D CMAKE_CXX_COMPILER=/usr/bin/aarch64-linux-gnu-g++ \
        -D CMAKE_AR=/usr/bin/aarch64-linux-gnu-ar \
        -D CMAKE_C_COMPILER_AR=/usr/bin/aarch64-linux-gnu-gcc-ar \
        -D CMAKE_C_COMPILER_RANLIB=/usr/bin/aarch64-linux-gnu-gcc-ranlib \
        -D CMAKE_LINKER=/usr/bin/aarch64-linux-gnu-ld \
        -D CMAKE_NM=/usr/bin/aarch64-linux-gnu-nm \
        -D CMAKE_OBJCOPY=/usr/bin/aarch64-linux-gnu-objcopy \
        -D CMAKE_OBJDUMP=/usr/bin/aarch64-linux-gnu-objdump \
        -D CMAKE_RANLIB=/usr/bin/aarch64-linux-gnu-ranlib \
        -D CMAKE_STRIP=/usr/bin/aarch64-linux-gnu-strip .. &&\
    make -j4 &&\
    make install &&\
    ldconfig

ENV LD_LIBRARY_PATH=/usr/local/lib
