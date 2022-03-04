resource "oci_core_instance" "this" {
  compartment_id      = var.compartment_id
  availability_domain = var.availability_domain
  display_name        = "${var.name}-${var.compartment}-node-${random_string.deployment_id.result}"
  shape               = var.instance_shape

  shape_config {
    memory_in_gbs = var.instance_memory
    ocpus         = var.instance_ocpus
  }

  source_details {
    source_id               = "ocid1.image.oc1.eu-frankfurt-1.aaaaaaaa6ueulrtedgclrxznl5pkzhzseddl7b6iq6jhdl3vjm62zhddpxta"
    source_type             = "image"
    boot_volume_size_in_gbs = 100
  }

  create_vnic_details {
    subnet_id        = var.subnet_id
    assign_public_ip = true
    hostname_label   = "${var.name}-${var.compartment}-node-${random_string.deployment_id.result}"
    nsg_ids = [
      oci_core_network_security_group.this_https.id,
      oci_core_network_security_group.this_kube.id,
      oci_core_network_security_group.this_zerotier.id
    ]
  }

  metadata = {
    ssh_authorized_keys = var.ssh_authorized_keys
    user_data = base64encode(templatefile("${path.module}/templates/node.yaml.tpl",
      {
        zerotier_network_id_internal = var.zerotier_network_id_internal,
        zerotier_network_id_external = var.zerotier_network_id_external,
        zerotier_public_key          = module.zerotier_identity.public_key,
        zerotier_private_key         = module.zerotier_identity.private_key
      }
    ))
  }
}


