import json

class MainTerraform:
    '''
    Generate main.tf for gcp instance
    '''
    def __init__(self, credentials,project,count,startupScript):
        '''
        '''
        self.credentials = credentials
        self.project = project
        self.count = count
        self.startupScript = startupScript 
        

    def create_script(self):
        '''
        Create shell script to run node
        '''
        f = open('startup.txt', 'r')
        script = f.read()
        f.close()


if __name__ == "__main__":
 
    

    j = json.loads(open('nodes.json').read())
    f = open('main.txt', 'r')
    script = str(f.read())
    f.close()
        

    script = script.replace('{{firewall-name}}',"private-blockchain")
    




#j = json.loads(open('nodes.json').read())

    script = script.replace('{{credentials.json}}', j['platformDetails']['credentials'])
    script = script.replace('{{project_name}}', j['platformDetails']['project']  )
    script = script.replace('{{no_of_nodes}}', str(j['platformDetails']['count'])  )
    f= open("main.tf","w+")
    f.write(script)
    f.close()
    
    
    #for bootnode

    g = open('compute_instance.txt', 'r')
    instance_script = str(g.read())
    instance_script = instance_script.replace('{{startup_script}}', j["bootnode"]['startupScript']  )
    instance_script = instance_script.replace('{{name}}', j['bootnode']['name']  )
    f= open("main.tf","a+")
    f.write(instance_script)
    f.close()


    for i in range(len(j['validate_nodes'])):
        g = open('compute_instance.txt', 'r')
        instance_script = str(g.read())
        instance_script = instance_script.replace('{{startup_script}}', j['validate_nodes'][i]['startupScriptmain']  )
        instance_script = instance_script.replace('{{name}}', j['validate_nodes'][i]['name']  )
        f= open("main.tf","a+")
        f.write(instance_script)
        f.close()

    for i in range(len(j['nodes'])):
        g = open('compute_instance.txt', 'r')
        instance_script = str(g.read())
        instance_script = instance_script.replace('{{startup_script}}', j['nodes'][i]['startupScript']  )
        instance_script = instance_script.replace('{{name}}', j['nodes'][i]['name']  )
        f= open("main.tf","a+")
        f.write(instance_script)
        f.close()

    

    #print(script)
