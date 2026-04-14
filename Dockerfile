FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    git \
    cmake \
    g++ \
    make \
    libevent-dev \
    zlib1g-dev \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /server

RUN git clone --depth=1 https://github.com/edo9300/ygopro-server.git .

RUN cmake .
RUN make

RUN mkdir -p /server/expansions

EXPOSE 27017

CMD ["./ygopro-server"]
