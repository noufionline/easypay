#!//bin/bash
export ETCD_POD=$(kubectl get pods -n kube-system | grep etcd | awk '{print $1}' | head -n 1)

export RELEASE=$(kubectl exec -it ${ETCD_POD} -n kube-system -- /bin/sh -c 'ETCDCTL_API=3 /usr/local/bin/etcd --version' | head -n 1 | awk '{ print $3 }')

wget https://github.com/etcd-io/etcd/releases/download/v${RELEASE}/etcd-v${RELEASE}-linux-amd64.tar.gz

tar -zxvf etcd-v${RELEASE}-linux-amd64.tar.gz

cd etcd-v${RELEASE}-linux-amd64/

sudo cp etcdctl /usr/local/bin

etcdctl version
