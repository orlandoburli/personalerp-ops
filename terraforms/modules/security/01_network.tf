# Database VPC
resource "aws_vpc" "personalerp_db_vpc" {
  cidr_block = "11.0.0.0/16"

  tags = {
    Name = "personalerp_db_private_vpc"
    Env = var.personalerp_env
  }
}

# End Database VPC

# Network for Database

resource "aws_subnet" "personalerp-db-subnet01" {
  vpc_id     = aws_vpc.personalerp_db_vpc.id
  cidr_block = "11.0.1.0/24"
  availability_zone = "sa-east-1a"

  tags = {
    Name = "personalerp-db-subnet01"
    Env = var.personalerp_env
  }
}

resource "aws_subnet" "personalerp-db-subnet02" {
  vpc_id     = aws_vpc.personalerp_db_vpc.id
  cidr_block = "11.0.2.0/24"
  availability_zone = "sa-east-1b"

  tags = {
    Name = "personalerp-db-subnet02"
    Env = var.personalerp_env
  }
}

resource "aws_subnet" "personalerp-db-subnet03" {
  vpc_id     = aws_vpc.personalerp_db_vpc.id
  cidr_block = "11.0.3.0/24"
  availability_zone = "sa-east-1c"

  tags = {
    Name = "personalerp-db-subnet03"
    Env = var.personalerp_env
  }
}
# End Network for Cluster

