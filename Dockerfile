FROM golang:1.14-alpine AS go
FROM alpine:3.6

LABEL maintainer="Igor Zibarev <zibarev.i@gmail.com>"

ENV KUBECTL_VERSION v1.12.4
ENV HELM_VERSION 3.0.2
ENV HELM_FILENAME helm-v${HELM_VERSION}-linux-amd64.tar.gz

RUN apk add --no-cache --virtual .deps curl bash

RUN set -ex \
    && curl -sSL https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl \
    && chmod +x /usr/local/bin/kubectl

RUN set -ex \
    && curl -sSL https://get.helm.sh/${HELM_FILENAME} | tar xz \
    && mv linux-amd64/helm /usr/local/bin/helm \
    && rm -rf linux-amd64

# Install go

COPY --from=go /usr/local/go/ /usr/local/go/
RUN apk add --no-cache gcc

ENV GOROOT /usr/local/go
ENV GOPATH /go
ENV PATH /usr/local/go/bin:$PATH

CMD ["helm"]
