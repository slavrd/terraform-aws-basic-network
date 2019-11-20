variable "vpc_cidr_block" {
  type        = string
  description = "CIDR block to assign to the VPC"
}

variable "name_prefix" {
  type = string

}

variable "common_tags" {
  type        = map
  description = "Default tags which will be applied to all the created resources. The current default keys must be allways present!"
}

variable "public_subnet_cidrs" {
  type        = list
  description = "CIDR blocks list to create public subnets"
}

variable "private_subnet_cidrs" {
  type        = list
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
