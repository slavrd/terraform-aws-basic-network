output "public_subnet_ids" {
  value       = [for cidr, az in var.public_subnet_cidrs : aws_subnet.public[cidr].id]
  description = "Ids of the 'public' subents."
}

output "public_subnets" {
  value       = aws_subnet.public
  description = "A mapping of input public subnet CIDR and created subnet."
}

output "private_subnet_ids" {
  value       = [for cidr, az in var.private_subnet_cidrs : aws_subnet.private[cidr].id]
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