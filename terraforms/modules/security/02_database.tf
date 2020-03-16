resource "random_password" "password" {
  length = 16
  special = true
  override_special = "_%@"
}

resource "aws_db_subnet_group" "personalerp-security-db-network" {
  name       = "main"
  subnet_ids = [
    "${aws_subnet.personalerp-db-subnet01.id}", 
    "${aws_subnet.personalerp-db-subnet02.id}",
    "${aws_subnet.personalerp-db-subnet03.id}"
  ]

  tags = {
    Name = "DB Subnet Group"
    Env = var.personalerp_env
  }
}

resource "aws_db_instance" "personalerp-security-db" {
  identifier           = "personalerp-security-${var.personalerp_env}"
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "postgres"
  engine_version       = "11.6"
  instance_class       = "db.t2.micro"
  name                 = "personalerp_security_db_${var.personalerp_env}"
  username             = "personalerp"
  password             = random_password.password.result
  db_subnet_group_name = aws_db_subnet_group.personalerp-security-db-network.name

  tags = {
    Name = "DB Security"
    Env = var.personalerp_env
  }
}
