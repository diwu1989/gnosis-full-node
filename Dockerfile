FROM debian:buster-slim

ADD https://github.com/openethereum/openethereum/releases/download/v3.3.3/openethereum-linux-v3.3.3.zip /tmp
RUN mkdir -p /opt/openethereum/data && \
    chmod g+rwX /opt/openethereum/data && \
    mkdir -p /opt/openethereum/release && \
    apt update && apt install unzip && \
    unzip /tmp/openethereum-linux-v3.3.3.zip -d /opt/openethereum/release && \
    rm /tmp/* && apt clean

WORKDIR /opt/openethereum/data

# exposing default ports
#
#      secret
#      store     ui   rpc  ws   listener  discovery
#      ↓         ↓    ↓    ↓    ↓         ↓
EXPOSE 8082 8083 8180 8645 8646 30304/tcp 30304/udp

# if no base path provided, assume it's current workdir
CMD ["--base-path", "."]
ENTRYPOINT ["/opt/openethereum/release/openethereum"]
