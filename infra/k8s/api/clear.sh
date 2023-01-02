#!/bin/bash
kubectl delete -f metric-server.yaml
kubectl delete -f deployment.yaml
kubectl delete -f service.yaml
