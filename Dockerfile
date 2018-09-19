FROM golang:alpine AS build
WORKDIR /go/src/app
COPY . /go/src/app/
RUN apk --no-cache add git &&\
 go get ./... &&\
 CGO_ENABLED=0 go build -o /ssh-key-agent .

FROM alpine:3.8
RUN apk add --no-cache ca-certificates
COPY --from=build /ssh-key-agent /ssh-key-agent
CMD [ "/ssh-key-agent" ]
