# DevOps-Test-Majid
# Usage 

    git clone https://github.com/majidkhan138/DevOps-Test-Majid.git

    cd DevOps-Test-Majid

# Kubernetes (minikube) Environment Setup
 - You must have Docker installed on your system
 - Once you get in to this repository your first task will be to download Virtual Box from below link according to your OS .
   https://www.virtualbox.org/wiki/Downloads
 - After Virtual Box successful installion it's time to set Kubernetes Environment (minikube dashboard) by executing the          script ,one command and your environment is ready , No need to download Prerequisit one by one . 
- 

    chmod +x kubectl-minikube-intall-with-script.sh
    ./kubectl-minikube-intall-with-script.sh

**This will start minikube dashboard automatically , 
if not you can try this it will start minikube dashboard .**

    minikube start
  ###### TERMINAL OUTPUT
    Locopixel-MAC-06:DevOps-Test-Majid admin$ minikube start
    Starting local Kubernetes cluster...
    Kubectl is now configured to use the cluster.
  ######
    minikube dashboard
  ###### TERMINAL OUTPUT
    Locopixel-MAC-06:DevOps-Test-Majid admin$ minikube dashboard
    Opening kubernetes dashboard in default browser...

**When minikube starts, it will automatically set the context for kubectl. Run these commands to check nodes and pods**

    kubectl get nodes
    
   ###### TERMINAL OUTPUT
    Locopixel-MAC-06:DevOps-Test-Majid admin$ kubectl get nodes
    NAME       STATUS    AGE
    minikube   Ready     1d
    
  ######
    kubectl get pods --all-namespaces
  
  ###### TERMINAL OUTPUT
    Locopixel-MAC-06:DevOps-Test-Majid admin$ kubectl get pods --all-namespaces
    NAMESPACE     NAME                                 READY     STATUS    RESTARTS   AGE
    default       devops-test-majid-1846920755-g0w5w   1/1       Running   0          1d
    kube-system   kube-addon-manager-minikube          1/1       Running   1          1d
    kube-system   kube-dns-v20-2ddpk                   3/3       Running   1          1d
    kube-system   kubernetes-dashboard-wzp59           1/1       Running   0          1d

**All set for Kubernetes Now let's deploy our node server to kubernetes (minikube).**

*Be sure your in the directory because these commands will not work if your not in that directory
We have simple node server with index.js and package.json running on `port 8083` , you will see `Dockerfile` as well on this repository, we will be using script that will build docker image , push docker image to docker registry , run docker image and you can give appropriate tag to that docker image .. while running a container if it found similar container it will ask with `YES or NO` to stop running container and start new one* 

..

# Automation

    chmod +x docker-autowork.sh

**You can pass these arguments** 

 - -t or --tag for taging docker image
 - -i or --image to start container from the image
 - -b or --build for build docker image
 - -r run or --run to run docker container,
 - -p or --push to push docker image to docker hub
 - 
 

    docker login ( if you don't have a dockerhub account create one)

**i have pass my username as hard cotted with `DOCKER_REGISTRY` variable , You can change it and write yours** . 

# Build Image
 
 

       ./docker-autowork.sh -b=majid --image=devops-test -t=latest
  ###### TERMINAL OUTPUT
        Locopixel-MAC-06:DevOps-Test-Majid admin$ ./docker-autowork.sh -b=majid --image=devops-test -t=latest
        buil action specfied
        Docker Image to process: 
        Using docker tag: latest
        ENVIRONMENT is devops-test
        build -t majidbangash/devops-test:latest .
        Sending build context to Docker daemon  224.3kB
        Step 1/9 : FROM alpine:3.7
         ---> 9bea9e12e381
        Step 2/9 : LABEL authors="majid Rehman <majid.rehman@locopixel.com>"
         ---> Using cache
         ---> 92b3e1e493e5
        Step 3/9 : RUN apk add --update nodejs bash git
         ---> Using cache
         ---> 7fe7a59caf23
        Step 4/9 : COPY . /www
         ---> Using cache
         ---> dddd1b27a876
        Step 5/9 : RUN cd /www; npm install
         ---> Using cache
         ---> 4b6a5fda4b6c
        Step 6/9 : WORKDIR /www
         ---> Using cache
         ---> fea9c15a4251
        Step 7/9 : ENV NODE_ENV production
         ---> Using cache
         ---> b3413ca3472a
        Step 8/9 : EXPOSE  8083
         ---> Using cache
         ---> 992f18b31296
        Step 9/9 : CMD npm run start
         ---> Using cache
         ---> d1f75d29eefd
        Successfully built d1f75d29eefd
        Successfully tagged majidbangash/devops-test:latest
# Run container


    ./docker-autowork.sh -r=majid --image=devops-test -t=latest
 ###### TERMINAL OUTPUT
    Locopixel-MAC-06:DevOps-Test-Majid admin$ ./docker-autowork.sh -r=majid --image=devops-test -t=latest
    run action specfied
    Docker Image to process: 
    Using docker tag: latest
    ENVIRONMENT is devops-test
    Container is already running. do you want to stop and run new one (y/n)? y
    majid
    majid
    run --name majid -d -p 9000:8083 majidbangash/devops-test:latest
    0e10d231c1d85e55637c1b5a09343f40905316702d5749faf96f4e99606df974

>If container is already in running state , it will ask for to stop that conatiner and run new one with **Yes or No** if type Yes your container will start and you will be able to access it from localhost:9000

# Push Image

    ./docker-autowork.sh -p=devops-test --image=devops-test -t=latest
###### TERMINAL OUTPUT
    Locopixel-MAC-06:DevOps-Test-Majid admin$ ./docker-autowork.sh -p=devops-test --image=devops-test -t=latest
    push action specfied
    Docker Image to process: 
    Using docker tag: latest
    ENVIRONMENT is devops-test
    push majidbangash/devops-test:latest
    The push refers to repository [docker.io/majidbangash/devops-test]
    f9d6006d8efb: Pushed 
    e6dd5913d603: Pushed 
    c936333841e6: Pushed 
    27396fdd2b2b: Pushed 
    d6da3c54c8f3: Mounted from library/alpine 
    latest: digest: sha256:52b34a5bb2d59bc893780a499e9fe6922056c3e3bb6fc1874238278eb562589f size: 1367

> Note - since k8s is running in it's own virtual machine, it doesn't
> have access to Docker images that you build. In order  to proceed with
> this, you'll need to push your image to some place accessible by k8s.
> Dockerhub is available and free

.

# Kubernetes Deployments & Services Creation

**To deploy your deployment, run**
###### Create deployment.yaml
    Locopixel-MAC-06:DevOps-Test-Majid admin$ vi deployment.yaml
######
    kubectl create -f deployment.yaml
###### TERMINAL OUTPUT
    Locopixel-MAC-06:DevOps-Test-Majid admin$ kubectl create -f deployment.yaml
    deployment "devops-test-majid" created


**To get your deployment with kubectl, run**

    kubectl get deployments
###### TERMINAL OUTPUT
    Locopixel-MAC-06:DevOps-Test-Majid admin$ kubectl get deployments
    NAME                DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE
    devops-test-majid   1         1         1            1           1d

**Now we can create the service within Kubernetes**
###### Create service.yaml
    Locopixel-MAC-06:DevOps-Test-Majid admin$ vi service.yaml
######
    kubectl create -f service.yaml
###### TERMINAL OUTPUT
    Locopixel-MAC-06:DevOps-Test-Majid admin$ vi service.yaml
    Locopixel-MAC-06:DevOps-Test-Majid admin$ kubectl create -f service.yaml
    service "devops-test-majid" created

**And we can get the details by running**

    kubectl get services
###### TERMINAL OUTPUT
    Locopixel-MAC-06:DevOps-Test-Majid admin$ kubectl get services
    NAME                CLUSTER-IP   EXTERNAL-IP   PORT(S)          AGE
    devops-test-majid   10.0.0.127   <pending>     8083:30001/TCP   1d
    kubernetes          10.0.0.1     <none>        443/TCP          1d

***# you can run this command which will return the current IP address.***

    minikube ip
###### TERMINAL OUTPUT
    Locopixel-MAC-06:DevOps-Test-Majid admin$ minikube ip
    192.168.99.102


# To access your service, simply curl the IP on port 3001

curl http://192.168.99.102:30001/

or

visit http://192.168.99.102:30001/

**Results:** 

    Server responded with success!!

            ######################################### Thank-You ##########################################
