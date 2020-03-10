resource "tls_private_key" "eks-private-key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "eks-key-pair" {
  key_name   = "eks-key-pair-${var.personalerp_env}"
  public_key = tls_private_key.eks-private-key.public_key_openssh
}