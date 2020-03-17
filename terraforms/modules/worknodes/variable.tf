locals {
  node_name = "personalerp-node-${var.tags["Env"]}"
}

variable "eks_subnet_ids" { }
variable "cluster_name" { }
variable "tags" { }