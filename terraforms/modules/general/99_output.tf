output "endpoint" {
  value = "${aws_eks_cluster.personalerp_cluster.endpoint}"
}

output "kubeconfig-certificate-authority-data" {
  value = "${aws_eks_cluster.personalerp_cluster.certificate_authority.0.data}"
}