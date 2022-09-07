variable "size" {
  description = "The number of instances to build."
  default     = 1
}

variable "ami_id" {
  description = "ID of the AWS image to use."
  default     = "ami-0da7236b7a69cf265"
}
