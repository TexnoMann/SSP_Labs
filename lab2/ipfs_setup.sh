#!/usr/bin/env bash
folder=$1
# GO Lang installation:
sudo apt-get install gccgo-5

sudo add-apt-repository --remove ppa:longsleep/golang-backports
sudo add-apt-repository ppa:longsleep/golang-backports
sudo apt-get update
sudo apt-get install golang-go

cd $folder
if [ -d "update-golang" ]; then
  ans=""
  while [ "$ans" != "y" ] && [ "$ans" != "n" ]; do
    printf "\rDo you want to overwrite ./update-golang? (y/n)\n"
    read ans
  done
  if [ $ans == "y" ]; then
    rm -rvf update-golang
    git clone https://github.com/udhos/update-golang.git
  fi
fi
cd update-golang
sudo ./update-golang.sh

cd ..
export GOPATH=~/go
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:$GOPATH/bin

cd /opt
if [ -d "/opt/go-ipfs" ]; then
  ans=""
  while [ "$ans" != "y" ] && [ "$ans" != "n" ]; do
    printf "\rDo you want to overwrite /opt/go-ipfs? (y/n)\n"
    read ans
  done
  if [ $ans == "y" ]; then
    sudo rm -rvf /opt/go-ipfs
    sudo git clone https://github.com/ipfs/go-ipfs.git
  fi
fi
cd go-ipfs
sudo make install
cd $GOPATH
