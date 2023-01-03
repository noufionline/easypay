#!/bin/bash

echo
echo "[TASK 1] Delete Deployment"
echo

kubectl delete -f deployment.yaml

echo
echo "[TASK 2] Delete Horizontal Pod Scaling"
echo

kubectl delete -f hpa.yaml

echo
echo "[TASK 3] Delete Metric Server"
echo

kubectl delete -f metrics-server.yaml

