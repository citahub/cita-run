FROM cita/cita-run:latest
LABEL maintainer="Cryptape Technologies <contact@cryptape.com>"

RUN apt update && apt install -y git

RUN git clone https://github.com/cryptape/solidity.git \
    && cd solidity \
    && git checkout ubuntu-16 \
    && git submodule update --init --recursive \
    && ./scripts/install_ubuntu16_deps.sh \
    && ./scripts/build.sh \
    && cp /usr/local/bin/solc /usr/bin \
    && chmod +x /usr/bin/solc

