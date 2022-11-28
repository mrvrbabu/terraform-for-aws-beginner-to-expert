provider "aws" {
  region = "us-east-2"

}
variable "ingressports" {
  value = list(number)
  description = "value"
  default = [80,3306,8080]
  
}
resource "aws_instance" "myec2" {
  ami             = "ami-097a2df4ac947655f"
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.mysg.name]

}

resource "aws_eip" "myeip" {
  instance = aws_instance.myec2.id

}

output "EIP" {
  value = aws_eip.myeip.public_ip
}

resource "aws_security_group" "mysg" {
  name = "Allow HTTPS"
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]

  }

  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

}