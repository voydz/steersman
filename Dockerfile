FROM ubuntu:20.04
LABEL version="1.1"
LABEL maintainer="voydz <voydz@hotmail.com>"
LABEL description="A docker image for running klipper, moonraker and mainsail from arbitary hardware."

# fallback timezone
ENV TZ=UTC
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# environment setup
ENV STEERSMAN_CONFIG=/home/steersman
ENV STEERSMAN_DIR=/steersman

ENV KLIPPER_VENV=${STEERSMAN_DIR}/klipper/env
ENV KLIPPER_DIR=${STEERSMAN_DIR}/klipper/src

ENV MOONRAKER_VENV=${STEERSMAN_DIR}/moonraker/env
ENV MOONRAKER_DIR=${STEERSMAN_DIR}/moonraker/src

COPY config /default_config
COPY docker ${STEERSMAN_DIR}

WORKDIR ${STEERSMAN_DIR}

# prepare requirements
RUN ./provision.sh

# run install scripts
RUN klipper/setup.sh
RUN moonraker/setup.sh
RUN mainsail/setup.sh

EXPOSE 80

ENTRYPOINT ["./entrypoint.sh"]

