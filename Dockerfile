FROM python:alpine

ENV SHELL /bin/sh
ENV CC /usr/bin/clang
ENV CXX /usr/bin/clang++
ENV LANG C.UTF-8

ENV PYTHONUNBUFFERED 1
ENV PIP_DISABLE_PIP_VERSION_CHECK 1
ENV PIP_NO_CACHE_DIR 0

WORKDIR /tmp

RUN \
# Install development tools
    apk add --no-cache libffi openssl \
    && apk add --no-cache --virtual .dev-deps clang g++ libffi-dev openssl-dev make cargo \
    && addgroup -S webssh \
    && adduser -S webssh -G webssh \
    && pip install -U --no-cache-dir webssh \
# Cleanup
    && apk del .dev-deps \
    && rm -rf /tmp/* /var/cache/apk/*

# Copier les fichiers de certificats dans l'image
WORKDIR /tmp
COPY host.key host.cert ./

RUN chown webssh:webssh host.key host.cert \
    && chmod 600 host.key host.cert

USER webssh
EXPOSE 8080
ENTRYPOINT ["wssh", "--address=0.0.0.0", "--port=8080" ,"--keyfile=/tmp/host.key", "--certfile=/tmp/host.cert"]
