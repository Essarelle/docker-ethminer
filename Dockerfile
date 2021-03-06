FROM nvidia/cuda:8.0-devel

MAINTAINER ty.auvil@gmail.com

ENV DUMB_VERSION=1.2.0

COPY docker-entrypoint.sh /bin/docker-entrypoint.sh
ADD https://github.com/Yelp/dumb-init/releases/download/v${DUMB_VERSION}/dumb-init_${DUMB_VERSION}_amd64 /bin/dumb-init

RUN apt-get update && \
    apt-get -y install software-properties-common && \
    add-apt-repository -y ppa:ethereum/ethereum -y && \
    apt-get update && \
    apt-get install --no-install-recommends -y git \
    cmake \
    libcryptopp-dev \
    libleveldb-dev \
    libjsoncpp-dev \
    libjsonrpccpp-dev \
    libboost-all-dev \
    libgmp-dev \
    libreadline-dev \
    libcurl4-gnutls-dev \
    ocl-icd-libopencl1 \
    opencl-headers \
    mesa-common-dev \
    libmicrohttpd-dev \
    build-essential && \
    chmod +x /bin/dumb-init

RUN git clone https://github.com/Genoil/cpp-ethereum/ && \
    cd cpp-ethereum && \
    mkdir build && \
    cd build && \
    cmake -DBUNDLE=cudaminer .. && \
    make -j8

ENV GPU_FORCE_64BIT_PTR=0
ENV GPU_MAX_HEAP_SIZE=100
ENV GPU_USE_SYNC_OBJECTS=1
ENV GPU_MAX_ALLOC_PERCENT=100
ENV GPU_SINGLE_ALLOC_PERCENT=100

ENTRYPOINT ["/bin/docker-entrypoint.sh"]
