#! /bin/bash
sudo apt-get update
sudo apt-get install -yq build-essential python-pip rsync
sudo apt-get install software-properties-common
sudo add-apt-repository -y ppa:ethereum/ethereum
sudo apt-get install jq -y
sudo apt-get update
sudo apt-get install ethereum -y
sudo apt-get update -y
sudo apt-get install -y expect


gsutil cp /home/shonak/gcp_manual/create_genesis.py gs://blockchain-123/ 
gsutil cp /home/shonak/gcp_manual/{{start.exp}} gs://blockchain-123/ 
gsutil cp /home/shonak/gcp_manual/{{startup_script.sh}} gs://blockchain-123/ 
gsutil cp gs://blockchain-123/create_genesis.py /home/
gsutil cp gs://blockchain-123/output.txt /home/
gsutil cp gs://blockchain-123/{{start1.exp}} /home/
gsutil cp gs://blockchain-123/{{startup_script1.sh}} /home/

cd /home
sudo su

./start.exp
