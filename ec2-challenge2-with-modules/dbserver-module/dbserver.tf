variable "ec2-name" {
  type = string
}

variable "Owner" {
  type = string
}

resource "aws_instance" "dbserver" {
  ami           = "ami-097a2df4ac947655f"
  instance_type = "t2.micro"

  tags = {
    Name = var.ec2-name 
    Owner = var.Owner 
  }

}

output "db_privateip" {
  value = aws_instance.dbserver.private_ip

}