common_tags = {
    project = "kitchen-test-terraform-aws-basic-network"
    owner   = "slav"
    Name    = "slav-kitchen-test-terraform-aws-basic-network"
}
vpc_cidr_block = "172.25.1.0/24"
public_subnet_cidrs = [
        "172.25.1.0/28",
        "172.25.1.16/28",
    ]
private_subnet_cidrs = [
        "172.25.1.32/28",
        "172.25.1.48/28",
    ]