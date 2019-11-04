output "public_subnet_ids" {
  value       = module.wc_network.public_subnet_ids
  description = "Ids of the 'public' subents"
}

output "private_subnet_ids" {
  value       = module.wc_network.private_subnet_ids
  description = "Ids of the 'private' subents"
}

output "public_instances" {
  value = aws_instance.public[*]
}

output "private_instances" {
  value = aws_instance.private[*]
}