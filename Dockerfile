FROM cita/cita-run:ubuntu-18.04-20181009

ARG CITA_TAR=http://47.104.128.219/cita_secp256k1_sha3.tar.gz

WORKDIR /root/cita

ENV CITA_TAR=$CITA_TAR
RUN curl -O ${CITA_TAR}   \
    && tar zxvf cita_secp256k1_sha3.tar.gz \
    && rm -rf cita_secp256k1_sha3.tar.gz \
    && cd cita_secp256k1_sha3

COPY ./docker-entrypoint.sh ./cita_secp256k1_sha3
ADD http://47.104.128.219/cita-cli /usr/bin/

WORKDIR /root/cita/cita_secp256k1_sha3
RUN chmod +x ./docker-entrypoint.sh \
     && chmod +x /usr/bin/cita-cli
CMD ["./docker-entrypoint.sh"]


