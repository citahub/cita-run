FROM cita/cita-run:ubuntu-18.04-20181009
MAINTAINER jiangxianliang88@gmail.com

ARG CITA_TAR=cita_secp256k1_sha3.tar.gz
ARG JUSER=test
ARG PASSWORD=test
ARG CITA_DIR=cita_secp256k1_sha3

WORKDIR /root/cita

RUN curl -u ${JUSER}:${PASSWORD} -O ${CITA_TAR}   \
    && tar zxvf ${CITA_DIR}.tar.gz \
    && rm -rf ${CITA_DIR}.tar.gz \
    && cd ${CITA_DIR}

COPY ./docker-entrypoint.sh ./${CITA_DIR}
ADD https://cdn.cryptape.com/cita-cli24 /usr/bin/cita-cli

WORKDIR /root/cita/${CITA_DIR}
RUN chmod +x ./docker-entrypoint.sh \
     && chmod +x /usr/bin/cita-cli
     
CMD ["./docker-entrypoint.sh"]



