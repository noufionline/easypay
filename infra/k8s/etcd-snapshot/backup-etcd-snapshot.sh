#!/bin/bash

echo "[TASK 1] Create /tmp/etcd temp directory"
echo
sudo mkdir /tmp/etcd
echo

echo "[TASK 2] Change directory to /tmp/etcd"
echo
cd /tmp/etcd/
echo

echo "[TASK 3] Change Take the snapshot"
echo
sudo ETCDCTL_API=3 \
  etcdctl snapshot save easypay-snapshot.db   \
  --cacert /etc/kubernetes/pki/etcd/ca.crt     \
  --cert   /etc/kubernetes/pki/etcd/server.crt \
  --key    /etc/kubernetes/pki/etcd/server.key

echo

echo "[TASK 4] Check the snapshot"
echo

ls  -la
