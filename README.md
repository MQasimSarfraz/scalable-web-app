# Scalable-web-app
A client-server based application to demostarte deployment and packaging abilities of Kubernetes and Docker combination. Following is the list of tools along with useful documentation:

- [Docker](https://docs.docker.com/) - Container runtime for packaging applications.
- [Kubernetes](https://kubernetes.io/docs/) - Cluster manager for life cycle management of applications.
- [Minikube](https://kubernetes.io/docs/getting-started-guides/minikube/) - Kubernetes flavor for single node developement environment. 
- [Docker Registry](https://hub.docker.com/u/smqasims/) - Docker registry hosting application images. 

You will need a kubernetes environment for running the application. Please refer to above documentation for installation.

## server
The server is a docker based nginx server hosting our favourite ```Hello,World``` page. The docker image for server is available [here](https://hub.docker.com/r/smqasims/server/).
## client
The client is a cURL based utility that will be used to send periodic HTTP requests to the server. The docker image for client is available [here](https://hub.docker.com/r/smqasims/client/).

## get the code
Download the code using git:
```
$ git clone https://github.com/MQasimSarfraz/scalable-web-app.git
```

## Deployments
All the entities will be deployed via ```kubectl``` utility using respective ```yaml``` files. All the deployment files are kept in ```scalable-web-app/kubernetes```

### server deployment
Deploy the server using:
```
$ kubectl create -f kubernetes/deployments/server.yaml
```
You can verify that the server is running using:
```
$ kubectl get deployment server
$ kubectl describe deployment server
```
For the server to be accessible it needs to be exposed as a service using: 
```
$ kubectl create -f kubernetes/services/server.yaml
```

### client deployment
Client issues periodic HTTP request to server and has two configurable attributes:
- Server service endpoint (required)
- Time between each request (optional)

Edit the ```kubernetes/deployments/client.yaml``` with the required values. Replace ```SERVER_URL``` with the server service endpoint and ```schedule: "*/1 * * * *"``` to configure time between requests. The format of the schedule string is explained [here](https://en.wikipedia.org/wiki/Cron). Once done deploy the client using:
```
$ kubectl create -f kubernetes/deployments/client.yaml
```

### scaling server
In order to scale the server, update the ```replicas``` in ```kubernetes/deployments/server.yaml``` to the required number of server. Once done scale the servers using:
```
$ kubectl apply -f kubernetes/deployments/server.yaml
```
### updating server
The server has two versions available:
- server v1 with nginx 1.10.1
- server v2 with nginx 1.11.1

Both of these images are available at [smqasims](https://hub.docker.com/u/smqasims/) docker registry. By default ```server:v1``` is deployed. 

In order to update the server, update the ```image``` in ```kubernetes/deployments/server.yaml``` to the the newer version i.e  ```smqasims/server:v2```. Once done update the servers using:
```
$ kubectl apply -f kubernetes/deployments/server.yaml
```
## Docker images
Images can be uploaded using ```scalable-web-app/app/build-image.sh``` script. Specify the required tags of images in the script and run it using:
```
./build-image.sh
```
## Cleanup
Cleanup the application using ```scalable-web-app/kubernetes/cleanup.sh``` script:
```
./cleanup.sh
```
