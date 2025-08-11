FROM debian:bullseye-slim

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=America/New_York

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update && apt-get install -y \
    bc \
    build-essential \
    bzip2 \
    bzr \
    cmake \
    cmake-curses-gui \
    cpio \
    git \
    libncurses5-dev \
    libsamplerate0-dev \
    liblzma-dev \
    libzstd-dev \
    libbz2-dev \
    zlib1g-dev \
    libsdl2-dev \
    libsdl2-image-dev \
    libsdl2-ttf-dev \
    libsqlite3-dev \
    locales \
    make \
    rsync \
    scons \
    tree \
    unzip \
    wget \
  && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /root/workspace
WORKDIR /root

COPY support .

RUN chmod +x ./build-libzip.sh ./setup-toolchain.sh

RUN ./build-libzip.sh

RUN ./setup-toolchain.sh

RUN cat setup-env.sh >> .bashrc

VOLUME /root/workspace
WORKDIR /root/workspace

CMD ["/bin/bash"]
