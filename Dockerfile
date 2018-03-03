FROM ubuntu:16.04

WORKDIR /root/cita
COPY solc /usr/bin/
COPY libgmssl.so.1.0.0 /usr/local/lib/

RUN apt-get update \
    && apt-get install -y rabbitmq-server \
                          python-pip \
                          capnproto \
                          libsnappy-dev \
                          libgoogle-perftools-dev \
                          libssl-dev \
                          libsodium* \
    && chmod +x /usr/bin/solc \
    && ln -srf /usr/local/lib/libgmssl.so.1.0.0 /usr/local/lib/libgmssl.so \
    && ldconfig \
    && pip install -U pip ethereum==2.2.0 pysodium toml \
    && rm -rf /var/lib/apt/lists \
    && rm -rf ~/.cache/pip \
    && apt-get autoremove \
    && apt-get clean \
    && apt-get autoclean
