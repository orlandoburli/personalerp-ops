resource "aws_vpc" "personalerp_private_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = merge(
      map("Name", "personalerp_private_vpc"),
      map("kubernetes.io/cluster/${local.cluster_name}", "shared"),
      var.tags
  )
}

resource "aws_internet_gateway" "personalerp_internet_gateway" {
  vpc_id = aws_vpc.personalerp_private_vpc.id

  tags = merge(
    map("Name", "personalerp_internet_gateway"),
      var.tags
  )
}

data "aws_availability_zones" "available" {}

resource "aws_subnet" "personalerp-eks-subnet" {
  count = 3
  vpc_id                  = aws_vpc.personalerp_private_vpc.id
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  cidr_block              = cidrsubnet(aws_vpc.personalerp_private_vpc.cidr_block, 8, count.index)
  map_public_ip_on_launch = false

  tags = merge(
      map("Name", "personalerp-eks-subnet"),
      map("kubernetes.io/cluster/${local.cluster_name}", "shared"),
      var.tags
  )
}

resource "aws_route_table" "personalerp_route_table" {
  vpc_id = aws_vpc.personalerp_private_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.personalerp_internet_gateway.id
  }

  tags = merge(
      map("Name", "personalerp-route-table"),
      var.tags
    )
}

resource "aws_route_table_association" "personalerp_route_table_associacion" {
  subnet_id      = aws_subnet.personalerp-eks-subnet.*.id[count.index]
  route_table_id = aws_route_table.personalerp_route_table.id
  count          = 3
}