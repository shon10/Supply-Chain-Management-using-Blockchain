import json

class Startup:
    '''
    Generate node startup shell scripts
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

        g = open('startnode.txt', 'r')
        script1 = str(g.read())
        g.close()

        #j = json.loads(open('nodes.json').read())

        script = script.replace('{{create_genesis_flags}}', ' --chain_id "'+  j['networkId'] + '" --difficulty "' +  (j['difficulty']) + '" --gas_limit "'+j['gasLimit']+'"')
        script = script.replace('{{startnode.sh}}',j['nodes'][i]['startnode'])
        script1 = script1.replace('{{rpccorsdomain}}', j['nodes'][i]['rpccorsdomain']  )
        script1 = script1.replace('{{rpcapi}}', j['nodes'][i]['rpcapi']  )

        f= open("startup_script"+ str(i) + ".sh","w+")
        f.write(script)
        f.close()

        g= open("startnode"+ str(i) + ".sh" ,"w+")
        g.write(script1)
        g.close()

        #print(script1)

    for i in range(0,len(j['validate_nodes'])):

        f = open('startup_validate.txt', 'r')
        script = str(f.read())
        f.close()

        g = open('startvalidnode.txt', 'r')
        script1 = str(g.read())
        g.close()



        #j = json.loads(open('nodes.json').read())

        script = script.replace('{{create_genesis_flags}}', ' --chain_id "'+  j['networkId'] + '" --difficulty "' +  (j['difficulty']) + '" --gas_limit "'+j['gasLimit']+'"')
        script1 = script1.replace('{{rpccorsdomain}}', j['nodes'][i]['rpccorsdomain']  )
        script1 = script1.replace('{{rpcapi}}', j['nodes'][i]['rpcapi']  )

        f= open("startup_validate"+ str(i) + ".sh" ,"w+")
        f.write(script)
        f.close()

        g= open("startvalidnode"+ str(i) + ".sh" ,"w+")
        g.write(script1)
        g.close()

        #print(script1)
