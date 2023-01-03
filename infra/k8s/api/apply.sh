#!/bin/bash

echo
echo "[TASK 1] Creating Service"
echo

kubectl apply -f service.yaml

echo
echo "[TASK 2] Creating Deployment"
echo

kubectl apply -f deployment.yaml
