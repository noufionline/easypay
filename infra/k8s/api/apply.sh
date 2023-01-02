#!/bin/bash
kubectl apply -f service.yaml
kubectl apply -f hpa-by-cpu.yaml
kubectl apply -f hpa-by-memory.yaml
kubectl apply -f deployment.yaml
