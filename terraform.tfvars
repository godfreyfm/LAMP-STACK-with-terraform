# Provider Data
region   = "us-east-1"
profile  = "***********************"
role_arn = "***********************************"

# Variables for main VPC resources

pub-cidr-vpc       = "0.0.0.0/0"
vpc-cidr           = "10.0.0.0/16"
pub-subnet-cidrs   = ["10.0.0.0/24", "10.0.1.0/24"]
priv-subnet-cidrs  = ["10.0.2.0/24", "10.0.3.0/24"]
availability_zones = ["us-east-1a", "us-east-1b"] # Change if you are using different zones


global_tags = {
  "Name"        = ""
  "Department"  = "DevOps"
  "Environment" = "Dev"
  "Cost-Center" = "DevOpS-01234"
  "Portfolio"   = "Digital-Acelerator"
  "Customer"    = "Bank Of Amaerica"
  "Fin Year"    = "2024"
  "CreatedBy"   = "gmai"
  "subnet_type" = ""
}
