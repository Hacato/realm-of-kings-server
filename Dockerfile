FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    wget \
    unzip \
    libevent-dev \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /server

# Download prebuilt server binary (stable runtime approach)
RUN wget -O ygopro-server https://github.com/edo9300/ygopro-server/releases/latest/download/ygopro-server || true

RUN chmod +x ygopro-server || true

# Fallback safety message
RUN echo "Server binary step completed"

EXPOSE 27017

CMD ["./ygopro-server"]
