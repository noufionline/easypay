#!/bin/bash

#Get the etcd pod name
etcd_pod=$(kubectl get pods -n kube-system | grep etcd | awk '{ print $1 }')

# Store etcd version to a variable

release=$(kubectl exec -it etcd-k8s-master1 -n kube-system -- /bin/sh -c 'ETCDCTL_API=3 /usr/local/bin/etcd --version' | awk '{ print $3 }' | head -1 | sed 's/\r$//')



echo "The release used inside the ${etcd_pod} is ${release}"

echo "[TASK 1] Download the version ${release}"
echo

wget  https://github.com/etcd-io/etcd/releases/download/v${release}/etcd-v${release}-linux-amd64.tar.gz

echo 

echo "[TASK 2] Extract the zip file"
echo

tar -zxvf etcd-v${release}-linux-amd64.tar.gz

echo 

echo "[TASK 3] Install in /usr/local/bin"
echo
sudo mv etcd-v${release}-linux-amd64/etcdctl /usr/local/bin

echo

echo "[TASK 4] Check the installed version"
echo
etcdctl version
echo


echo "[TASK 5] Cleanup"
echo

rm -rf *.tar.gz etcd-*/
