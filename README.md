# Private-ethereum-network
Automate the process of creating a private ethereum network on GCP.

## STEP:0
Create a GCP account and download the credentials file.
Create a new project and add the detalis in the node.json file under platformDetails.
Give that account the access to your bucket and instances.

## STEP:1
Take the input from the user through UI and store that in nodes.json file.

I have manually entered the values for demo purpose.

Inputs would contain :

**Chain_Id** : For unique identification of the network

**Difficulty**(for POW consensus) : For the difficulty of mining the block.

**Gas Limit** : Validating reward 

**No.of Validating Nodes and their passwords** : To unlock the account using geth command

**No.of normal nodes** : To determine no.of non-validating nodes  
 and other inputs according to your needs.

## STEP:2
Run the bash script automate.sh using ./automate.sh.

Some of the files would be copied to the bucket.

Required number of files are copied from local to bucket.

## STEP:3
**For validating nodes:**
Run the SSH for validating node(s) and run the *startvalidnode.sh* file and the user will enter its password to unlock the account.

**For normal nodes:**
Run the SSH for normal node(s) and run the *startnode.sh* file.

Finally all the nodes are connected to each other through the bootnode.
