FROM node:8-stretch

WORKDIR /app/0x

RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive \
    apt-get install -y libudev-dev build-essential checkinstall libreadline-gplv2-dev libncursesw5-dev libssl-dev libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev libffi-dev \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

RUN wget https://www.python.org/ftp/python/3.7.5/Python-3.7.5.tgz \
 && tar xzf Python-3.7.5.tgz \
 && cd Python-3.7.5 \
 && ./configure --enable-optimizations \
 && make install
RUN ln -s /usr/local/bin/pip3 /usr/bin/pip

RUN git clone https://github.com/0xProject/0x-monorepo.git
WORKDIR /app/0x/0x-monorepo
RUN yarn install && yarn build
