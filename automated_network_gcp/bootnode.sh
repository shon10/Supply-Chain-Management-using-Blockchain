#! /bin/bash
sudo apt-get update
sudo apt-get install -yq build-essential python-pip rsync
sudo apt-get install software-properties-common
sudo add-apt-repository -y ppa:ethereum/ethereum
sudo apt-get update
sudo apt-get install ethereum -y
bootnode -genkey boot.key
var1=$(bootnode -nodekey boot.key -writeaddress) 
var2=$(hostname -I) 
var3="${var2::-1}"
echo ""enode://""$var1""@""${var2::-1}"":30301"" >> /home/output.txt
gsutil cp /home/output.txt gs://blockchain-123/
bootnode -nodekey boot.key -verbosity 9 -addr 0.0.0.0:30301




     
