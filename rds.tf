resource "aws_db_instance" "votingAppDb" {
  allocated_storage = 20
  engine            = "mysql"
  engine_version    = "8.0"
  instance_class    = "db.t3.micro"
  # username             = var.db_user_name
  # password             = var.db_password
  username               = jsondecode(data.aws_secretsmanager_secret_version.db_credentials_version.secret_string)["username"]
  password               = jsondecode(data.aws_secretsmanager_secret_version.db_credentials_version.secret_string)["password"]
  parameter_group_name   = "default.mysql8.0"
  skip_final_snapshot    = true
  publicly_accessible    = false
  vpc_security_group_ids = [aws_security_group.db_instance.id]
  db_subnet_group_name   = aws_db_subnet_group.main.name

  tags = {
    Name = "votingApplicationDatabase"
  }
}

resource "aws_db_subnet_group" "main" {
  name       = "voting-application-db-subnet-group"
  subnet_ids = tolist(aws_subnet.db-subnets[*].id)

  tags = {
    Name = "MyVotingAppSubnetGroup"
  }
}
