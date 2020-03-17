resource "aws_eks_node_group" "personalerp_nodegroup01" {
  cluster_name    = var.cluster_name
  node_group_name = "${local.node_name}01"
  node_role_arn   = aws_iam_role.personalerp-eks-node-role.arn
  instance_types  = ["t2.micro"]

  subnet_ids = var.eks_subnet_ids

  scaling_config {
    desired_size = 2
    max_size     = 2
    min_size     = 2
  }
  
  tags = var.tags

  depends_on = [
    aws_iam_role_policy_attachment.personalerp-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.personalerp-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.personalerp-AmazonEC2ContainerRegistryReadOnly,
  ]
}