provider "aws" {
  region = "us-east-2"

}

variable "ingress" {
  type    = list(number)
  default = [80, 443]

}

variable "egress" {
  type    = list(number)
  default = [80, 443]

}

resource "aws_instance" "myec2" {
  ami             = "ami-097a2df4ac947655f"
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.web_traffic.name]
  user_data       = <<-EOF
            #!/bin/bash
            sudo yum update
            sudo apt-get install -y httpd
            sudo systemctl start httpd
            sudo systemctl enable httpd
            echo "<h1>Hello from Terraform</h1>" | sudo tee /var/www/html/index.html
            EOF 


  # OR pass via the script 
  /*
user_data = file("server-script.sh")

*/

  tags = {
    Name = "Web Server"
  }
}


resource "aws_eip" "myeip" {
  instance = aws_instance.myec2.id

}

output "EIP" {
  value = aws_eip.myeip.public_ip
}

resource "aws_instance" "dbserver" {
  ami           = "ami-097a2df4ac947655f"
  instance_type = "t2.micro"

}

output "dbprivateip" {
  value = aws_instance.dbserver.private_ip
}
/*
resource "aws_security_group" "allow_80" {
  name = "Allow HTTP"
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "http"
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
  }

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "http"
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
  }
}

resource "aws_security_group" "allow_443" {
  name = "Allow HTTPS"
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "https"
    from_port   = 443
    to_port     = 443
    protocol    = "TCP"
  }

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "https"
    from_port   = 443
    to_port     = 443
    protocol    = "TCP"
  }
}

*/

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