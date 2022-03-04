output "public_ip" {
  value = oci_core_instance.this.public_ip
}

output "zt_internal_ip" {
  value = var.zerotier_ip_assignment_internal
}

output "zt_external_ip" {
  value = var.zerotier_ip_assignment_external
}
