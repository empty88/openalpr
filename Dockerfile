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
    python3.7 \
    python3-pip \
    wget

RUN pip3 install --no-cache-dir tornado
RUN pip3 install --no-cache-dir numpy
RUN pip3 install --no-cache-dir openalpr

# Copy all data
copy . /srv/openalpr

# Setup the build directory
run mkdir /srv/openalpr/src/build
workdir /srv/openalpr/src/build

# Setup the compile environment
run cmake -DCMAKE_INSTALL_PREFIX:PATH=/usr -DCMAKE_INSTALL_SYSCONFDIR:PATH=/etc .. && \
    make -j2 && \
    make install
	
workdir /srv/openalpr/src/bindings/python/

RUN python3 setup.py install
ENV PYTHONPATH "${PYTHONPATH}:/srv/openalpr/src/bindings/python/openalpr"

workdir /srv/openalpr/

CMD ["openalpr_web.py"]
ENTRYPOINT ["python3"]
