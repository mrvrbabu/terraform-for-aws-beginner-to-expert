variable "regions" {
  type    = list(string)
  default = ["us-east-2", "us-east-3"]

}

provider "aws" {
  dynamic "region" {
    iterator = regions
    for_each = var.regions
    content {
      region = regions.value
    }

  }
}

variable "ingressrules" {
  type    = list(number)
  default = [80, 443]

}

variable "egressrules" {
  type    = list(number)
  default = [80, 443, 53, 8080, 22, 32751, 3306]

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
  dynamic "ingress" {
    iterator = port
    for_each = var.ingressrules
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "TCP"
      cidr_blocks = ["0.0.0.0/0"]

    }
  }
  dynamic "egress" {
    iterator = port
    for_each = var.egressrules
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
    }

  }
}
