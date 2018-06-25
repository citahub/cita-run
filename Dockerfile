FROM cita/cita-run:ubuntu-18.04-20180523

WORKDIR /root/cita

RUN apt-get update \
    && apt-get install -y  wget \
    && rm -rf /var/lib/apt/lists \
    && apt-get autoremove \
    && apt-get clean \
    && apt-get autoclean \
    && wget http://106.15.179.53:9999/20180625/662605be75a8a8cf2e341056925e2ad8c2811500/cita_secp256k1_sha3.tar.gz  \
    && tar zxvf cita_secp256k1_sha3.tar.gz \
    && rm -rf cita_secp256k1_sha3.tar.gz
