variable "size" {
  description = "The number of instances to build."
  default     = 1
}

variable "ami-id" {
  description = "ID of the AWS image to use."
  default     = "ami-2e1ef954"
}
