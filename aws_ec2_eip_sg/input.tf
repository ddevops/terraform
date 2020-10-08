###
#SG
###
variable "vpc-id" {
  description   = "ID of the VPC where to create security group"
  type          = string
}

variable "sg-name" {
  description = "Name of security group"
  type        = string
}

#####
#EC2
#####
variable "ec2-subnet-id" {
  description = "ID of subnet to be attached with ec2"
  type        = string
}

variable "ami-id" {
  description = "ID of the custom AMI of opensips"
  type        = string
}

variable "key-name" {
  description = "Name of the key to be attached to EC2"
  type        = string
}

variable "key-path" {
  description = "Path of the key to be used for SSH"
  type        = string
}

###
#Common
###
variable "description" {
  description = "Description of security group"
  type        = string
  default     = "Managed by Terraform"
}

variable "tags" {
  description = "Managed by Terraform"
  type        = map(string)
}


