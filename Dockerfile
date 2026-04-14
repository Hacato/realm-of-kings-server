FROM ubuntu:22.04

RUN apt-get update && apt-get install -y \
    git \
    wget \
    unzip \
    libevent-dev \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /server

# Download a prebuilt ygopro server release (stable approach)
RUN wget -O server.zip https://github.com/edo9300/ygopro-server/releases/latest/download/ygopro-server-linux.zip || true

# Fallback if release link fails (prevents hard crash)
RUN if [ ! -f server.zip ]; then \
    echo "Prebuilt server not found - using fallback setup"; \
    git clone https://github.com/edo9300/ygopro-server.git . ; \
    else \
    unzip server.zip && rm server.zip; \
    fi

# Make sure server is executable if present
RUN chmod +x ygopro-server || true

# Create expansions folder for your cards
RUN mkdir -p /server/expansions

EXPOSE 27017

CMD ["./ygopro-server"]
