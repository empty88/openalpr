FROM ubuntu:18.04

# Install prerequisites
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    build-essential \
    cmake \
    curl \
    git \
    libcurl3-dev \
    libleptonica-dev \
    liblog4cplus-dev \
    libopencv-dev \
    libtesseract-dev \
    python3.7 \
    python3-pip \
    wget

RUN pip3 install --no-cache-dir tornado
RUN pip3 install --no-cache-dir numpy
RUN pip3 install --no-cache-dir openalpr

# Copy all data
COPY . /srv/openalpr

# Setup the build directory
RUN mkdir /srv/openalpr/src/build
WORKDIR /srv/openalpr/src/build

# Setup the compile environment
RUN cmake -DCMAKE_INSTALL_PREFIX:PATH=/usr -DCMAKE_INSTALL_SYSCONFDIR:PATH=/etc .. && \
    make -j2 && \
    make install
	
WORKDIR /srv/openalpr/src/bindings/python/

RUN python3 setup.py install
ENV PYTHONPATH="${PYTHONPATH}:/srv/openalpr/src/bindings/python/openalpr"

WORKDIR /srv/openalpr/

CMD ["openalpr_web.py"]
ENTRYPOINT ["python3"]
