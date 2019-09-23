#!/usr/bin/env bash
folder=$1
# GO Lang installation:
sudo apt-get install gccgo-5

sudo add-apt-repository --remove ppa:longsleep/golang-backports
sudo add-apt-repository ppa:longsleep/golang-backports
sudo apt-get update
sudo apt-get install golang-go

cd $folder
git clone https://github.com/udhos/update-golang
cd update-golang
sudo ./update-golang.sh
cd ..

export GOPATH=$(pwd)/$folder
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:$GOPATH/bin
cd /opt
sudo git clone https://github.com/ipfs/go-ipfs.git "go-ipfs"
cd go-ipfs
sudo make install
cd $GOPATH
