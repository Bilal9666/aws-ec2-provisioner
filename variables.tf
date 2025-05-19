variable "aws_region" {
  description = "The aws region to deploy to"
  type        = string
  default     = "us-east-1"
}

variable "ami_id" {
  description = "Ubuntu Ami id"
  type        = string
  default     = "ami-084568db4383264d4"
}

variable "instance_type" {
  description = "Instance type"
  type        = string
  default     = "t2.micro"
}