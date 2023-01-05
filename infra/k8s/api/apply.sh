#!/bin/bash


echo
echo "[TASK 1] Install Metrics Server"
echo

kubectl apply -f metrics-server.yaml

echo
echo "[TASK 2] Creating Horizontal Pod Autoscaling"
echo

kubectl apply -f hpa.yaml

echo
echo "[TASK 3 Creating Service"
echo

kubectl apply -f service.yaml

echo
echo "[TASK 4] Creating Deployment"
echo

kubectl apply -f deployment.yaml
