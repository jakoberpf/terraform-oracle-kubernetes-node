resource "oci_core_instance" "this" {
  compartment_id      = var.compartment_id
  availability_domain = var.availability_domain
  display_name        = "${var.name}-${var.compartment}-${random_string.deployment_id.result}"
  shape               = var.instance_shape

  shape_config {
    memory_in_gbs = var.instance_memory
    ocpus         = var.instance_ocpus
  }

  source_details {
    source_id               = var.instance_image != "default" ? var.instance_image : data.oci_core_images.this.images.0.id
    source_type             = "image"
    boot_volume_size_in_gbs = 150
  }

  create_vnic_details {
    subnet_id              = var.subnet_id
    assign_public_ip       = true
    hostname_label         = "${var.name}-${var.compartment}-${random_string.deployment_id.result}"
    skip_source_dest_check = true
    nsg_ids = [
      oci_core_network_security_group.ping.id,
      oci_core_network_security_group.ssh.id,
      oci_core_network_security_group.http.id,
      oci_core_network_security_group.https.id,
      oci_core_network_security_group.kubernetes.id
    ]
  }

  metadata = {
    ssh_authorized_keys = var.ssh_authorized_keys
    user_data = base64encode(templatefile("${path.module}/templates/cloud-init.tpl",
      {
        ssh_authorized_keys = var.ssh_authorized_keys
        ssh_custom_port     = var.ssh_custom_port
      }
    ))
  }

  lifecycle {
    ignore_changes = [
      source_details
    ]
  }
}
