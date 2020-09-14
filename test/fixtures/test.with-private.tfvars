name_prefix = "kitchen-test-terraform-aws-basic-network-with-private-"
common_tags = {
  project = "kitchen-test-terraform-aws-basic-network"
  owner   = "slav"
}
vpc_cidr_block = "172.25.1.0/24"
public_subnet_cidrs = [{
  cidr     = "172.25.1.0/28"
  az_index = 0
  },
  {
    cidr     = "172.25.1.16/28"
    az_index = 1
}]
private_subnet_cidrs = [{
  cidr     = "172.25.1.32/28"
  az_index = 0
  },
  {
    cidr     = "172.25.1.48/28"
    az_index = 1
}]