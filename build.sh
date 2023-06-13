#!/bin/bash
tag="0.6.3"

xgo -out EthTweet -go go-1.20.x -targets="windows-6.0/amd64,linux/amd64" -ldflags="-w -s" .


mv EthTweet-linux-amd64 EthTweet
chmod 0777 EthTweet
zip -m EthTweet-${tag}-linux-amd64.zip EthTweet
sha512sum EthTweet-${tag}-linux-amd64.zip -t > EthTweet-${tag}-linux-amd64.zip.sha512

mv EthTweet-windows-6.0-amd64.exe EthTweet.exe
zip -m EthTweet-${tag}-windows-amd64.zip EthTweet.exe
sha512sum EthTweet-${tag}-windows-amd64.zip -t > EthTweet-${tag}-windows-amd64.zip.sha512

docker build -t ethtweet --build-arg VERSION="${tag}"  .
docker image tag ethtweet chenjia404/ethtweet
docker image push  chenjia404/ethtweet
