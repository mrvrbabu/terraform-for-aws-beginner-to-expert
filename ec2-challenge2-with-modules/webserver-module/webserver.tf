variable "ec2name" {
  type = string
}


variable "owner" {
  type = string
  
}


variable "ingress" {
  type    = list(number)
  default = [80, 443]
}

variable "egress" {
  type    = list(number)
  default = [80, 443]

}


resource "aws_instance" "webserver" {
  ami             = "ami-097a2df4ac947655f"
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.web_traffic.name]
  user_data       = file("webserver-module/server-script.sh")
  tags = {
    Name = var.ec2name
    Owner = var.owner
  }
}

resource "aws_eip" "webserver_eip" {
  instance = aws_instance.webserver.id

}

output "webserver-eip" {
  value = aws_eip.webserver_eip.public_ip

}

resource "aws_security_group" "web_traffic" {
  name = "Allow web traffic"
  dynamic "ingress" {
    iterator = port
    for_each = var.ingress
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }


  dynamic "egress" {
    iterator = port
    for_each = var.ingress
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}