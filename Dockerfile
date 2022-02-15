from ubuntu:18.04

# Install prerequisites
run apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    build-essential \
    cmake \
    curl \
    git \
    libcurl3-dev \
    libleptonica-dev \
    liblog4cplus-dev \
    libopencv-dev \
    libtesseract-dev \
    python3.4 \
    python3-pip \
    wget

# Copy all data
copy . /srv/openalpr

# Setup the build directory
run mkdir /srv/openalpr/src/build
workdir /srv/openalpr/src/build

# Setup the compile environment
run cmake -DCMAKE_INSTALL_PREFIX:PATH=/usr -DCMAKE_INSTALL_SYSCONFDIR:PATH=/etc .. && \
    make -j2 && \
    make install
    
workdir /data

FROM python:3.4
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY . .

RUN pip install --no-cache-dir tornado


CMD ["/srv/openalpr/openalpr_web.py"]
ENTRYPOINT ["python"]
