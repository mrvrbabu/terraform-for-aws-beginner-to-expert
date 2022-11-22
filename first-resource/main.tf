provider "aws" {
    region = "us-east-1"
}

resource "aws_vpc" "vpc_brownbench" {
    cidr_block = "10.0.0.0/16"
  
}