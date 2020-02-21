FROM continuumio/miniconda3

RUN \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y libfuse-dev fuse curl wget software-properties-common

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
    && curl \
        -L \
        -o openjdk.tar.gz \
        https://download.java.net/java/GA/jdk11/13/GPL/openjdk-11.0.1_linux-x64_bin.tar.gz \
    && mkdir /opt/jdk \
    && tar zxf openjdk.tar.gz -C /opt/jdk --strip-components=1 \
    && rm -rf /opt/openjdk.tar.gz \
    && apt-get -y --purge autoremove curl \
    && ln -sf /opt/jdk/bin/* /usr/local/bin/ \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /score-client && \
    cd /score-client && \
    wget -qO- https://artifacts.oicr.on.ca/artifactory/dcc-release/bio/overture/score-client/[RELEASE]/score-client-[RELEASE]-dist.tar.gz | \
    tar xvz --strip-components 1
ENV PATH=/score-client/bin:$PATH
