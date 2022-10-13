FROM aswf/ci-usd:2021

#RUN apt update
#RUN rpm -ivh -y g++ curl python3 -y
# Add everything
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
RUN cd llvm-project && mkdir .build && cd .build && cmake -DLLVM_ENABLE_PROJECTS=clang -DCMAKE_BUILD_TYPE=Release -G "Unix Makefiles" ../llvm && make -j12 && make install

# Build and install USD
RUN curl -L https://github.com/PixarAnimationStudios/USD/archive/refs/tags/v21.11.zip > /tmp/usd.zip
RUN unzip /tmp/usd.zip
RUN python2 USD-21.11/build_scripts/build_usd.py --no-imaging --no-python -v /usr/local/USD

# Finally build babble
#ADD babble babble
#RUN cd babble && cargo build && cargo test
