#!/bin/bash
docker stop gnosis-fullnode
docker rm gnosis-fullnode

export IMAGE=diwu1989/gnosis-fullnode:latest
export MAX_PEERS=200
export CACHE=768
export PORT=30308
export TX_QUEUE_SIZE=512
mkdir -p data
docker run --name gnosis-fullnode -d \
        --restart unless-stopped \
        --stop-timeout 30 \
        --memory 4.5G \
        -p 127.0.0.1:28645:8645 -p 28646:8646 -p $PORT:$PORT -p $PORT:$PORT/udp \
        -v $PWD/data:/opt/openethereum/data $IMAGE \
        --chain xdai \
        --min-gas-price 1000000006 \
        --base-path '/opt/openethereum/data' \
        --jsonrpc-port 8645 \
        --jsonrpc-cors all \
        --jsonrpc-interface all \
        --jsonrpc-hosts all \
        --jsonrpc-apis web3,eth,net \
        --jsonrpc-server-threads 8 \
        --ws-port 8646 \
        --ws-interface all \
        --ws-apis web3,eth,net,pubsub,traces \
        --ws-origins all \
        --ws-hosts all \
        --max-peers $MAX_PEERS \
        --tx-queue-size $TX_QUEUE_SIZE \
        --no-secretstore \
        --no-persistent-txqueue \
        --port $PORT \
        --cache-size $CACHE
