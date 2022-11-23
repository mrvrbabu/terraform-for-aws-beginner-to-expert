variable "kubeslave01-ec2" {
    type = string
  
}

variable "kubeslave01-owner" {
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

resource "aws_instance" "kubeslave01" {
    ami = "ami-097a2df4ac947655f"
    instance_type = "t2.micro"

    tags = {
        Name = var.kubeslave01-ec2
        Owner = var.kubeslave01-owner
        Purpose = var.Purpose
        Environment = var.Environment
        Client = var.Client
    }
  
}

output "kubeslave01-instanceid" {
    value = aws_instance.kubeslave01.id
}
output "kubeslave01-privateip" {
    value = aws_instance.kubeslave01.private_ip
}