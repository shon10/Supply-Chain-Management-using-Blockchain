import json

class Startup:
    '''
    Generate expect scripts
    '''
    def __init__(self, startup_script,expect_script):
        '''
        '''
    
        self.startup_script = startup_script
        self.expect_script = expect_script
        

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

        f = open('requirements.txt', 'r')
        script = str(f.read())
        f.close()

        g = open('local_to_bucket.txt','r')
        script1 = str(g.read())
        g.close()

        #j = json.loads(open('nodes.json').read())

        script = script.replace('{{start.exp}}', j['validate_nodes'][i]["expectScript"])
        script = script.replace('{{startup_script.sh}}', j['validate_nodes'][i]["startupScript"]  )
        script= script.replace('{{startvalidnode.sh}}', j['validate_nodes'][i]["startvalidnode"]  )

        script1 = script1.replace('{{start.exp}}', j['validate_nodes'][i]["expectScript"])
        script1= script1.replace('{{startup_script.sh}}', j['validate_nodes'][i]["startupScript"]  )
        script1= script1.replace('{{startvalidnode.sh}}', j['validate_nodes'][i]["startvalidnode"]  )

        

        f= open("requirements" + str(i) + ".sh"  ,"w+")
        f.write(script)
        f.close()

        g= open("local_to_bucket.sh"  ,"a+")
        g.write(script1)
        g.close()

        print(script1)

    for i in range(0,len(j['nodes'])):
        
        
        g = open('node.txt','r')
        script1 = str(g.read())
        g.close()


        script1= script1.replace('{{startnode.sh}}', j['nodes'][i]["startnode"]  )

        g= open("local_to_bucket.sh"  ,"a+")
        g.write(script1)
        g.close()

        #print(script1)







