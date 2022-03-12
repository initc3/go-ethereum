FROM golang:1.17.8 as builder

RUN set -eux; \
        \
        git clone https://github.com/ethereum/go-ethereum.git /usr/src/go-ethereum; \
        cd /usr/src/go-ethereum; \
        make geth;


FROM debian:bullseye-slim

COPY --from=builder /usr/src/go-ethereum/build/bin/geth /usr/local/bin/

# taken from ./Dockerfile 
EXPOSE 8545 8546 30303 30303/udp
ENTRYPOINT ["geth"]
