provider "aws" {
  region = "us-east-1"
}

variable "vpcname" {
  type    = string
  default = "vpc_brownbench"

}

variable "mylist" {
  type    = list(string)
  default = ["brownbenchvpc", "Testing", "Stage", "DevOps", "Brownbench"]

}

# Input block to accept input from user
/*
variable "myvpcname" {
  type        = string
  description = "Enter the name of the VPC to be created"

}

*/

variable "mymap" {
  type = map(any)
  default = {
    Name        = "brownbenchvpc"
    Environment = "Stage"
    Client      = "Brownbench"
    Owner       = "DevOps"
    Purpose     = "Testing"
  }
}

output "vpcid" {
    value = aws_vpc.brownbenchvpc.id
    description = "This is the vpc id of the newly created vpc"  
}

# Example of tuple 

variable "mytuple" {
    type = tuple([string, number, string])
    default = ["car", 1, "dog"]
}

variable "myobject" {
    type = object({ name = string, port = list(number)})
    default = {
      name = "rbabu"
      port = [22, 80, 443 ]
    }
  
}
/*
resource "aws_vpc"  "brownbenchvpc" {
    cidr_block = "10.0.0.0/16"

    tags = {
        Name = var.vpcname
    }
  
}
*/

# Exmaple use of list (Uncomment below block to test list)

/*
resource "aws_vpc"  "brownbenchvpc" {
    cidr_block = "10.0.0.0/16"

    tags = {
        Name = var.mylist[0]
        Purpose = var.mylist[1]
        Environment = var.mylist[2]
        Owner = var.mylist[3]
        Client = var.mylist[4]

    }
  
}

*/

# Example use of Map (Uncomment below block to test map)

/*

resource "aws_vpc" "vpc_brownbench" {
    cidr_block = "10.0.0.0/16"
    tags = { 
        Name = var.mymap["Name"]
        Purpose = var.mymap["Purpose"]
        Environment = var.mymap["Environment"]
        Owner = var.mymap["Owner"]
        Client = var.mymap["Client"]

    }
  
}

*/


resource "aws_vpc" "brownbenchvpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name        = var.mylist[0]
    Purpose     = var.mylist[1]
    Environment = var.mylist[2]
    Owner       = var.mylist[3]
    Client      = var.mylist[4]

  }

}