# Cluster initial setup
resource "aws_eks_cluster" "personalerp_cluster" {
  name     = var.cluster_name
  role_arn = aws_iam_role.personalerp-eks-cluster-role.arn
  version  = "1.15"

  tags = var.tags

  vpc_config {
    subnet_ids = var.eks_subnet_ids
  }

  depends_on = [
    aws_iam_role_policy_attachment.personalerp-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.personalerp-AmazonEKSServicePolicy,
  ]
}