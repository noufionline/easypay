#!/bin/bash
kubectl apply -f network-policy.yaml
kubectl apply -f postgres-config.yaml
kubectl apply -f postgres-secret.yaml
kubectl apply -f persistent-volume.yaml
kubectl apply -f persistent-volume-claim.yaml
kubectl apply -f service.yaml
kubectl apply -f deployment.yaml


