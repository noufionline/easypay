kubectl apply -f easypay-pod-user-csr.yaml
kubectl get csr

kubectl certificate approve easypay-pod-user

echo "waiting ...."

sleep 20

kubectl apply -f easypay-role.yaml

kubectl get roles -n easypay

kubectl apply -f easypay-roleBinding.yaml

kubectl get rolebindings -n easypay

kubectl describe rolebinding easypay-pod-role-rolebinding -n easypay

kubectl auth can-i list pods --as easypay-pod-user -n easypay

kubectl auth can-i create pods --as easypay-pod-user -n easypay
