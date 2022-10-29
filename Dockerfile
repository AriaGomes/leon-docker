FROM ubuntu:latest
ENV IS_DOCKER true

# Replace shell with bash so we can source files
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# Set debconf to run non-interactively
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

# Install base dependencies
RUN apt-get update && apt-get install --yes -q --no-install-recommends \
  apt-transport-https \
  build-essential \
  ca-certificates \
  curl \
  git \
  wget \
  libssl-dev  \
  zlib1g-dev  \
  libbz2-dev  \
  libreadline-dev  \
  libsqlite3-dev  \
  llvm  \
  libncurses5-dev  \
  xz-utils  \
  tk-dev libxml2-dev  \
  libxmlsec1-dev  \
  libffi-dev  \
  liblzma-dev 

# cd to work dir 
WORKDIR /home/docker


ENV NVM_DIR /home/docker/nvm
ENV NODE_VERSION v16.17.0
# Install Node.js with nvm
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.1/install.sh | bash
RUN /bin/bash -c "source $NVM_DIR/nvm.sh && nvm install $NODE_VERSION && nvm use --delete-prefix $NODE_VERSION"

ENV NODE_PATH $NVM_DIR/versions/node/$NODE_VERSION/lib/node_modules
ENV PATH      $NVM_DIR/versions/node/$NODE_VERSION/bin:$PATH

ENV PYENV_ROOT="/home/docker/.pyenv"
ENV PATH="${PYENV_ROOT}/shims:${PYENV_ROOT}/bin:${PATH}"
ENV PYTHON_VERSION=3.9.10
ENV PYTHON_BIN_PATH /home/docker/.local/bin

# Copy script
COPY ./ ./
RUN chmod +x ./leonStart.sh
EXPOSE 1337

ENTRYPOINT ["./leonStart.sh"]