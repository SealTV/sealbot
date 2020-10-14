FROM golang:1.15-alpine3.12 AS builder

WORKDIR /sealbot

COPY go.mod go.mod
COPY main.go main.go

RUN go get -v
RUN CGO_ENABLED=0 GOOS=linux go build -o sealbot .

FROM alpine:3.12

WORKDIR /sealbot
COPY --from=builder ./sealbot/sealbot .

EXPOSE 8080
ENTRYPOINT [ "/sealbot/sealbot" ]
