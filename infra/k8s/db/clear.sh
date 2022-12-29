#!/bin/bash
kubectl delete -f deployment.yaml
kubectl delete -f service.yaml
#kubectl delete -f horizontal-pod-scaling-by-cpu-policy.yaml
#kubectl delete -f horizontal-pod-scaling-by-memory-policy.yaml
kubectl delete -f persistent-volume-claim.yaml
kubectl delete -f persistent-volume.yaml
kubectl delete -f network-policy.yaml
kubectl delete -f postgres-config.yaml
kubectl delete -f postgres-secret.yaml





