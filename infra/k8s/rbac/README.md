# Create a POD user

The pod user's role allows for **create,list,get,update,delete** pods
in the **easypay** namespace

**usage:**

**Via scripts:**

```sh
sh ./create-certificate.sh
sh ./apply.sh
# To create user's config and test using kubectl
sh ./create-pod-user-config.sh
```

**Or manually:**

```sh

# Generate key and CSR of the certificate for the pod user
openssl genrsa -out  easypay-pod-user.key 2048
openssl req -new -key easypay-pod-user.key -out easypay-pod-user.csr -subj "/CN=easypay-pod-user/O=easypay"

# Replace the CSR in the csr.yaml
CSR=$(cat easypay-pod-user.csr | base64 | tr -d '\n')
sed -i "s/__CSR___/${CSR}/g" easypay-pod-user-csr.yaml

# Request k8s to sign our CSR
kubectl apply -f easypay-pod-user-csr.yaml
kubectl get csr
kubectl certificate approve easypay-pod-user

# wait a few seconds for approval of the CSR

kubectl apply -f easypay-role.yaml

kubectl get roles -n easypay

kubectl apply -f easypay-roleBinding.yaml

kubectl get rolebindings -n easypay

kubectl describe rolebinding easypay-pod-role-rolebinding -n easypay

# check if user has access to list pods
kubectl auth can-i list pods --as easypay-pod-user -n easypay

# check if user has access to create pods
kubectl auth can-i create pods --as easypay-pod-user -n easypay
```
