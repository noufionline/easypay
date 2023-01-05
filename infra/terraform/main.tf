variable "region" {
  default = "us-east-2"
}

resource "aws_vpc" "k8s" {
  cidr_block           = "172.16.0.0/16"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"

  tags = {
    Name = "k8s-vpc"
  }
}

resource "aws_subnet" "k8s" {
  vpc_id     = "${aws_vpc.k8s.id}"
  cidr_block = "172.16.16.0/24"

  tags = {
    Name = "k8s-public-subnet"
  }
}

resource "aws_internet_gateway" "k8s" {
  vpc_id = "${aws_vpc.k8s.id}"

  tags = {
    Name = "k8s-ig"
  }
}

resource "aws_route_table" "k8s" {
  vpc_id = "${aws_vpc.k8s.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.k8s.id}"
  }

  tags = {
    Name = "k8s-rt"
  }
}

resource "aws_route_table_association" "k8s" {
  subnet_id      = "${aws_subnet.k8s.id}"
  route_table_id = "${aws_route_table.k8s.id}"
}


# Controller security group

resource "aws_security_group" "controller" {
  name        = "k8s-controller"
  description = "Kubernetes Controller Security Group"
  vpc_id      = "${aws_vpc.k8s.id}"
  
  tags = {
    Name = "k8s-controller-sg"
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["172.16.16.0/24", "192.168.0.0/16"]
  }
}


# Worker security group

resource "aws_security_group" "worker" {
  name        = "k8s-worker"
  description = "Kubernetes Worker Security Group"

  vpc_id      = "${aws_vpc.k8s.id}"

  tags = {
    "Name" = "k8s-worker-sg"
  }

   ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["172.16.16.0/24", "192.168.0.0/16"]
  }
}



resource "aws_security_group_rule" "controller_allow_ping" {
  type = "ingress"
  from_port = 8 #this strange syntax to allow ping
  to_port = -1
  protocol = "icmp"
  source_security_group_id = aws_security_group.worker.id
  description = "to allow ping in from worker"
  security_group_id = aws_security_group.controller.id
}

resource "aws_security_group_rule" "controller-apiserver" {
  security_group_id = aws_security_group.controller.id

  type        = "ingress"
  protocol    = "tcp"
  from_port   = 0
  to_port     = 6443
  cidr_blocks = ["0.0.0.0/0"]
}

# etcd server client API
resource "aws_security_group_rule" "controller-etcd" {
  security_group_id = aws_security_group.controller.id

  type      = "ingress"
  protocol  = "tcp"
  from_port = 2379
  to_port   = 2380
  self      = true
}



# Allow apiserver to access kubelets for exec, log, port-forward (Kubelet API)
resource "aws_security_group_rule" "controller-kubelet-api" {
  security_group_id = aws_security_group.controller.id

  type                     = "ingress"
  protocol                 = "tcp"
  from_port                = 10250
  to_port                  = 10250
  source_security_group_id = aws_security_group.worker.id
}


resource "aws_security_group_rule" "controller-kubelet-api-self" {
  security_group_id = aws_security_group.controller.id

  type      = "ingress"
  protocol  = "tcp"
  from_port = 10250
  to_port   = 10250
  self      = true
}

resource "aws_security_group_rule" "controller-kube-scheduler" {
  security_group_id = aws_security_group.controller.id

  type      = "ingress"
  protocol  = "tcp"
  from_port = 10259
  to_port   = 10259
  self      = true
}

resource "aws_security_group_rule" "controller-kube-controller-manager" {
  security_group_id = aws_security_group.controller.id

  type      = "ingress"
  protocol  = "tcp"
  from_port = 10257
  to_port   = 10257
  self      = true
}


resource "aws_security_group_rule" "controller-ssh" {
  security_group_id = aws_security_group.controller.id

  type        = "ingress"
  protocol    = "tcp"
  from_port   = 22
  to_port     = 22
  cidr_blocks = ["0.0.0.0/0"]
}


resource "aws_security_group_rule" "controller-nodeport-services" {
  security_group_id = aws_security_group.controller.id

  type      = "ingress"
  protocol  = "tcp"
  from_port = 80
  to_port   = 30001
  cidr_blocks      = ["0.0.0.0/0"] 
}


resource "aws_security_group_rule" "controller-egress" {
  security_group_id = aws_security_group.controller.id

  type             = "egress"
  protocol         = "-1"
  from_port        = 0
  to_port          = 0
  cidr_blocks      = ["0.0.0.0/0"]
  ipv6_cidr_blocks = ["::/0"]
}


resource "aws_security_group_rule" "worker_allow_ping" {
  type = "ingress"
  from_port = 8 #this strange syntax to allow ping
  to_port = -1
  protocol = "icmp"
  source_security_group_id = aws_security_group.controller.id
  description = "to allow ping in from controller"
  security_group_id = aws_security_group.worker.id
}


# Allow apiserver to access kubelets for exec, log, port-forward
resource "aws_security_group_rule" "worker-kubelet-api" {
  security_group_id = aws_security_group.worker.id

  type                     = "ingress"
  protocol                 = "tcp"
  from_port                = 10250
  to_port                  = 10250
  source_security_group_id = aws_security_group.controller.id
}

resource "aws_security_group_rule" "worker-kubelet-api-self" {
  security_group_id = aws_security_group.worker.id

  type      = "ingress"
  protocol  = "tcp"
  from_port = 10250
  to_port   = 10250
  self      = true
}


resource "aws_security_group_rule" "worker-nodeport-services" {
  security_group_id = aws_security_group.worker.id

  type      = "ingress"
  protocol  = "tcp"
  from_port = 80
  to_port   = 30001
  cidr_blocks      = ["0.0.0.0/0"] 
}
resource "aws_security_group_rule" "worker-ssh" {
  security_group_id = aws_security_group.worker.id

  type        = "ingress"
  protocol    = "tcp"
  from_port   = 22
  to_port     = 22
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "worker-http" {
  security_group_id = aws_security_group.worker.id

  type        = "ingress"
  protocol    = "tcp"
  from_port   = 80
  to_port     = 80
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "worker-https" {
  security_group_id = aws_security_group.worker.id

  type        = "ingress"
  protocol    = "tcp"
  from_port   = 443
  to_port     = 443
  cidr_blocks = ["0.0.0.0/0"]
}



resource "aws_security_group_rule" "worker-egress" {
  security_group_id = aws_security_group.worker.id

  type             = "egress"
  protocol         = "-1"
  from_port        = 0
  to_port          = 0
  cidr_blocks      = ["0.0.0.0/0"]
  ipv6_cidr_blocks = ["::/0"]
}




resource "aws_lb" "k8s" {
  name               = "kubernetes"
  subnets            = ["${aws_subnet.k8s.id}"]
  internal           = false
  load_balancer_type = "network"
}

resource "aws_lb_target_group" "k8s" {
  name        = "kubernetes"
  protocol    = "TCP"
  port        = 6443
  vpc_id      = "${aws_vpc.k8s.id}"
  target_type = "ip"
}

resource "aws_lb_target_group_attachment" "k8s" {
  count            = "${length(var.controller_ips)}"
  target_group_arn = "${aws_lb_target_group.k8s.arn}"
  target_id        = "${var.controller_ips[count.index]}"
}

resource "aws_lb_listener" "k8s" {
  load_balancer_arn = "${aws_lb.k8s.arn}"
  protocol          = "TCP"
  port              = 6443

  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.k8s.arn}"
  }
}


# Sends your public key to the instance
resource "aws_key_pair" "k8s" {
  key_name   = "k8s"
  public_key = file(var.PUBLIC_KEY_PATH)
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  owners = ["099720109477"]
}

resource "aws_instance" "controller" {
  count                       = "${length(var.controller_ips)}"
  ami                         = "${data.aws_ami.ubuntu.id}" 
 
  associate_public_ip_address = true
  key_name                    = "${aws_key_pair.k8s.key_name}"
  vpc_security_group_ids      = ["${aws_security_group.controller.id}"]
  instance_type               = "t2.medium"
  private_ip                  = "${var.controller_ips[count.index]}"
  subnet_id                   = "${aws_subnet.k8s.id}"
  source_dest_check           = false

  tags = {
    Name = "k8s-master${count.index+1}"
  }
}




resource "aws_instance" "worker" {
  count                       = "${length(var.worker_ips)}"
  ami                         = "${data.aws_ami.ubuntu.id}"
  associate_public_ip_address = true
  key_name                    = "${aws_key_pair.k8s.key_name}"
  vpc_security_group_ids      = ["${aws_security_group.worker.id}"]
  instance_type               = "t2.micro"
  private_ip                  = "${var.worker_ips[count.index]}"
  subnet_id                   = "${aws_subnet.k8s.id}"
  source_dest_check           = false

  tags = {
    Name = "k8s-worker${count.index+1}"
  }

}



resource "null_resource" "k8s_controller_bootstrap" {

  count = "${length(var.controller_ips)}"

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file(var.PRIV_KEY_PATH)
    host        = "${element(aws_instance.controller.*.public_ip, count.index)}"
  }
  
    provisioner "remote-exec" {
    inline = [
      "sudo hostnamectl set-hostname k8s-master${count.index + 1}"
    ]

    }
}

resource "null_resource" "k8s_worker_bootstrap" {

  count = "${length(var.worker_ips)}"

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file(var.PRIV_KEY_PATH)
    host        = "${element(aws_instance.worker.*.public_ip, count.index)}"
  }

  provisioner "remote-exec" {
  inline = [
    "sudo hostnamectl set-hostname k8s-worker${count.index + 1}"
  ]
    }
}



# generate inventory file for Ansible
resource "local_file" "hosts_cfg" {
  content = templatefile("../terraform/templates/hosts.tpl",
    {
      master_ips = aws_instance.controller.*.public_ip
      worker_ips = aws_instance.worker.*.public_ip
    }
  )
  filename = "../ansible/hosts.ini"
}

output "controller_instance_ips" {
  value = aws_instance.controller.*.public_ip
}

output "worker_instance_ips" {
  value = aws_instance.worker.*.public_ip
}