#!/bin/bash

kubectl apply -f namespace.yaml
kubectl get ns

kubectl apply -f network-policy.yaml
kubectl get netpol -n easypay
kubectl describe netpol frontend-to-backend-access -n easypay

kubectl apply -f postgres-config.yaml
kubectl get configmap -n easypay
kubectl describe configmap postgres-config -n easypay


kubectl apply -f postgres-secret.yaml
kubectl get secret postgres-secret -n easypay
kubectl describe secret postgres-secret -n easypay


kubectl apply -f persistent-volume.yaml
kubectl get pv -n easypay
kubectl describe pv -n easypay


kubectl apply -f persistent-volume-claim.yaml
kubectl get pvc -n easypay
kubectl describe pvc easypay-postgres-pvc -n easypay


kubectl apply -f service.yaml
kubectl get svc -n easypay
kubectl describe svc easypay-backend-service  -n easypay
kubectl get pods -n easypay



kubectl apply -f deployment.yaml
kubectl get deploy -n easypay
kubectl describe deploy easypay-db -n easypay
