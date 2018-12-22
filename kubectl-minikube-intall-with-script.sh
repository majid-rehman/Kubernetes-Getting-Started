#!/bin/bash

ARCH=$(uname | awk '{print tolower($0)}')
TARGET_VERSION="v0.15.0"
MINIKUBE_URL="https://storage.googleapis.com/minikube/releases/${TARGET_VERSION}/minikube-${ARCH}-amd64"

KUBECTL_VER="v1.5.1"
KUBECTL_URL="http://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VER}/bin/${ARCH}/amd64/kubectl"

echo "installing latest kubectl..."
curl -Lo kubectl $KUBECTL_URL && chmod +x kubectl && sudo mv kubectl /usr/local/bin/

echo "installing latest minikube..."
curl -Lo minikube $MINIKUBE_URL && chmod +x minikube && sudo mv minikube /usr/local/bin/

ISO_URL="https://storage.googleapis.com/minikube/iso/minikube-v1.0.1.iso"
minikube start \
    --vm-driver=virtualbox \
    --iso-url=$ISO_URL

echo "starting minikube dashboard..."
minikube dashboard