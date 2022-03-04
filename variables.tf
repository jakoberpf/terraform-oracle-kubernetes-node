# Global
variable "name" {
  type    = string
  default = "oracle"
}

variable "compartment" {
  type    = string
  default = "default"
}

# Oracle
variable "instance_shape" {
  type    = string
  default = "VM.Standard.A1.Flex"
}

variable "instance_memory" {
  type    = number
  default = 24
}

variable "instance_ocpus" {
  type    = string
  default = 4
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

# Zerotier
variable "zerotier_network_id_internal" {
  type = string
}

variable "zerotier_network_id_external" {
  type = string
}

variable "zerotier_ip_assignment_internal" {
  type = list(string)
}

variable "zerotier_ip_assignment_external" {
  type = list(string)
}
