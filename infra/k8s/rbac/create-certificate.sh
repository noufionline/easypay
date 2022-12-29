#!/bin/bash

set -x

openssl genrsa -out  easypay-pod-user.key 2048
openssl req -new -key easypay-pod-user.key -out easypay-pod-user.csr -subj "/CN=easypay-pod-user/O=easypay"

# Replace the CSR in the csr.yaml
CSR=$(cat easypay-pod-user.csr | base64 | tr -d '\n')
sed -i "s/__CSR___/${CSR}/g" easypay-pod-user-csr.yaml
