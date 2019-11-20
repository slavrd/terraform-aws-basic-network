resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true
  tags                 = var.common_tags
}

resource "aws_subnet" "public" {
  for_each   = toset(var.public_subnet_cidrs)
  cidr_block = each.value
  vpc_id     = aws_vpc.main.id
  tags       = var.common_tags
}

resource "aws_subnet" "private" {
  for_each   = toset(var.private_subnet_cidrs)
  cidr_block = each.value
  vpc_id     = aws_vpc.main.id
  tags       = var.common_tags
}
