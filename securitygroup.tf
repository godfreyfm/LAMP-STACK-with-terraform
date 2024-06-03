# Creation of Security group that allows traffic to the application
resource "aws_security_group" "app_level_sg" {
  name        = "ssh_security_group"
  description = "Security group for SSH and Apache access"
  vpc_id      = aws_vpc.main-vpc.id

  ingress {
    description = "SSH from bastion server"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.pub-subnet-cidrs[1]] # Allows traffic from bastion Cidr
  }

  ingress {
    description = "HTTP from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS from anywhere"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.pub-cidr-vpc]
  }

  tags = merge(
    var.global_tags, {
      Name = "app_level_sg"
    }
  )
}

# Security group for db instance

resource "aws_security_group" "db_instance" {
  name        = "mysql_security_group"
  description = "Security group for MySQL database"
  vpc_id      = aws_vpc.main-vpc.id

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.app_level_sg.id]
    description     = "Allow MySQL traffic from app_level_sg"
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.pub-cidr-vpc]
    description = "Allow all outbound traffic"
  }

  tags = merge(
    var.global_tags, {
      Name = "db_instance_sg"
    }
  )
}

# Security group for the bastion server

resource "aws_security_group" "bastion_sg" {
  name        = "ssh from my IP"
  description = "Security group for bastion server"
  vpc_id      = aws_vpc.main-vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.pub-cidr-vpc] # Or from my specific IP

    description = "Allow ssh traffic from the internet"
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.pub-cidr-vpc]
    description = "Allow all outbound traffic"
  }
}
