#!//bin/bash


export RELEASE=$(kubectl exec -it etcd-k8s-master1 -n kube-system -- /bin/sh -c 'ETCDCTL_API=3 /usr/local/bin/etcd --version' | head -n 1 | awk '{ print $3 }')

wget https://github.com/etcd-io/etcd/releases/download/v${RELEASE}/etcd-v${RELEASE}-linux-amd64.tar.gz

tar -zxvf etcd-v${RELEASE}-linux-amd64.tar.gz

cd etcd-v${RELEASE}-linux-amd64/

sudo cp etcdctl /usr/local/bin

etcdctl version
