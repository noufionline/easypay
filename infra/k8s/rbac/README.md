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
openssl genrsa -out  easypay-user.key 2048
openssl req -new -key easypay-user.key -out easypay-user.csr -subj "/CN=easypay-user/O=easypay"

# Replace the CSR in the csr.yaml
CSR=$(cat easypay-user.csr | base64 | tr -d '\n')
sed -i "s/__CSR___/${CSR}/g" easypay-user-csr.yaml

# Request k8s to sign our CSR
kubectl apply -f easypay-user-csr.yaml
kubectl get csr
kubectl certificate approve easypay-user

# wait a few seconds for approval of the CSR

kubectl apply -f easypay-role.yaml

kubectl get roles -n easypay

kubectl apply -f easypay-roleBinding.yaml

kubectl get rolebindings -n easypay

kubectl describe rolebinding easypay-role-rolebinding -n easypay

# check if user has access to list pods
kubectl auth can-i list pods --as easypay-user -n easypay

# check if user has access to create pods
kubectl auth can-i create pods --as easypay-user -n easypay
```
