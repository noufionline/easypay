
echo "[TASK 1] Create Certificate Request"
echo
kubectl apply -f easypay-user-csr.yaml
echo
kubectl get csr

echo

echo "[TASK 2] Approve Certificate Request"
echo
kubectl certificate approve easypay-user
echo
echo "waiting ...."
echo
sleep 10
echo
echo "[TASK 3] Create Role"
echo
kubectl apply -f easypay-create-role.yaml

echo "List Role...."
echo
kubectl get roles -n easypay....


echo "[TASK 4] Create Role Binding"
echo
kubectl apply -f easypay-create-role-binding.yaml

echo

echo "List Role Binding...."
echo
kubectl get rolebindings -n easypay

echo
echo "Describe Role Binding...."
echo

kubectl describe rolebinding easypay-user-role-binding -n easypay


echo
echo "[TASK 5] Check whether user can List Pods?"
echo
kubectl auth can-i list pods --as easypay-user -n easypay

echo
echo "[TASK 6] Check whether user can Create Pods?"
echo
kubectl auth can-i create pods --as easypay-user -n easypay
