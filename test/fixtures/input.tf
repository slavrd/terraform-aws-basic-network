variable "vpc_cidr_block" {
  type        = string
  default     = "172.31.0.0/20"
  description = "CIDR block to assign to the VPC"
}

variable "common_tags" {
  type = map
  default = {
    project = "kitchen-test-terraform-aws-basic-network"
    owner   = "slav"
    Name    = "slav-kitchen-test-terraform-aws-basic-network"
  }
  description = "Default tags which will be applied to all the created resources. The current default keys must be allways present!"
}

variable "public_subnet_cidrs" {
  type = list
  default = [
    "172.31.0.0/24",
    "172.31.1.0/24",
  ]
  description = "CIDR blocks list to create public subnets"
}

variable "private_subnet_cidrs" {
  type = list
  default = [
    "172.31.4.0/24",
    "172.31.5.0/24",
  ]
  description = "CIDR blocks list to create private subnets"
}

variable "ssh_pub_key_path" {
  type        = string
  description = "Realtive path to the public key to use for creating the test AWS key pair."
  default     = "../assets/kitchen-wc-net-test.pub"
}

variable "ssh_private_key_path" {
  type        = string
  description = "Realtive path to the private key of the test AWS key pair."
  default     = "../assets/kitchen-wc-net-test"
}
