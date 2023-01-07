# ETCD take backup snapshot

This section has two scripts: one to download etcdctl and the other to
actually do the backup of the snapshot.

**Usage:**

```sh
sh ./script-to-download-etcdctl.sh  # download the utility first

sh ./script-to-backup-etcd-snapshot.sh
```

**backup-etcd-snapshot.sh:**

```sh
#!/bin/bash

set -x

# Create temp folder

WORK_DIR=/tmp/etcd

[ -d ${WORK_DIR} ] || mkdir -p ${WORK_DIR}

cd ${WORK_DIR}

# Create snapshot

ETCD_PKI_DIR=/etc/kubernetes/pki/etcd

sudo ETCDCTL_API=3

etcdctl snapshot save snapshot.db \
   --cacert \${ETCD_PKI_DIR}/ca.crt \
   --cert \${ETCD_PKI_DIR}/server.crt \
   --key \${ETCD_PKI_DIR}/server.key
```

**download-etcdctl.sh:**

```sh
#!/bin/bash

set -x

# Create temp folder

WORK_DIR=/tmp/etcd

[ -d ${WORK_DIR} ] || mkdir -p ${WORK_DIR}

cd ${WORK_DIR}

# Get the latest from the releases folder

curl -s https://api.github.com/repos/etcd-io/etcd/releases/latest |\
   grep browser_download_url |\
   grep linux-amd64 |\
   cut -d '"' -f 4 | wget -qi -

# Extract the archive

tar xvf *.tar.gz

# Install in /usr/local/bin

cd etcd-*/

sudo mv etcd* /usr/local/bin/

# Cleanup

cd ..

rm -rf *.tar.gz etcd-*/
```


**download.sh:**
```
#!//bin/bash


export RELEASE=$(kubectl exec -it etcd-k8s-master1 -n kube-system -- /bin/sh -c 'ETCDCTL_API=3 /usr/local/bin/etcd --version' | head -n 1 | awk '{ print $3 }')

wget https://github.com/etcd-io/etcd/releases/download/v${RELEASE}/etcd-v${RELEASE}-linux-amd64.tar.gz

tar -zxvf etcd-v${RELEASE}-linux-amd64.tar.gz

cd etcd-v${RELEASE}-linux-amd64/

sudo cp etcdctl /usr/local/bin

etcdctl version
```
