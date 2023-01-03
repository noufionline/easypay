#!/bin/bash
kubectl apply -f metrics-server.yaml
kubectl apply -f deployment.yaml
kubectl apply -f hpa.yaml