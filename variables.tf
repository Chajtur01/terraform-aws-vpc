variable "instance_name" {
  description = "Value of the Name tag for the EC2 instance"
  type        = string
  default     = "terraform-aws"
}

variable "instance_type" {
  description = "Value of the Instance Type for the EC2 instance"
  type        = string
  default     = "t2.micro"
}

variable "region" {
  description = "Value of the Region tag for the EC2 instance"
  type        = string
  default     = "us-east-1"
}

variable "ami_id" {
  description = "Value of the Region tag for the EC2 instance"
  type        = string
  default     = "ami-05548f9cecf47b442"
}