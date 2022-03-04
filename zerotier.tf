module "zerotier_identity" {
  source = "jakoberpf/base-member/zerotier"
  #   version = "0.0.2"

  name           = var.name
  compartment    = var.compartment
  network_id     = var.zerotier_network_id_internal
  ip_assignments = var.zerotier_ip_assignment_internal
}
