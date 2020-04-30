#! /bin/bash

geth --datadir node1 account new

account=$(jq '.address' /home/node1/keystore/UTC* | xargs -n 3)
#boot="cat output.txt"


#account1=${account:12:5}
python create_genesis.py --chain_id "1234" --prefunded_accounts "0x182d8bd276cca922c26f3f84a0a5d725cddbb3a3" --gas_limit "0xfff" --difficulty "0x400" --balance "0293846"


geth --datadir node1/ init Genesis.json


geth --datadir="node1" --networkid 1234 --port 30302 --unlock $account --rpc --rpcport "8000" --rpcaddr "0.0.0.0" --rpccorsdomain "*" --rpcapi "eth,net,web3,miner,debug,personal,rpc" --bootnodes 'enode address of bootnode'



 



