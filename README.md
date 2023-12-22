# Terraform module - AWS basic network

A terraform module that deploys a VPC and two types of subnets.

## Usage

It is the user's responsibility to calculate the CIDRs for the VPC and subnets so that they are sensible.

The subnet types are designated **public** and **private**.

* The **"public"** subnets allow for resources in it to be reachable from the internet.
* The **"private"** subnets do not allow incoming connections from the internet, but still allow outbound connections from the resources in it.

**Notes:**

* The input variables that define the subnets to be created - `public_subnet_cidrs` and `private_subnet_cidrs` are actually maps and not lists of CIDRs as one might expect. The keys of the map define the CIDRs of the subnets while the values define the availability zone in which the subnet will be created. These values are of type `number` and they are used as an index to select an availability zone form the list of zones for the current AWS region.

* To allow connectivity for the **private** subnets an `aws_nat_gateway` is created in the first public subnet in the list. Therefore the **public** subnet list can never  be with `0` elements. If the **private** subnets list is empty the `aws_nat_gateway` and its associated resources will not be crated as well.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| common_tags | A mapping of tags to be applied to the created resources. | `map(string)` | n/a | yes |
| name_prefix | n/a | `string` | `""` | no |
| private_subnet_cidrs | List of objects reprisenting the private subnets CIDRs and their availability zones. The az_index property is used as an index to retireve a zone from the list of the availability zones for the current AWS region. | ```list(object({ cidr = string az_index = number }))``` | `[]` | no |
| private_subnet_tags | A mapping of tags to be applied to the private subnets. | `map(string)` | `{}` | no |
| public_subnet_cidrs | List of objects reprisenting the public subnets CIDRs and their availability zones. The az_index property is used as an index to retireve a zone from the list of the availability zones for the current AWS region. | ```list(object({ cidr = string az_index = number }))``` | n/a | yes |
| public_subnet_tags | A mapping of tags to be applied to the public subnets. | `map(string)` | `{}` | no |
| vpc_cidr_block | CIDR block to assign to the VPC | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| main_route_table_id | The id of the VPC default routing table. It is not used by any subnets. |
| nat_gateway_public_ip | The public IP of the NAT gateway. |
| private_route_table_id | The id of the privagte routing table. Used by the private subnets. |
| private_subnet_ids | Ids of the private subents. |
| private_subnets | A mapping of input private subnet CIDR and created subnet. |
| public_route_table_id | The id of the public subnets route table. |
| public_subnet_ids | Ids of the 'public' subents. |
| public_subnets | A mapping of input public subnet CIDR and created subnet. |
| vpc_id | The id of the VPC which was created. |

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12.26 |
| aws | >= 3.0 |

## Resources

| Name | Type |
|------|------|
| [aws_eip.nat_gw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_internet_gateway.gw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_nat_gateway.gw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway) | resource |
| [aws_route.default_private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.default_public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route_table.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_subnet.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |
| [aws_availability_zones.azs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |

## Documentation

Generated with [terraform-docs](https://terraform-docs.io/user-guide/introduction/).
```bash
terraform-docs markdown table ./terraform -c .terraform-docs.yaml > README.md
```

