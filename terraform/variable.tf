variable "image_id" {
 type        = string
 default     = "ami-08c5aff04f6b3246b"
}

variable "key_name" {
 type        = string
 default     = "ansible-key-instance"
}

variable "instance_type" {
 type        = string
 default     = "t2.micro"
}

variable "subnet_id" {
 type        = string
 default     = "subnet-0a2f2bb57fd706c3b"
}