variable "private_subnet_count" {
  type    = number
  default = 6

}

variable "public_subnet_count" {
  type    = number
  default = 3

}

variable "availability_zones" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b", "us-east-1c"]

}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
  default = [
    "10.70.0.0/24",
    "10.70.1.0/24",
    "10.70.2.0/24",
    "10.70.3.0/24",
    "10.70.4.0/24",
    "10.70.5.0/24"
  ]
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
  default = [
    "10.70.100.0/24",
    "10.70.105.0/24",
    "10.70.110.0/24",
    "10.70.115.0/24",
    "10.70.120.0/24",
    "10.70.125.0/24"
  ]
}

variable "ec2_instance_type" {
  type        = string
  default     = "t3.micro"
  description = "Running EC2 instance"

}

variable "aws_region" {
  description = "AWS region where resources will be created"
  type        = string
  default     = "us-east-1"
}
