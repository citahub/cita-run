FROM cita/cita-run:ubuntu-18.04-20180813

WORKDIR /root/cita

RUN curl -O http://47.104.128.219/cita_secp256k1_sha3.tar.gz   \
    && tar zxvf cita_secp256k1_sha3.tar.gz \
    && rm -rf cita_secp256k1_sha3.tar.gz \
    && cd cita_secp256k1_sha3

COPY ./docker-entrypoint.sh ./cita_secp256k1_sha3

RUN cd cita_secp256k1_sha3 && pwd  && ls -l

WORKDIR /root/cita/cita_secp256k1_sha3
chmod +x ./docker-entrypoint.sh
ENTRYPOINT ["./docker-entrypoint.sh"]


