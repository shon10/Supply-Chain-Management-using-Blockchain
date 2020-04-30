import json

class MainTeraaform:
    '''
    Generate main.tf for gcp instance
    '''
    def __init__(self, name, network_id, datadir, bootnodes, rpc, ws, rpccorsdomain, wsorigins):
        '''
        '''
        self.name = name
        self.network_id = network_id
        self.datadir = datadir
        self.bootnodes = bootnodes
        self.rpc = rpc
        self.ws = ws
        self.rpccorsdomain = rpccorsdomain
        self.wsorigins = wsorigins

    def create_script(self):
        '''
        Create shell script to run node
        '''
        f = open('startup.txt', 'r')
        script = f.read()
        f.close()


if __name__ == "__main__":
 
    

    j = json.loads(open('nodes.json').read())
        

    for i in range(0,len(j['nodes'])):

        f = open('startup.txt', 'r')
        script = str(f.read())
        f.close()

        #j = json.loads(open('nodes.json').read())

        script = script.replace('{{create_genesis_flags}}', ' --chain_id "'+  j['networkId'] + '" --difficulty "' +  (j['difficulty']) + '" --gas_limit "'+j['gas_limit']+'"')
        script = script.replace('{{node_name}}', j['nodes'][i]['name']  )
        #f= open("startup_script.sh" + str(i),"w+")
        #f.write(script)
        f.close()

        print(script)
