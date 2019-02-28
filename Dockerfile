FROM ubuntu:18.04
LABEL maintainer="Cryptape Technologies <contact@cryptape.com>"

RUN apt-get update \
    && apt-get install -y rabbitmq-server \
                          capnproto \
                          libsnappy-dev \
                          libgoogle-perftools-dev \
                          libssl-dev \
                          libsodium* \
                          libsecp256k1-dev \
                          pkg-config \
                          git \
                          curl \
                          libcurl4 \
                          sysstat \
                          sudo \
                          ca-certificates \
    && cd .. \
    && rm -rf /var/lib/apt/lists \
    && apt-get autoremove \
    && apt-get clean \
    && apt-get autoclean

# Ref:
#   + https://github.com/tianon/gosu/blob/master/INSTALL.md
#   + https://github.com/tianon/gosu/issues/39#issuecomment-362544059
RUN set -ex; \
    \
    export GOSU_VERSION="1.10"; \
    \
    dpkgArch="$(dpkg --print-architecture | awk -F- '{ print $NF }')"; \
    curl -o /usr/bin/gosu -SL "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch"; \
    curl -o /usr/bin/gosu.asc -SL "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch.asc"; \
    \
    export GNUPGHOME="$(mktemp -d)"; \
    for server in $(shuf -e ha.pool.sks-keyservers.net \
                            hkp://p80.pool.sks-keyservers.net:80 \
                            keyserver.ubuntu.com \
                            hkp://keyserver.ubuntu.com:80 \
                            pgp.mit.edu) ; do \
        gpg --keyserver "${server}" \
            --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 && break || : ; \
    done; \
    gpg --batch --verify /usr/bin/gosu.asc /usr/bin/gosu; \
    rm -rf "$GNUPGHOME" /usr/bin/gosu.asc; \
    \
    chmod +x /usr/bin/gosu; \
    gosu nobody true;

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh

WORKDIR /opt/cita-run

ENTRYPOINT ["/usr/bin/entrypoint.sh"]
