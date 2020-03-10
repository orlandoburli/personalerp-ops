# Rule for cluster
resource "aws_iam_role" "personalerp-eks-cluster-role" {
  name = "personalerp-eks-cluster-role"
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "personalerp-AdministratorAccess" {
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
  role       = aws_iam_role.personalerp-eks-cluster-role.name
}

resource "aws_iam_role_policy_attachment" "personalerp-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.personalerp-eks-cluster-role.name
}

resource "aws_iam_role_policy_attachment" "personalerp-AmazonEKSServicePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = aws_iam_role.personalerp-eks-cluster-role.name
}

resource "aws_iam_openid_connect_provider" "iam_openid_provider_personalerp" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = []
  url             = aws_eks_cluster.personalerp_cluster.identity.0.oidc.0.issuer
}

data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "openid_personalerp_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${replace(aws_iam_openid_connect_provider.iam_openid_provider_personalerp.url, "https://", "")}:sub"
      values   = ["system:serviceaccount:kube-system:aws-node"]
    }

    principals {
      identifiers = ["${aws_iam_openid_connect_provider.iam_openid_provider_personalerp.arn}"]
      type        = "Federated"
    }
  }
}

resource "aws_iam_role" "personalerp-eks-cluster-role-openid" {
  assume_role_policy = data.aws_iam_policy_document.openid_personalerp_assume_role_policy.json
  name               = "personalerp-eks-cluster-role-openid"
}

# End Rule for cluster

# Rule for Node Groups
resource "aws_iam_role" "personalerp-eks-node-role" {
  name = "personalerp-eks-node-role"

  assume_role_policy = jsonencode({
    Statement = [{
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "personalerp-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.personalerp-eks-node-role.name
}

resource "aws_iam_role_policy_attachment" "personalerp-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.personalerp-eks-node-role.name
}

resource "aws_iam_role_policy_attachment" "personalerp-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.personalerp-eks-node-role.name
}

resource "aws_iam_role_policy_attachment" "personalerp2-AdministratorAccess" {
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
  role       = aws_iam_role.personalerp-eks-node-role.name
}

# End Rule for Node Groups