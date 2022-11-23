variable "kubemaster-ec2" {
  type = string

}

variable "kubemaster-owner" {
  type = string

}

variable "purpose" {
    type = string
  
}

variable "environment" {
    type = string
  
}

variable "client" {
    type = string
  
}
resource "aws_instance" "kubemaster" {
  ami           = "ami-097a2df4ac947655f"
  instance_type = "t2.micro"

  tags = {
    Name  = var.kubemaster-ec2
    Owner = var.kubemaster-owner
    Purpose = var.purpose 
    Environment = var.environment 
    Client = var.client
  }

}

output "kubemaster-instanceid" {
    value = aws_instance.kubemaster.id
  
}
output "kubemaster-privateip" {
  value = aws_instance.kubemaster.private_ip

}
