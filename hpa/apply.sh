#!/bin/bash

echo
echo "[TASK 1] Creating Metrics Server"
echo

kubectl apply -f metrics-server.yaml

echo
echo "[TASK 2] Creating Deployment"
echo

kubectl apply -f deployment.yaml


echo
echo "[TASK 3] Creating Horizontal Pod Scaling"
echo

kubectl apply -f hpa.yaml