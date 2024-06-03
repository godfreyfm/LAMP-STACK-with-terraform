# Creation of application server

resource "aws_instance" "App_instance" {
  ami                    = data.aws_ami.latest_ubuntu.id
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.app-subnet.id
  iam_instance_profile   = aws_iam_instance_profile.app_instance_profile.name
  key_name               = "**********************" # USE OWN KEYS
  vpc_security_group_ids = [aws_security_group.app_level_sg.id]

  user_data = base64encode(<<-EOF
              #!/bin/bash
              sudo apt-get update -y
              sudo apt-get install -y apache2
              sudo systemctl start apache2
              sudo systemctl enable apache2
              echo "Hello, World! I am learning Terraform and I love it" | sudo tee /var/www/html/index.html
              EOF
  )
  tags = merge(
    var.global_tags, {
      Name = "App_instance"
    }
  )

}

# Creation of Bastion Server
resource "aws_instance" "bastion_instance" {
  ami                    = data.aws_ami.latest_ubuntu.id
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.bastion-subnet.id
  key_name               = "********************" # USE OWN KEYS
  vpc_security_group_ids = [aws_security_group.bastion_sg.id]
  tags = merge(
    var.global_tags, {
      Name = "bastion_instance"
    }
  )
}