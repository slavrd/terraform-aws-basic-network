# Terraform module - AWS basic network

A terraform module that deploys a VPC and two types of subnets. 

Input variables are defined in `variables.tf`.

The CIDRs for the VPC and subents are passed as input list variables and it is the user's responsibility to calculate them so they make sense.

The subnet types are designated **public** and **private**.

* The **"public"** subnets allow for resources in it to be reachable from the internet
* The **private** subnets do not allow incoming connections from the internet, but still allow outbound connections from the resources in it.

**Notes:**

* To allow connectivity for the **private** subnet an `aws_nat_gateway` is created in the first public subnet in the list. Therefore the **public** subnet list can never be with `0` elements. If the **private** subnets list is empty the `aws_nat_gateway` and its associated resources will not be crated as well.

## Testing with Kitchen-Terraform

The wrapper code used to test the module is located in `test/fixtures`. It defines the module and also creates a temporary AWS key pair from the keys located in `test/assets`.

KitchenCI will test two use-cases - calling the module with and without private subnets. The use-cases are represented as different platform in the `.kitchen.yml` file - `aws-basic-network-private-subents` and `aws-basic-network-no-private-subents`.

Currently the test fixture:

*  will create the networking infrastructure
*  will create an ubuntu xenial VM in each subnet with assigned public IP address
*  will test that the VMs in the **public** subnet are reachable and the ones in the **private** subnets are not.

Input variables for the test are defined `test/fixtures/test.*.tfvars` files and can be changed as needed.
