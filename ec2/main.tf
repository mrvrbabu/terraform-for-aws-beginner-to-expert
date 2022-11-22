provider "aws" {
  region = "us-east-2"

}

resource "aws_instance" "myec2" {
  ami           = "ami-097a2df4ac947655f"
  instance_type = "t2.micro"

}

resource "aws_eip" "myeip" {
  instance = aws_instance.myec2.id

}

output "EIP" {
  value = aws_eip.myeip.public_ip
}