FROM golang:1.16-alpine AS build
WORKDIR /go/src/github.com/utilitywarehouse/ssh-key-agent
COPY . /go/src/github.com/utilitywarehouse/ssh-key-agent
RUN apk --no-cache add git &&\
 go get ./... &&\
 CGO_ENABLED=0 go build -o /ssh-key-agent .

FROM alpine:3.14
RUN apk add --no-cache ca-certificates
COPY --from=build /ssh-key-agent /ssh-key-agent
CMD [ "/ssh-key-agent" ]
