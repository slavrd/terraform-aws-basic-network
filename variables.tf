variable "vpc_cidr_block" {
  type        = string
  description = "CIDR block to assign to the VPC"
}

variable "name_prefix" {
  type    = string
  default = ""
}

variable "common_tags" {
  type        = map(string)
  description = "A mapping of tags to be applied to the created resources."
}

variable "public_subnet_cidrs" {
  type        = map(number)
  description = "Map containing the public subnets CIDRs as keys and number as value. The number is used to determine the AWS vailability zone in which the subnet will be created. It is used as an list index to select an AZ in the current AWS region. The map must contain atleast one kew value pair."
}

variable "private_subnet_cidrs" {
  type        = map(number)
  default     = {}
  description = "Map containing the private subnets CIDRs as keys and number as value. It is used as an list index to select an AZ in the current AWS region. The number is used to determine the AWS vailability zone in which the subnet will be created."
}
