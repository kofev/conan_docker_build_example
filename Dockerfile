FROM arm64v8/ubuntu:22.04

WORKDIR /opt/src/

ARG TZ=Europe/Moscow
ARG CMAKE_VERSION=3.28.3

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt update
RUN apt upgrade -y
RUN apt install pip -y
RUN apt install gcc g++ make build-essential libssl-dev wget -y
RUN apt clean && rm -rf /var/lib/apt/lists/*

RUN pip install conan --upgrade

# Build cmake from source
#RUN wget https://github.com/Kitware/CMake/releases/download/v$CMAKE_VERSION/cmake-$CMAKE_VERSION.tar.gz
#RUN tar -zxvf cmake-$CMAKE_VERSION.tar.gz
#RUN cd cmake-$CMAKE_VERSION && ./bootstrap --parallel=8
#RUN cd cmake-$CMAKE_VERSION && make -j8
#RUN cd cmake-$CMAKE_VERSION && make install 
#RUN rm -rf cmake-$CMAKE_VERSION
#RUN rm cmake-$CMAKE_VERSION.tar.gz
