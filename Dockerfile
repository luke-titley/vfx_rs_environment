FROM ubuntu:20.04
RUN apt update
RUN apt install build-essential -y
ADD llvm-project llvm-project
ADD cmake-3.24.2-linux-x86_64 cmake
ENV PATH=${CWD}/cmake/bin:$PATH
RUN apt install python3 -y
RUN cd llvm-project && mkdir .build && cd .build && cmake -DLLVM_ENABLE_PROJECTS=clang -DCMAKE_BUILD_TYPE=Release -G "Unix Makefiles" ../llvm
RUN cd llvm-project/.build && make -j16 && make install
