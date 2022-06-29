resource "oci_core_instance" "this" {
  compartment_id      = var.compartment_id
  availability_domain = var.availability_domain
  display_name        = "${var.name}-${var.compartment}-${random_string.deployment_id.result}"
  shape               = var.instance_shape

  # shape_config {
  #   memory_in_gbs = var.instance_memory
  #   ocpus         = var.instance_ocpus
  # }

  source_details {
    source_id               = var.instance_image != "default" ? var.instance_image : data.oci_core_images.this.images.0.id
    source_type             = "image"
    boot_volume_size_in_gbs = 50
  }

  create_vnic_details {
    subnet_id              = var.subnet_id
    assign_public_ip       = true
    hostname_label         = "${var.name}-${var.compartment}-${random_string.deployment_id.result}"
    skip_source_dest_check = true
    nsg_ids = [
      oci_core_network_security_group.this_ping.id,
      oci_core_network_security_group.ssh.id,
      oci_core_network_security_group.this_http.id,
      oci_core_network_security_group.this_https.id,
      oci_core_network_security_group.this_kube.id,
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
}

resource "null_resource" "ansible" {
  provisioner "remote-exec" {
    inline = ["sudo apt-get -y install curl nano"]

    connection {
      host        = oci_core_instance.this.public_ip
      port        = var.ssh_custom_port
      user        = "ubuntu"
      private_key = file("${path.module}/../../../../.ssh/automation")
    }
  }

  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i '${oci_core_instance.this.public_ip},' --user ubuntu --private-key ../.ssh/automation -T 300 ${path.module}/ansible/playbook.yml"
  }

  triggers = {
    always_run = timestamp()
  }
}
