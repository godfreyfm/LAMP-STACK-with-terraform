# Creation of Public Route table and its Association 
resource "aws_route_table" "pub-rt" {
  vpc_id = aws_vpc.main-vpc.id
  route {
    cidr_block = var.pub-cidr-vpc
    gateway_id = aws_internet_gateway.main-igw.id
  }

  tags = merge(
    var.global_tags, {
      "Name" = "pub-rt"
    }
  )
}

resource "aws_route_table_association" "pub-rt-association-app" {
  subnet_id      = aws_subnet.app-subnet.id
  route_table_id = aws_route_table.pub-rt.id
}

resource "aws_route_table_association" "pub-rt-association-bastion" {
  subnet_id      = aws_subnet.bastion-subnet.id
  route_table_id = aws_route_table.pub-rt.id
}
