FROM alpine:3.8

ENV GOPATH=/go

WORKDIR /go/src/app
COPY main.go /go/src/app/

RUN apk --no-cache add ca-certificates go git musl-dev && \
 go get ./... && \
 CGO_ENABLED=0 go build -o /ssh-key-agent . && \
 apk del go git musl-dev && \
 rm -rf $GOPATH

CMD [ "/ssh-key-agent" ]
