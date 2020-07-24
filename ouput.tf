output "public_subnet_ids" {
  value       = values(aws_subnet.public)[*].id
  description = "Ids of the 'public' subents."
}

output "public_subnets" {
  value       = aws_subnet.public
  description = "A mapping of input public subnet CIDR and created subnet."
}

output "private_subnet_ids" {
  value       = values(aws_subnet.private)[*].id
  description = "Ids of the private subents."
}

output "private_subnets" {
  value       = aws_subnet.private
  description = "A mapping of input private subnet CIDR and created subnet."
}

output "vpc_id" {
  value       = aws_vpc.main.id
  description = "The id of the VPC which was created."
}

output "main_route_table_id" {
  value       = aws_vpc.main.main_route_table_id
  description = "The id of the VPC default routing table. Used by the private subnets"
}

output "public_route_table_id" {
  value       = aws_route_table.public.id
  description = "The id of the public subnets route table."
}

output "nat_gateway_public_ip" {
  value       = try(aws_nat_gateway.gw[0].public_ip, "")
  description = "The public IP of the NAT gateway."
}
