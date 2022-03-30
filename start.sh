#!/bin/bash
docker stop gnosis-fullnode
docker rm gnosis-fullnode

export IMAGE=diwu1989/gnosis-fullnode:latest
export MAX_PEERS=100
export CACHE=256
export PORT=30308
mkdir -p data
docker run --name gnosis-fullnode -d \
        --restart unless-stopped \
        --stop-timeout 30 \
        --memory 4G \
        -p 28645:8645 -p 28646:8646 -p $PORT:$PORT -p $PORT:$PORT/udp \
        -v $PWD/data:/opt/openethereum/data $IMAGE \
        --chain xdai \
        --base-path '/opt/openethereum/data' \
        --jsonrpc-port 8645 \
        --jsonrpc-cors all \
        --jsonrpc-interface all \
        --jsonrpc-hosts all \
        --jsonrpc-apis web3,eth,net \
        --jsonrpc-server-threads 4 \
        --ws-port 8646 \
        --ws-interface all \
        --ws-apis web3,eth,net,pubsub,traces \
        --ws-origins all \
        --ws-hosts all \
        --max-peers $MAX_PEERS \
        --no-secretstore \
        --no-persistent-txqueue \
        --port $PORT \
        --cache-size $CACHE
