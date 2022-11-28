variable "kubeslave02-ec2" {
    type = string
  
}

variable "kubeslave02-owner" {
    type = string
  
}

variable "Purpose" {
    type = string
  
}

variable "Environment" {
    type = string
  
}

variable "Client" {
    type = string
  
}


resource "aws_instance" "kubeslav02" {
    ami = "ami-097a2df4ac947655f"
    instance_type = "t2.micro"

    tags = {
        Name = var.kubeslave02-ec2
        Owner = var.kubeslave02-owner
        Purpose = var.Purpose 
        Environment = var.Environment
        Client = var.Client
    }
  
}

output "kubeslave02-instanceid" {
    value = aws_instance.kubeslav02.id
  
}
output "kubeslave02-privateip" {
    value = aws_instance.kubeslav02.private_ip
}