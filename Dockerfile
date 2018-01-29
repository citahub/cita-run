FROM ubuntu:16.04

WORKDIR /root/cita
COPY solc /usr/bin/
COPY libgmssl.so.1.0.0 /usr/local/lib/

# use speedup source for Chinese Mainland user
RUN mkdir -p $HOME/.config/pip \
    && sed 's/archive.ubuntu.com/mirrors.aliyun.com/g' /etc/apt/sources.list -i \
    && echo '[global]' > $HOME/.config/pip/pip.conf \
    && echo 'index-url = https://mirrors.ustc.edu.cn/pypi/web/simple' >> $HOME/.config/pip/pip.conf \
    && echo 'format = columns' >> $HOME/.config/pip/pip.conf

RUN apt-get update \
    && apt-get install -y rabbitmq-server \
                          python-pip \
                          google-perftools \
                          capnproto \
                          libsnappy-dev \
                          libgoogle-perftools-dev \
                          libssl-dev \
                          libsodium* \
    && chmod +x /usr/bin/solc \
    && pip install -U pip ethereum==2.2.0 pysodium toml \
    && ln -srf /usr/local/lib/libgmssl.so.1.0.0 /usr/local/lib/libgmssl.so \
    && ldconfig \
    && rm -rf /var/lib/apt/lists \
    && rm -rf ~/.cache/pip \
    && apt-get autoremove \
    && apt-get clean \
    && apt-get autoclean