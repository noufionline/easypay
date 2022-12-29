variable "controller_ips" {
  type = list(string)

  default = [
    "172.16.16.101"
  ]
}

variable "worker_ips" {
  type = list(string)

  default = [
    "172.16.16.201",
    "172.16.16.202",
    "172.16.16.203"
  ]
}

variable "worker_pod_cidrs" {
  type = list(string)

  default = [
    "192.168.0.0/24",
    "192.168.1.0/24",
    "192.168.2.0/24"
  ]
}

variable "PUBLIC_KEY_PATH" {
  type = string
  default = "~/.ssh/id_rsa.pub"
}

variable "PRIV_KEY_PATH" {
  type = string
  default = "~/.ssh/id_rsa"
}