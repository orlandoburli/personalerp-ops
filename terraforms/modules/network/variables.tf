locals {
  cluster_name = "personalerp-cluster-${var.tags["Env"]}"
}
variable "tags" { }
variable "vpc_tags" { }