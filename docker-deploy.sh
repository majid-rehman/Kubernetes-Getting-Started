#!/bin/bash
# Author: Majid
# Github: https://github.com/majidkhan138/DevOps-Test-Majid
# Description: Docker build,push and run script to aumate you development and testing

#Variable section
DOCKER_REGISTRY='majidbangash'
run_flag=false
build_flag=false
push_flag=false

#function section
function help(){
    echo "Following is supported flag to process docker images"
    echo "-t for image tag, -i for docker image -b build, -r run, -p push"
    echo "********"
    exit 1
}

#exit function
exit_script () {
    echo >&2 "$@"
    exit 1
}

#process docker action
docker_action(){
docker_command=$1
    echo $docker_command
docker $1
}

# Notify when no argument passed
if [ $# -eq 0 ]; then
    echo "No arguments provided"
fi 



#process args

while [ "$1" != "" ]; do
PARAM=`echo $1 | awk -F= '{print $1}'`
VALUE=`echo $1 | awk -F= '{print $2}'`
    case $PARAM in
-h | --help)
            help
;;
-r | --run)
run=${VALUE}
            echo "run action specfied"
run_flag=true
;;
-i | --image)
docker_image=${VALUE}
            echo "Docker Image to process: "$image_name
;;
-t | --tag)
docker_tag=${VALUE}
            echo "Using docker tag: "$docker_tag
;;
-b |--build)
build=${VALUE}
            echo "buil action specfied"
build_flag=true
;;
-p | --push)
push=${VALUE}
            echo "push action specfied"
push_flag=true
;;
*)
            echo "ERROR: unknown parameter \"$PARAM\""
            exit 1
;;
    esac
    shift
done


echo "ENVIRONMENT is $docker_image";


# set default value 
docker_tag=${docker_tag:-latest}
docker_image=${docker_image:-devops-test}

#check for valid action
if ! $push_flag && ! $build_flag && ! $run_flag; then
exit_script "No action speficied. Possible action for docker image -b buld, -r run, -p push"
elif $run_flag; then
running_docker=$(docker ps -qf name=$run)
    if [ running_docker != "" ]; then
       echo -n "Container is already running. do you want to stop and run new one (y/n)? "
       read answer
        if [ "$answer" != "${answer#[Yy]}" ] ;then
docker stop $run;
docker rm $run
docker_action "run --name $run -d -p 9000:8083 $DOCKER_REGISTRY/$docker_image:$docker_tag"
        else
docker_action "run --name $run -d -p 9000:8083 $DOCKER_REGISTRY/$docker_image:$docker_tag ."
        fi
    fi
elif $push_flag; then
docker_action "push $DOCKER_REGISTRY/$docker_image:$docker_tag"
elif $build_flag; then
docker_action "build -t $DOCKER_REGISTRY/$docker_image:$docker_tag ."

else
    echo "Invalid flag"
exit_script "invalid flag"
fi
