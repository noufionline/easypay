#!/bin/bash

echo
echo "[TASK 1] Deleting Deployment"
echo

kubectl delete -f deployment.yaml

echo
echo "[TASK 2] Deleting Service"
echo

kubectl delete -f service.yaml

echo
echo "[TASK 3] Deleting Persistent Volume Claim"
echo


kubectl delete -f persistent-volume-claim.yaml

echo
echo "[TASK 3] Deleting Persistent Volume"
echo

kubectl delete -f persistent-volume.yaml

echo
echo "[TASK 3] Deleting Nework Policy"
echo

kubectl delete -f network-policy.yaml

echo
echo "[TASK 3] Deleting ConfigMap and Secrets"
echo

kubectl delete -f postgres-config.yaml
kubectl delete -f postgres-secret.yaml





