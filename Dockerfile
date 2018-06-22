FROM cita/cita-run:ubuntu-18.04-20180523
LABEL maintainer="Cryptape Technologies <contact@cryptape.com>"

RUN pip3 install -U bitcoin==1.1.42 

ENTRYPOINT ["/usr/bin/entrypoint.sh"]
