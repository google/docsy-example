FROM floryn90/hugo:0.164.0-ext-alpine

# Provide the Dart Sass CLI, a Docsy build prerequisite since 0.17 (the
# base image ships no Sass compiler).
ARG DART_SASS_VERSION=1.102.0

# The base image's NODE_PATH starts with a relative "." entry, which Hugo's
# Node.js ESM resolver hook rejects, and its global modules can shadow the
# project's own: the site supplies every Node dependency, so clear it.
ENV NODE_PATH=

USER root
RUN apk add git && \
  git config --global --add safe.directory /src && \
  arch="$(apk --print-arch)" && \
  case "$arch" in \
    x86_64) sassArch=x64 ;; \
    aarch64) sassArch=arm64 ;; \
    *) echo "unsupported architecture: $arch" && exit 1 ;; \
  esac && \
  wget -qO- "https://github.com/sass/dart-sass/releases/download/${DART_SASS_VERSION}/dart-sass-${DART_SASS_VERSION}-linux-${sassArch}-musl.tar.gz" \
    | tar -xz -C /usr/local && \
  ln -s /usr/local/dart-sass/sass /usr/local/bin/sass
USER hugo
