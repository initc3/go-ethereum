FROM golang:1.17.8 as builder

WORKDIR /usr/src
COPY . .

RUN make geth

FROM debian:bullseye-slim

COPY --from=builder /usr/src/go-ethereum/build/bin/geth /usr/local/bin/

# taken from ./Dockerfile 
EXPOSE 8545 8546 30303 30303/udp
ENTRYPOINT ["geth"]
