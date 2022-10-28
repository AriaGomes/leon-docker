#!/bin/sh
whoami
npm install --global yarn
git clone -b master https://github.com/leon-ai/leon.git leon
cd leon
yarn install
yarn check
yarn build
yarn start