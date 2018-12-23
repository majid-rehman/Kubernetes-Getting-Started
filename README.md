###### DevOps-Test-Majid

###### Usage 
```
git clone https://github.com/majidkhan138/DevOps-Test-Majid.git

cd DevOps-Test-Majid
```
###### Once you get in to this repository your first task will be to download Virtual Box from below link according to your OS .
```
https://www.virtualbox.org/wiki/Downloads
```
###### After Virtual Box successful installion it's time to set Kubernetes Environment (minikube dashboard) by executing the script ,one command and your environment is ready , No need to download Prerequisit one by one .
```
chmod +x kubectl-minikube-intall-with-script.sh

./kubectl-minikube-intall-with-script.sh
```
###### This will start minikube dashboard automatically , if not you can try this it will start minikube dashboard .
```
minikube start

minikube dashboard
```

###### When minikube starts, it will automatically set the context for kubectl. Run these commands to check nodes and pods
```
kubectl get nodes

kubectl get pods --all-namespaces
```

###### All set for Kubernetes Now let's deploy our node server to kubernetes (minikube).
=> Be sure your in the directory because these commands will not work if your not in that directory

=> We have simple node server with index.js and package.json running on port 8083 , you will see Dockerfile as well on this     repository, we will be using script that will build docker image , push docker image to docker registry , run docker           image and you can give appropriate tag to that docker image .. while running a container if it found similar container it     will ask with YES or NO to stop running container and start new one ..

###### Now lets get started 
```
chmod +x docker-autowork.sh
```
###### You can pass these arguments ( -t or --tag for image tag, -i or --image for docker image, -b or --build for build, -r run or --run for run, -p or --push to push )
```
docker login ( if you don't have a dockerhub account create one)
```
###### i have pass my username as hard cotted with DOCKER_REGISTRY variable , You can change it and write yours . 
###### This will create image with my username/devops-test:latest
```
./docker-autowork.sh -b=majid --image=devops-test -t=latest
```

###### This will run container from an image which you specified in arguments
```
./docker-autowork.sh -r=majid --image=devops-test -t=latest
```

=> If container is already in running state , it will ask for to stop that conatiner and run new one with Yes or No 
   if type Yes your container will start and you will be able to access it from localhost:9000

###### This will push your docker image to dockerhub with your appropriate tag
```
./docker-autowork.sh -p=devops-test --image=devops-test -t=latest
```

=> Note - since k8s is running in it's own virtual machine, it doesn't have access to Docker images that you build. In order     to proceed with this, you'll need to push your image to some place accessible by k8s. Dockerhub is available and     free.

###### Kubernetes Deployments & Services created in this repository simply follow these steps

=> To deploy your deployment, `run`:
```
kubectl create -f deployment.yam
```
=> To get your deployment with kubectl, `run`:
```
kubectl get deployments
```
=> Now we can create the service within Kubernetes
```
kubectl create -f service.yaml
```
=> And we can get the details by running
```
kubectl get services
```
###### you can run this command which will return the current IP address.
```
minikube ip
```
###### To access your service, simply curl the IP on port `30001`
```
curl http://192.168.99.102:30001/

or

visit http://192.168.99.102:30001/
```
=> You will see a response 
```
Server responded with success!!
```

        ######################################### Thank-You ##########################################
