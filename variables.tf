#  Provider Data 
variable "region" {
  description = "This is my region"
  type        = string
}

variable "profile" {
  description = "This is my profile"
  type        = string
}

variable "role_arn" {
  description = "This is the arn for my role that will be assumed"
  type        = string
}

# Variables for main VPC resources 

variable "pub-cidr-vpc" {
  description = "this is my public internet address"
  type        = string
}

variable "vpc-cidr" {
  description = "This is my vpc address"
  type        = string
}

variable "pub-subnet-cidrs" {
  description = "This is the cidrs for my subnets"
  type        = list(string)
}

variable "priv-subnet-cidrs" {
  description = "This is the cidrs for my subnets"
  type        = list(string)
}

variable "availability_zones" {
  description = "This is the list of azs i will be using"
  type        = list(string)

}

# Variables for tagging
variable "global_tags" {
  description = "Baseline for tags"
  type        = map(string)
}
