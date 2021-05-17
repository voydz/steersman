FROM ubuntu:20.04
ENV STEERSMAN_CONFIG=/config
ENV STEERSMAN_HOME=/steersman

# environment setup
ENV KLIPPER_VENV=${STEERSMAN_HOME}/klipper/env
ENV KLIPPER_DIR=${STEERSMAN_HOME}/klipper/src

ENV MOONRAKER_VENV=${STEERSMAN_HOME}/moonraker/env
ENV MOONRAKER_DIR=${STEERSMAN_HOME}/moonraker/src

ENV TZ=UTC
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# os dependencies
RUN apt update \
    && apt install -y sudo supervisor git dfu-util unzip nginx wget

COPY docker/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# add steersman user
RUN useradd -ms /bin/bash steersman 
RUN adduser steersman sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# setup workdir
COPY docker ${STEERSMAN_HOME}
WORKDIR ${STEERSMAN_HOME}
RUN chown -R steersman:steersman ${STEERSMAN_HOME}

# install klipper, moonraker and mainsail
RUN klipper/setup.sh
RUN moonraker/setup.sh
RUN mainsail/setup.sh

RUN chown -R steersman:steersman ${STEERSMAN_CONFIG}

EXPOSE 80

ENTRYPOINT ["./entrypoint.sh"]

