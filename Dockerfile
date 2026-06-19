FROM ghcr.io/gohugoio/hugo

COPY . /project

RUN npm i

RUN hugo --minify
