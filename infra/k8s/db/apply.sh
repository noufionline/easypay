#!/bin/bash

echo
echo "[TASK 1] Creating Network Policy (easypay)"
echo
kubectl apply -f network-policy.yaml

echo
echo "[TASK 2] Creating ConfigMap & Secrets for Postgres DB Connection"
echo

kubectl apply -f postgres-config.yaml
echo
kubectl apply -f postgres-secret.yaml

echo
echo "[TASK 3] Creating Persistent Volume"
echo

kubectl apply -f persistent-volume.yaml

echo
echo "[TASK 4] Creating Persistent Volume Claim"
echo

kubectl apply -f persistent-volume-claim.yaml

echo
echo "[TASK 5] Creating Service to access db from easypay api"
echo

kubectl apply -f service.yaml

echo
echo "[TASK 6] Creating Deployment to install db"
echo

kubectl apply -f deployment.yaml


