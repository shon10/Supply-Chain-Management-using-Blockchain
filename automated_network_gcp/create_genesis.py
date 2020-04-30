import time 
import json
import argparse

class Genesis:
    """
    It is used to create a genesis file in json format for Proof of Work consensis mechanism
    in Ethereum blockchain
    """

    def __init__(self, chain_id):
        """
        Genesis constructor
        Parameter : chain_id
        It is a unique parameter used to identify the network 

        """
        self.config= {
            "chain_id" : chain_id,
            "homesteadBlock": 1,
            "eip150Block": 2,
            "eip150Hash": "0x0000000000000000000000000000000000000000000000000000000000000000",
            "eip155Block": 3,
            "eip158Block": 3,
            "byzantiumBlock": 4,
        }
        self.nonce = "0x0"
        self.timestamp = hex(int(time.time()))
        self.extra_data = ""
        self.mix_hash = "0x0000000000000000000000000000000000000000000000000000000000000000"
        self.coinbase = "0x0000000000000000000000000000000000000000"
        self.number = "0x0"
        self.gas_used = "0x0"
        self.parent_hash = "0x0000000000000000000000000000000000000000000000000000000000000000"
        self.alloc = dict({"0x0000000000000000000000000000000000000000":"0x1"})

    def add_gas_Limit(self, gas_limit):
        """
        Parameter : gasLimit
        It is used to provide the upper limit of gas provided by the user
        """

        self.gas_limit = gas_limit
        
    
    def add_difficulty_level(self, difficulty):
        """
        Parameter : difficulty
        It is used to provide the starting difficulty level for mining
        """ 

        self.difficulty = difficulty
    

    def add_prefunded_accounts(self, prefunded_accounts):
        """
        Parameter : alloc
        It is used to specify the accounts to be prefunded(comma separarted)

        """
        temp = {}
        account = prefunded_accounts.split(",")
        for i in range(0,len(account)):

            if account[i][0:2] == "0x" and len(account[i]) == 40:
                temp[account[i]] = {}
                
            elif account[i][0:2] == "0x" and len(account[i]) == 42:
                temp[account[i]] = {}
            else:
                print ("prefunded account format not recognized")
        self.alloc = temp
    
    
    def add_balance(self, balance):
        """
        Parameter : balance
        It is used to specify the balance in each account

        """
        champ ={}
        money = balance.split(",")
        for i in range(0,len(money)):
            self.alloc[list(self.alloc.keys())[i]]["balance"] = hex(int(money[i]))
            
            
        return self.alloc





    def dump_genesis(self, filename):
        """
        :param filename: string
        """
        genesis = {
            "config": self.config,
            "nonce": self.nonce,
            "timestamp": self.timestamp,
            "extraData": self.extra_data,
            "gasLimit": self.gas_limit,
            "difficulty": self.difficulty,
            "mixHash": self.mix_hash,
            "coinbase": self.coinbase,
            "alloc": self.alloc,
            "number": self.number,
            "gasUsed": self.gas_used,
            "parentHash": self.parent_hash
        }
        f = open(filename, 'w')
        f.write(json.dumps(genesis, indent = 4))
        f.close()


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('--chain_id', help='chain id or network unique identifier')
    parser.add_argument('--prefunded_accounts', help='comma separated list of accounts to be prefunded')
    parser.add_argument('--gas_limit', help='chain id or network unique identifier')
    parser.add_argument('--balance', help='to add balance to each account')
    parser.add_argument('--difficulty', help='chain id or network unique identifier')
    parser.add_argument('--filename', help='file to store genesis config')

    args = parser.parse_args()

    if not args.filename:
        args.filename = "Genesis.json"

    if args.chain_id and args.prefunded_accounts:
        try:
            genesis = Genesis(int(args.chain_id))
            genesis.add_prefunded_accounts(args.prefunded_accounts)
            genesis.add_gas_Limit(args.gas_limit)
            genesis.add_balance(args.balance)
            genesis.add_difficulty_level(args.difficulty)
            genesis.dump_genesis(args.filename)
        except ValueError:
            print ("invalid chain id. use only numbers")
        except Exception as e:
            print (e)
    else:
        print ("please provide sufficient arguments")
