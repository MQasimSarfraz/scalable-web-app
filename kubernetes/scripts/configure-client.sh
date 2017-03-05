#!/bin/bash
# The script will be used to update the SERVER IP in the client file

SERVER=$(kubectl config view | grep server| head -1 | tr -d ' '| cut -f3 -d':' | sed 's/\/\///g')
sed -i "s/<NODE_IP>/$SERVER/g" ../deployments/client.yaml
