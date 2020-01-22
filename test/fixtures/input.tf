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
  type        = map(number)
  description = "Map containing the public subnets CIDRs as keys and number as value. The number is used to determine the AWS vailability zone in which the subnet will be created. It is used as an list index to select an AZ in the current AWS region. The map must contain atleast one kew value pair."
}

variable "private_subnet_cidrs" {
  type        = map(number)
  description = "Map containing the private subnets CIDRs as keys and number as value. The number is used to determine the AWS vailability zone in which the subnet will be created. It is used as an list index to select an AZ in the current AWS region."
  default     = {}
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
