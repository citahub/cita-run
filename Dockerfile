FROM ubuntu:18.04

ENV HOME /opt
COPY solc /usr/bin/
COPY libgmssl.so.1.0.0 /usr/local/lib/

RUN apt-get update \
    && apt-get install -y rabbitmq-server \
                          python3-pip \
                          capnproto \
                          libsnappy-dev \
                          libgoogle-perftools-dev \
                          libssl-dev \
                          libsodium* \
                          libsecp256k1-dev \
                          pkg-config \
                          curl \
                          libcurl4 \
                          sysstat \
    && chmod +x /usr/bin/solc \
    && ln -srf /usr/local/lib/libgmssl.so.1.0.0 /usr/local/lib/libgmssl.so \
    && ldconfig \
    && pip install -U pip \
    && pip install pysodium toml \
                          jsonrpcclient[requests]==2.4.2 \
                          secp256k1==0.13.2 \
                          py_solc==1.2.2 \
                          simplejson==3.11.1 \
                          protobuf==3.4.0 \
                          pathlib==1.0.1 \
                          ecdsa \
                          pysha3>=1.0.2 \
    && git clone https://github.com/ethereum/pyethereum \
    && cd pyethereum \
    && git checkout 3d5ec14032cc471f4dcfc7cc5c947294daf85fe0 \
    && python3 setup.py install \
    && cd .. \
    && rm -rf pyethereum \
    && rm -rf /var/lib/apt/lists \
    && rm -rf ~/.cache/pip \
    && apt-get autoremove \
    && apt-get clean \
    && apt-get autoclean


WORKDIR /opt/cita
