#!/bin/bash

set -x

openssl genrsa -out  easypay-user.key 2048
openssl req -new -key easypay-user.key -out easypay-user.csr -subj "/CN=easypay-user/O=easypay"

# Replace the CSR in the csr.yaml
CSR=$(cat easypay-user.csr | base64 | tr -d '\n')
sed -i "s/__CSR___/${CSR}/g" easypay-user-csr.yaml
