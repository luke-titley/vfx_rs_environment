FROM ubuntu:20.04
RUN apt update
RUN apt install build-essential curl python3 -y
# Add everything
ADD babble babble
ADD install_rustup.sh install_rustup.sh
ADD llvm-project llvm-project
# Install rust
RUN sh install_rustup.sh -y
ENV PATH="/root/.cargo/bin:${PATH}"
# Get cmake binaries
RUN curl -L https://github.com/Kitware/CMake/releases/download/v3.24.2/cmake-3.24.2-linux-x86_64.tar.gz > cmake.tar.gz
RUN tar zxvf cmake.tar.gz
RUN rm -rf cmake
RUN mv cmake-3.24.2-linux-x86_64 cmake
ENV PATH=${CWD}/cmake/bin:$PATH
# Build and install clang
RUN cd llvm-project && mkdir .build && cd .build && cmake -DLLVM_ENABLE_PROJECTS=clang -DCMAKE_BUILD_TYPE=Release -G "Unix Makefiles" ../llvm && make -j && make install
# Finally build babble
RUN cd babble && cargo build && cargo test
