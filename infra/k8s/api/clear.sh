#!/bin/bash

echo
echo "[TASK 1] Delete Deployment"
echo

kubectl delete -f deployment.yaml

echo
echo "[TASK 2] Delete Service"
echo

kubectl delete -f service.yaml
