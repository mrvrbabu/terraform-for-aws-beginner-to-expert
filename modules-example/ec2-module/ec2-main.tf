variable "ec2-name" {
    type = string
  
}

variable "owner" {
    type = string  
}

resource "aws_instance" "myec2" {
  ami           = "ami-097a2df4ac947655f"
  instance_type = "t2.micro"

  tags = {
    Name = var.ec2-name
    Owner = var.owner
  }

}