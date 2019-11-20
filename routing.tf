resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
  tags   = var.common_tags
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  tags   = var.common_tags
}

resource "aws_route" "default" {
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
  tags = var.common_tags
}

resource "aws_nat_gateway" "gw" {
  allocation_id = aws_eip.nat_gw.id
  subnet_id     = aws_subnet.public[var.public_subnet_cidrs[0]].id
  depends_on    = [aws_internet_gateway.gw]
  tags          = var.common_tags
}

resource "aws_route" "default_nat_gw" {
  route_table_id         = aws_vpc.main.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.gw.id
}