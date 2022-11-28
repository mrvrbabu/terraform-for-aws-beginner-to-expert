provider "aws" {
  region = "us-east-2"

}

module "dbs_module" {
  source = "./dbserver-module"
  ec2-name = "Dbserver"
  Owner = "DBteam"

}

output "dbserver_privateip" {
  value = module.dbs_module.db_privateip

}

module "ec2-module" {
  source  = "./webserver-module"
  ec2name = "Webserver"
  owner   = "DevOps"

}

output "webserver_eip" {
  value = module.ec2-module.webserver-eip

}