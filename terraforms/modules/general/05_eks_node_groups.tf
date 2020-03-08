resource "aws_eks_node_group" "personalerp_cluster_nodegroup01" {
  cluster_name    = aws_eks_cluster.personalerp_cluster.name
  node_group_name = "personalerp_cluster_node01_${var.personalerp_env}"
  node_role_arn   = aws_iam_role.personalerp-eks-node-role.arn

  subnet_ids = [
      "${aws_subnet.personalerp-nodegroup01-subnet01.id}", 
      "${aws_subnet.personalerp-nodegroup01-subnet02.id}",
      "${aws_subnet.personalerp-nodegroup01-subnet03.id}"
      ]

  scaling_config {
    desired_size = 2
    max_size     = 2
    min_size     = 2
  }

  remote_access {
    ec2_ssh_key = aws_key_pair.eks-key-pair.key_name
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.personalerp-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.personalerp-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.personalerp-AmazonEC2ContainerRegistryReadOnly,
  ]
}