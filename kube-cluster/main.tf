provider "aws" {
  region = "us-east-2"

}

module "kubemaster" {
  source           = "./kubemaster-module"
  kubemaster-ec2   = "Control-plane"
  kubemaster-owner = "DevOps"
  purpose          = "Testing"
  environment      = "Production"
  client           = "BrownBench"
}

module "kubeslave01" {
  source            = "./kubeslave01-module"
  kubeslave01-ec2   = "Kubeslave01"
  kubeslave01-owner = "DevOps"
  Purpose           = "Testing"
  Environment       = "Production"
  Client            = "BrownBench"

}

module "kubeslave02" {
  source            = "./kubeslave02-module"
  kubeslave02-ec2   = "Kubeslave02"
  kubeslave02-owner = "DevOps"
  Purpose           = "Testing"
  Environment       = "Production"
  Client            = "BrownBench"

}


output "kubemaster-instanceid" {
  value = module.kubemaster.kubemaster-instanceid

}
output "kubemaster-privateip" {
  value = module.kubemaster.kubemaster-privateip
}

output "kubeslave01-instanceid" {
  value = module.kubeslave01.kubeslave01-instanceid

}
output "kubeslave01-privateip" {
  value = module.kubeslave01.kubeslave01-privateip
}


output "kubeslave02-instanceid" {
    value = module.kubeslave02.kubeslave02-instanceid
  
}

output "kubeslave02-privateip" {
    value = module.kubeslave02.kubeslave02-privateip
}