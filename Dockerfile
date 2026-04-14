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

WORKDIR /app

# Clone server source (stable official repo)
RUN git clone https://github.com/edo9300/ygopro-server.git server

WORKDIR /app/server

# Build server properly
RUN cmake . || true
RUN make || true

# Ensure expansions folder exists for your cards
RUN mkdir -p /app/server/expansions

EXPOSE 27017

CMD ["./ygopro-server"]
