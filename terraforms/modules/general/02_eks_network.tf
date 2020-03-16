// # General VPC

resource "aws_vpc" "personalerp_private_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "personalerp_private_vpc"
    Env = var.personalerp_env
  }
}

resource "aws_internet_gateway" "personalerp_internet_gateway" {
  vpc_id = aws_vpc.personalerp_private_vpc.id

  tags = {
    Name = "personalerp_internet_gateway"
    Env = var.personalerp_env
  }
}

// # End General VPC

// # Network for Cluster

// resource "aws_subnet" "personalerp-eks-subnet01" {
//   vpc_id     = aws_vpc.personalerp_private_vpc.id
//   cidr_block = "10.0.1.0/24"
//   availability_zone = "sa-east-1a"

//   tags = {
//     Name = "personalerp-eks-subnet01"
//     Env = var.personalerp_env
//   }
// }

// resource "aws_subnet" "personalerp-eks-subnet02" {
//   vpc_id     = aws_vpc.personalerp_private_vpc.id
//   cidr_block = "10.0.2.0/24"
//   availability_zone = "sa-east-1b"

//   tags = {
//     Name = "personalerp-eks-subnet02"
//     Env = var.personalerp_env
//   }
// }

// resource "aws_subnet" "personalerp-eks-subnet03" {
//   vpc_id     = aws_vpc.personalerp_private_vpc.id
//   cidr_block = "10.0.3.0/24"
//   availability_zone = "sa-east-1c"

//   tags = {
//     Name = "personalerp-eks-subnet03"
//     Env = var.personalerp_env
//   }
// }

// resource "aws_security_group" "personalerp-eks-securitgroup-subnet" {
//   vpc_id = aws_vpc.personalerp_private_vpc.id

//   ingress {
//     cidr_blocks = [
//       "${aws_subnet.personalerp-eks-subnet01.cidr_block}", 
//       "${aws_subnet.personalerp-eks-subnet02.cidr_block}", 
//       "${aws_subnet.personalerp-eks-subnet03.cidr_block}"]
//     from_port   = 80
//     to_port     = 80
//     protocol    = "tcp"
//   }
// }
// # End Network for Cluster

// # Network for EKS Node Groups
resource "aws_subnet" "personalerp-nodegroup01-subnet01" {
  vpc_id     = aws_vpc.personalerp_private_vpc.id
  cidr_block = "10.0.4.0/24"
  availability_zone = "sa-east-1a"

  tags = {
    Name = "personalerp-nodegroup01-subnet01"
    Env = var.personalerp_env,
    "kubernetes.io/cluster/${aws_eks_cluster.personalerp_cluster.name}" = "shared"
  }
}

// resource "aws_subnet" "personalerp-nodegroup01-subnet02" {
//   vpc_id     = aws_vpc.personalerp_private_vpc.id
//   cidr_block = "10.0.5.0/24"
//   availability_zone = "sa-east-1b"

//   tags = {
//     Name = "personalerp-nodegroup01-subnet02"
//     Env = var.personalerp_env,
//     "kubernetes.io/cluster/${aws_eks_cluster.personalerp_cluster.name}" = "shared"
//   }
// }

// resource "aws_subnet" "personalerp-nodegroup01-subnet03" {
//   vpc_id     = aws_vpc.personalerp_private_vpc.id
//   cidr_block = "10.0.6.0/24"
//   availability_zone = "sa-east-1c"

//   tags = {
//     Name = "personalerp-nodegroup01-subnet03"
//     Env = var.personalerp_env,
//     "kubernetes.io/cluster/${aws_eks_cluster.personalerp_cluster.name}" = "shared"
//   }
// }

// resource "aws_security_group" "personalerp-nodegroup01-securitgroup-subnet" {
//   vpc_id = aws_vpc.personalerp_private_vpc.id

//   ingress {
//     cidr_blocks = [
//       "${aws_subnet.personalerp-nodegroup01-subnet01.cidr_block}", 
//       "${aws_subnet.personalerp-nodegroup01-subnet02.cidr_block}", 
//       "${aws_subnet.personalerp-nodegroup01-subnet03.cidr_block}",
//       ]
//     from_port   = 80
//     to_port     = 80
//     protocol    = "tcp"
//   }
// }

// # End Network for EKS Node Groups

module "network" {
  
}