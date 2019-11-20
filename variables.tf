variable "vpc_cidr_block" {
  type        = string
  description = "CIDR block to assign to the VPC"
}

variable "name_prefix" {
  type    = string
  default = ""
}

variable "common_tags" {
  type = map
  default = {
    project = ""
    owner   = ""
  }
  description = "Default tags which will be applied to all the created resources. The current default keys must be allways present!"
}

variable "public_subnet_cidrs" {
  type        = list
  description = "List containing the public subents CIDRs. Must contain atleast one."
}

variable "private_subnet_cidrs" {
  type        = list
  default     = []
  description = "List containing the private subents CIDRs. If the list is empty no nat gateway will be created."
}
