variable "aws_region" {
  description = "The AWS region to create things in."
  default     = "us-east-2"
}

variable "key_name" {
  description = " SSH keys to connect to ec2 instance"
  default     = "flugelterrakey"
}

variable "instance_type" {
  description = "instance type for ec2"
  default     = "t2.micro"
}

variable "security_group" {
  description = "Name of security group"
  default     = "flugel-security-group"
}

variable "tag_name" {
  description = "Tag Name of for Ec2 instance"
  default     = "Flugel"
}
variable "ami_id" {
  description = "AMI for Ubuntu Ec2 instance"
  default     = "ami-0b9064170e32bde34"
}

variable "bucket_prefix" {
  type        = string
  description = "(required since we are not using 'bucket') Creates a unique bucket name beginning with the specified prefix"
  default     = "flugel-s3bucket-"
}
variable "tags" {
  type        = map(any)
  description = "(Optional) A mapping of tags to assign to the bucket."
  default = {
    environment = "DEV"
    terraform   = "true"
    Owner       = "TFProviders"
  }
}
variable "versioning" {
  type        = bool
  description = "(Optional) A state of versioning."
  default     = true
}
variable "acl" {
  type        = string
  description = " Defaults to private "
  default     = "private"
}
