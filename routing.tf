locals {
  isNATGW = length(var.private_subnet_cidrs) == 0 ? false : true
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
  tags = merge({
    Name = "${var.name_prefix}inet-gw"
    },
    var.common_tags
  )
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  tags = merge({
    Name = "${var.name_prefix}default-inet-rtb"
    },
    var.common_tags
  )
}

resource "aws_route" "default_public" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gw.id
}

resource "aws_route_table_association" "public" {
  for_each       = aws_subnet.public
  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id
}

resource "aws_eip" "nat_gw" {
  count = local.isNATGW ? 1 : 0
  tags = merge({
    Name = "${var.name_prefix}natgw-ip"
    },
    var.common_tags
  )
}

resource "aws_nat_gateway" "gw" {
  count         = local.isNATGW ? 1 : 0
  allocation_id = aws_eip.nat_gw[0].id
  subnet_id     = aws_subnet.public[keys(aws_subnet.public)[0]].id
  depends_on    = [aws_internet_gateway.gw]
  tags = merge({
    Name = "${var.name_prefix}natgw"
    },
    var.common_tags
  )
}

resource "aws_route_table" "private" {
  count  = local.isNATGW ? 1 : 0
  vpc_id = aws_vpc.main.id
  tags = merge({
    Name = "${var.name_prefix}default-nat-rtb"
    },
    var.common_tags
  )
}

resource "aws_route" "default_private" {
  count                  = local.isNATGW ? 1 : 0
  route_table_id         = aws_route_table.private[0].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.gw[0].id
}

resource "aws_route_table_association" "private" {
  for_each       = local.isNATGW ? aws_subnet.private : {}
  subnet_id      = each.value.id
  route_table_id = aws_route_table.private[0].id
}
