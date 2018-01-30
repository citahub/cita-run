FROM ubuntu:16.04

WORKDIR /root/cita
COPY solc /usr/bin/
COPY libgmssl.so.1.0.0 /usr/local/lib/

# Use speedup source for Chinese Mainland user,if not you can remove it
RUN mkdir -p $HOME/.config/pip \
    && cp /etc/apt/sources.list  /etc/apt/sources.list.old \
    && sed -i "s/archive.ubuntu.com/mirrors.aliyun.com/g" /etc/apt/sources.list \
    && echo "[global]" > $HOME/.config/pip/pip.conf \
    && echo "index-url = https://mirrors.ustc.edu.cn/pypi/web/simple" >> $HOME/.config/pip/pip.conf \
    && echo "format = columns" >> $HOME/.config/pip/pip.conf

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