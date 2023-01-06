#!/bin/bash

kubectl apply -f service.yaml
kubectl get svc -n easypay
kubectl describe svc easypay-api-service -n easypay

kubectl apply -f deployment.yaml
kubectl get deploy -n easypay
kubectl describe deploy easypay-api  -n easypay
kubectl  get pod -n easypay
kubectl describe pod easypay-api-d4f895cf9-97q6w -n easypay
