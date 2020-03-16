variable "personalerp_env" {}
variable "region" {}
variable "kubernetes_version" {
  default = "1.15"
}

variable "kubeconfig_path" {
  default = "~/.kube/config"
}

variable "tags" {
  default = ""
}

variable "cluster_name" {}
variable "attributes" {}
variable "namespace" {
  default = "personalerp"
}
variable "stage" {}
variable "attributes" {}