FROM ubuntu:jammy

ADD https://storageapi.fleek.co/6cc5209f-c08d-4a5c-815e-5bf664da6658-bucket/openethereum/openethereum-c0e9663da.zip /tmp
RUN mkdir -p /opt/openethereum/data && \
    chmod g+rwX /opt/openethereum/data && \
    mkdir -p /opt/openethereum/release && \
    apt update && apt install unzip && \
    unzip /tmp/openethereum*.zip -d /opt/openethereum/release && \
    /opt/openethereum/release/openethereum --version && \
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
