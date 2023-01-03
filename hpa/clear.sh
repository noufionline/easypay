#!/bin/bash
kubectl delete -f deployment.yaml
kubectl delete -f hpa.yaml
kubectl delete -f metrics-server.yaml

