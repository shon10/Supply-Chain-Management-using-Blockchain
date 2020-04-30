#! /bin/bash
sudo apt-get update
sudo apt-get install -yq build-essential python-pip rsync
sudo apt-get install software-properties-common
sudo add-apt-repository -y ppa:ethereum/ethereum
sudo apt-get update
sudo apt-get install ethereum -y
gsutil cp gs://blockchain-123/create_genesis.py /home/
cd /home
sudo su
python create_genesis.py --chain_id "1234" --prefunded_accounts "0x182d8bd276cca922c26f3f84a0a5d725cddbb3a3" --gas_limit "0xfff" --difficulty "0x400" --balance "0293846" 


