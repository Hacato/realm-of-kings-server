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

# Clone server source
RUN git clone --depth=1 https://github.com/edo9300/ygopro-server.git .

# Build proper Linux binary
RUN cmake .
RUN make

# Create expansions folder
RUN mkdir -p /server/expansions

EXPOSE 27017

CMD ["./ygopro-server"]
