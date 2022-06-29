variable "name" {
  type    = string
  default = "kubernetes"
}

variable "compartment" {
  type    = string
  default = "default"
}

variable "instance_shape" {
  type    = string
  default = "VM.Standard.E2.1.Micro"
}

variable "instance_memory" {
  type    = number
  default = 1
}

variable "instance_ocpus" {
  type    = string
  default = 1
}

variable "instance_image" {
  type    = string
  default = "default"
}

variable "vcn_id" {
  type = string
}

variable "compartment_id" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "availability_domain" {
  type = string
}

variable "ssh_authorized_keys" {
  type = string
}

variable "ssh_custom_port" {
  type = number
  default = 2222
}
