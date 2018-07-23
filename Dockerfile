FROM cita/cita-run:ubuntu-18.04-20180703-solc-0.4.19

WORKDIR /root/cita

RUN apt-get update \
    && apt-get install -y  wget \
    && rm -rf /var/lib/apt/lists \
    && apt-get autoremove \
    && apt-get clean \
    && apt-get autoclean \
    && wget https://cryptape-public.oss-cn-hangzhou.aliyuncs.com/cita_release/cita_secp256k1_sha3.tar.gz  \
    && tar zxvf cita_secp256k1_sha3.tar.gz \
    && rm -rf cita_secp256k1_sha3.tar.gz
