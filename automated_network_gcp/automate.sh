#! /bin/bash


python startup.py
python expect.py
python requirements.py 
python main.py
chmod +x local_to_bucket.sh
./local_to_bucket.sh

terraform init
terraform apply 

#gsutil rm gs://blockchain-123/**


