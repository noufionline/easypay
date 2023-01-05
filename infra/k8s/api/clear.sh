#!/bin/bash

echo
echo "[TASK 1] Delete Deployment"
echo

kubectl delete -f deployment.yaml

echo
echo "[TASK 2] Delete Service"
echo

kubectl delete -f service.yaml


echo
echo "[TASK 3] Delete Horizontal Pod Autoscaling"
echo

kubectl delete -f hpa.yaml

echo
echo "[TASK 2] Delete Metrics Server"
echo

kubectl delete -f metrics-server.yaml
