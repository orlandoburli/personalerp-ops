# Cluster initial setup
resource "aws_eks_cluster" "personalerp_cluster" {
  name     = "personalerp-cluster-${var.personalerp_env}"
  role_arn = aws_iam_role.personalerp-eks-cluster-role.arn

  tags = {
    Env = var.personalerp_env
  }

  vpc_config {
    endpoint_private_access = true

    subnet_ids = [
      "${aws_subnet.personalerp-eks-subnet01.id}", 
      "${aws_subnet.personalerp-eks-subnet02.id}",
      "${aws_subnet.personalerp-eks-subnet03.id}"
      ]
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    aws_iam_role_policy_attachment.personalerp-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.personalerp-AmazonEKSServicePolicy,
  ]
}