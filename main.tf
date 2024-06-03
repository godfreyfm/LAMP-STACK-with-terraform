#  Creating the VPC

resource "aws_vpc" "main-vpc" {
  cidr_block = var.vpc-cidr

  tags = merge(
    var.global_tags, {
      Name = "main-vpc"
    }
  )
}

# Creation of subnets
# app Subnets
resource "aws_subnet" "app-subnet" {
  vpc_id                  = aws_vpc.main-vpc.id
  cidr_block              = var.pub-subnet-cidrs[0]
  availability_zone       = var.availability_zones[0]
  map_public_ip_on_launch = true
  tags = merge(
    var.global_tags, {
      Name        = "app-subnet"
      subnet_type = "public"
    }
  )
}


# bastion Subnets
resource "aws_subnet" "bastion-subnet" {
  vpc_id                  = aws_vpc.main-vpc.id
  cidr_block              = var.pub-subnet-cidrs[1]
  availability_zone       = var.availability_zones[1]
  map_public_ip_on_launch = true
  tags = merge(
    var.global_tags, {
      Name        = "bastion-subnet"
      subnet_type = "public"
    }
  )
}
# db Subnets
resource "aws_subnet" "db-subnets" {
  count             = length(var.priv-subnet-cidrs)
  vpc_id            = aws_vpc.main-vpc.id
  cidr_block        = element(var.priv-subnet-cidrs, count.index)
  availability_zone = element(var.availability_zones, count.index)
  tags = merge(
    var.global_tags, {
      Name        = "priv-subnet-${count.index}"
      subnet_type = "private"
    }
  )
}
# Creation of Internet gateway
resource "aws_internet_gateway" "main-igw" {
  vpc_id = aws_vpc.main-vpc.id

  tags = merge(
    var.global_tags, {
      Name = "main-igw"
    }
  )
}