import json

class Startup:
    '''
    Generate expect scripts
    '''
    def __init__(self, startup_script,password):
        '''
        '''
    
        self.startup_script = startup_script
        self.password = password
        

    def create_script(self):
        '''
        Create shell script to run node
        '''
        f = open('startup.txt', 'r')
        script = f.read()
        f.close()


if __name__ == "__main__":
 
    

    j = json.loads(open('nodes.json').read())
        

    for i in range(0,len(j['validate_nodes'])):

        f = open('startexp.txt', 'r')
        script = str(f.read())
        f.close()

        #j = json.loads(open('nodes.json').read())

        script = script.replace('{{startup_validate.sh}}', j['validate_nodes'][i]['startupScript'])
        script = script.replace('{{password}}', j['validate_nodes'][i]['password']  )
        

        f= open("startexp" + str(i) + ".exp"  ,"w+")
        f.write(script)
        f.close()

        #print(script)
