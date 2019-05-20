FROM ubuntu:18.04

RUN apt-get update \
    && apt-get install -y \
        curl \
        wget \
        nodejs \
        npm \
    && npm install n -g \
    && n 10.15.3 \
    && apt-get purge -y nodejs npm

ADD ./agora /agora

WORKDIR /agora
RUN wget http://download.agora.io/sdk/release/Agora_Recording_SDK_for_Linux_v2_3_3_FULL.tar.gz \
    && tar zxvf Agora_Recording_SDK_for_Linux_v2_3_3_FULL.tar.gz \
    && mv Agora_Recording_SDK_for_Linux_FULL sdk \
    && rm -f Agora_Recording_SDK_for_Linux_v2_3_3_FULL.tar.gz \
    && npm install -g node-gyp \
    && /bin/bash build.sh

WORKDIR /app
