terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.9.0"
    }
  }
}

provider "aws" {
  region = var.region
}

resource "aws_vpc" "vpc_terraform_test" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Environment = "Development"
    Terraform   = "True"
    Project     = "Learning Terraform Basics"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.vpc_terraform_test.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Environment = "Development"
    Terraform   = "True"
    Project     = "Learning Terraform Basics"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.vpc_terraform_test.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Environment = "Development"
    Terraform   = "True"
    Project     = "Learning Terraform Basics"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc_terraform_test.id

  tags = {
    Environment = "Development"
    Terraform   = "True"
    Project     = "Learning Terraform Basics"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc_terraform_test.id

  tags = {
    Environment = "Development"
    Terraform   = "True"
    Project     = "Learning Terraform Basics"
  }
}

resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "public_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_instance" "app_server" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = aws_subnet.public_subnet.id

  tags = {
    Name        = var.instance_name
    Environment = "Development"
    Terraform   = "True"
    Project     = "Learning Terraform Basics"
  }
}