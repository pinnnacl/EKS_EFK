variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "subnet_id" {
  description = "ID of the public subnet for the bastion host"
  type        = string
}

variable "security_group_id" {
  description = "ID of the security group for the bastion host"
  type        = string
}
