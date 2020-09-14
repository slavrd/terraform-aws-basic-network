name_prefix = "kitchen-test-terraform-aws-basic-network-no-private-"
common_tags = {
  project = "kitchen-test-terraform-aws-basic-network"
  owner   = "slav"
}
vpc_cidr_block = "172.25.0.0/24"
public_subnet_cidrs = [{
  cidr     = "172.25.0.0/28"
  az_index = 0
}]