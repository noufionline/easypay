# ETCD take backup snapshot

This section has two scripts: one to download etcdctl and the other to
actually do the backup of the snapshot.

**Usage:**

```sh
sh ./download-etcdctl.sh  # download the utility first

sh ./backup-etcd-snapshot.sh
```

**download-etcdctl.sh:**

```sh
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
```



**backup-etcd-snapshot.sh:**

```sh
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

ls -la



```
