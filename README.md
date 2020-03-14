# Terraform module - AWS basic network

A terraform module that deploys a VPC and two types of subnets. 

## Input

Input variables are defined in `variables.tf`.

It is the user's responsibility to calculate the CIDRs for the VPC and subnets so that they are sensible.

The input variables that define the subnets to be created `public_subnet_cidrs` and `private_subnet_cidrs` are actually maps and not lists of CIDRs as one might expect. The keys of the map define the CIDRs of the subnets while the values define the availability zone in which the subnet will be created. These values are of type `number` and they are used as an index to select an availability zone form the list of zones for the current AWS region. 

The subnet types are designated **public** and **private**.

* The **"public"** subnets allow for resources in it to be reachable from the internet
* The **"private"** subnets do not allow incoming connections from the internet, but still allow outbound connections from the resources in it.

**Notes:**

* To allow connectivity for the **private** subnet an `aws_nat_gateway` is created in the first public subnet in the list. Therefore the **public** subnet list can never be with `0` elements. If the **private** subnets list is empty the `aws_nat_gateway` and its associated resources will not be crated as well.

## Testing with Kitchen-Terraform

The module includes inspec tests run via KitchenCI.

The wrapper code used to test the module is located in `test/fixtures`. It defines the module and also creates a temporary AWS key pair from the keys located in `test/assets`.

KitchenCI will test two use-cases - calling the module with and without private subnets. The use-cases are represented as different platform in the `.kitchen.yml` file - `aws-basic-network-private-subents` and `aws-basic-network-no-private-subents`.

Currently the test fixture:

*  will create the networking infrastructure
*  will create an ubuntu xenial VM in each subnet with assigned public IP address
*  will test that the VMs in the **public** subnet are reachable and the ones in the **private** subnets are not.

Input variables for the test are defined `test/fixtures/test.*.tfvars` files and can be changed as needed.

### Running the test

1. Set-up AWS credentials using either environment variables or AWS CLI config file (`AWS_REGION` environment variable will still be needed).
2. Run `bundle install` to install required ruby gems. You may want to use `rbenv` or another ruby versions manager.
3. Run `bundle exec kitchen converge [platform-name]` - to build all or a specific environment.
4. Run `bundle exec kitchen verify [platform-name]` - to run the `inspec` tests on all or a specific environment.
5. Run `bundle exec kitchen verify [platform-name]` - to destroy all or a specific environment.
