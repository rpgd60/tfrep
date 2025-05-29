terraform {
  required_version = "~> 1.11.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>5.0"
    }
  }
}

provider "aws" {
  profile = "sso-student"
  region  = "eu-south-2"
}

## Here we declare some variables that are used later when creating resources
## We give the variable a default value - later in the course we see other ways to populate variables.
variable "my_ubuntu_ami" {
  description = "Ubuntu 24.04 AMI in eu-south-2"
  type        = string
  default     = "ami-099d45c12f4cc3edc"
}
variable "instance_type" {
  description = "instance type"
  type        = string
  default     = "t2.micro"
  # Validation of the instance type - must be t3.micro or t2.micro
  validation {
    condition     = var.instance_type == "t3.micro" || var.instance_type == "t2.micro"
    error_message = "The instance type must be t3.micro or t2.micro"
  }
}

## Since we do not specify subnet AWS 
## will select a public subnet in the default VPC
resource "aws_instance" "server" {
  ami                         = var.my_ubuntu_ami
  instance_type               = var.instance_type
  tags = {
    Name = "web-server"
  }
}
