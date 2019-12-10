FROM ubuntu:18.04
LABEL maintainer="Rivtower Technologies <contact@rivtower.com>"

# Ref:
#   + https://github.com/tianon/gosu/blob/master/INSTALL.md#from-debian
RUN apt-get update \
 && apt-get install -y \
    rabbitmq-server \
    python3-pip \
    capnproto \
    libsnappy-dev \
    libgoogle-perftools-dev \
    libssl-dev \
    libsodium* \
    libsecp256k1-dev \
    pkg-config \
    git \
    curl \
    libcurl4 \
    sysstat \
    sudo \
    ca-certificates \
    gosu \
 # verify that the binary works
 && gosu nobody true \
 && cd .. \
 && rm -rf /var/lib/apt/lists \
 && apt-get clean

RUN pip3 install -U pip \
 && hash pip3 \
 && pip3 install toml jsonschema requests pyyaml \
 && rm -r ~/.cache/pip

RUN curl -o solc -L https://github.com/ethereum/solidity/releases/download/v0.4.24/solc-static-linux \
 && mv solc /usr/bin/ \
 && chmod +x /usr/bin/solc

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh

WORKDIR /opt/cita-run

ENTRYPOINT ["/usr/bin/entrypoint.sh"]
