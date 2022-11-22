provider "aws" {
  region = "us-east-2"

}

module "ec2module" {
  source   = "./ec2-module"
  ec2-name = "Name from module"
  owner = "DevOps"

}

output "module_output" {
  value = module.ec2module.instance_id
}