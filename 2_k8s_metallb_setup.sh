#!/bin/bash

MLB_VERSION=0.13.7

echo "-----------> APPLYING MetalLB config"
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v${MLB_VERSION}/config/manifests/metallb-native.yaml

echo "-----------> WAITING on MetalLB pods are ready"
kubectl wait --namespace metallb-system \
                --for=condition=ready pod \
                --selector=app=metallb \
                --timeout=90s

echo "-----------> APPLYING MetalLB configs"
# MAKE SURE the range in spec.addresses is in 
# docker network inspect -f '{{.IPAM.Config}}' kind
echo "apiVersion: metallb.io/v1beta1
kind: IPAddressPool
metadata:
  name: example
  namespace: metallb-system
spec:
  addresses:
  - 172.18.255.200-172.18.255.250
---
apiVersion: metallb.io/v1beta1
kind: L2Advertisement
metadata:
  name: empty
  namespace: metallb-system" > metallb-config.yaml

kubectl apply -f ./metallb-config.yaml
