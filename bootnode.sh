#! /bin/bash
sudo apt-get update
sudo apt-get install -yq build-essential python-pip rsync
sudo apt-get install software-properties-common
sudo add-apt-repository -y ppa:ethereum/ethereum
sudo apt-get update
sudo apt-get install ethereum -y
bootnode -genkey boot.key
bootnode -nodekey boot.key -writeaddress >> /home/output.txt
gsutil cp /home/output.txt gs://blockchain-123/

