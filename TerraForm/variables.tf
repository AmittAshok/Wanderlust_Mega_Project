variable "aws_region" {
  description = "This is default region for ec2 instance "
  default     = "ap-south-1"
}

variable "ami-id" {
  description = "This is value for Ami of ec2 instance"
  default     = "ami-00bb6a80f01f03502"
}
variable "instance-type" {
  description = "This is instance type for instance"
  default     = "t2.xlarge"
}

variable "private_key-path" {
  description = "This is location of private key of system"
  default     = "/home/amitt-ashok/Work/ssh-key/my-ssh-key"

}