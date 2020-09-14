resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true
  tags = merge({
    Name = "${var.name_prefix}vpc"
    },
    var.common_tags
  )
}

resource "aws_subnet" "public" {
  for_each          = { for s in var.public_subnet_cidrs : s.cidr => s.az_index }
  cidr_block        = each.key
  vpc_id            = aws_vpc.main.id
  availability_zone = element(data.aws_availability_zones.azs.names, each.value)
  tags = merge({
    Name = "${var.name_prefix}public"
    },
    var.common_tags
  )
}

resource "aws_subnet" "private" {
  for_each          = { for s in var.private_subnet_cidrs : s.cidr => s.az_index }
  cidr_block        = each.key
  vpc_id            = aws_vpc.main.id
  availability_zone = element(data.aws_availability_zones.azs.names, each.value)
  tags = merge({
    Name = "${var.name_prefix}private"
    },
    var.common_tags
  )
}
