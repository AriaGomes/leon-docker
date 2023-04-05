#!/bin/sh
# Install Python with pyenv
git clone --depth=1 https://github.com/pyenv/pyenv.git .pyenv
pyenv install ${PYTHON_VERSION}
pyenv global ${PYTHON_VERSION}
# Install Pipenv
pip install --force-reinstall pipenv virtualenv
# install yarn
npm install --global yarn
# Clone leon
git clone -b master https://github.com/leon-ai/leon.git leon
chmod -R 777 leon
# Install leon and start
cd leon
yarn
yarn build
yarn start