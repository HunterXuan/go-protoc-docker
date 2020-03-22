FROM golang:alpine

LABEL maintainer="endpot@gmail.com"

ENV PROTOC_VER 3.11.4

# Update and install necessary dependency
RUN apk update && \
    apk add bash && \
    apk add curl && \
    apk add git && \
    apk add make && \
    apk add zip

RUN GO111MODULE=off go get -u -t github.com/grpc-ecosystem/grpc-gateway/protoc-gen-grpc-gateway && \
    GO111MODULE=off go get -u -t github.com/grpc-ecosystem/grpc-gateway/protoc-gen-swagger && \
    GO111MODULE=off go get -u -t github.com/golang/protobuf/protoc-gen-go

RUN curl -OLs https://github.com/protocolbuffers/protobuf/releases/download/v$PROTOC_VER/protoc-$PROTOC_VER-linux-x86_64.zip && \
    unzip -o protoc-$PROTOC_VER-linux-x86_64.zip -d /usr/local bin/protoc && \
    unzip -o protoc-$PROTOC_VER-linux-x86_64.zip -d /usr/local include/* && \
    rm -rf protoc-$PROTOC_VER-linux-x86_64.zip

RUN curl -Ls https://github.com/golang-migrate/migrate/releases/latest/download/migrate.linux-amd64.tar.gz | \
    tar -xz -C /usr/local/bin && \
    mv /usr/local/bin/migrate.linux-amd64 /usr/local/bin/migrate && \
    chmod +x /usr/local/bin/migrate
    
RUN mkdir -p /app

WORKDIR /app

CMD ["/bin/sh", "-c", "while true; do echo golang; sleep 60; done"]
