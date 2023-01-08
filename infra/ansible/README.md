**Create easypayadm user to execute the ansible playbook**

```sh
ansible-plabook create-user.yaml
```

![create user](https://github.com/noufionline/easypay/blob/main/execution-info/images/ansible/create-user-playbook.png)

```sh
ansible-plabook install-kubernetes.yaml
```

![install kubernetes](https://github.com/noufionline/easypay/blob/main/execution-info/images/ansible/install-kubernetes-playbook.png)

```sh
ansible-plabook create-master-node.yaml
```

![create master node](https://github.com/noufionline/easypay/blob/main/execution-info/images/ansible/create-master-node-playbook.png)

```sh
ansible-plabook create-worker-nodes.yaml
```

![create worker nodes](https://github.com/noufionline/easypay/blob/main/execution-info/images/ansible/create-worker-nodes-playbook.png)


![ssh to control plane](https://github.com/noufionline/easypay/blob/main/execution-info/images/ansible/ssh-to-control-plane-node.png.png)


**Bingo the cluster is ready up and running! lets check it out.**

```sh
kubectl get nodes
```
![nodes](https://github.com/noufionline/easypay/blob/main/execution-info/images/ansible/DC1A7E2C-D40F-4789-BB9E-ED7FC80105FA_4_5005_c.jpeg)
