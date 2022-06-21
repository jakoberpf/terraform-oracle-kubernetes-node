resource "oci_core_network_security_group" "this_ping" {
  compartment_id = var.compartment_id
  vcn_id         = var.vcn_id
  display_name   = "${var.name}-ping-security-group-${random_string.deployment_id.result}"
}

resource "oci_core_network_security_group_security_rule" "this_ping" {
  network_security_group_id = oci_core_network_security_group.this_ping.id

  description = "PING"
  direction   = "INGRESS"
  protocol    = 1
  source_type = "CIDR_BLOCK"
  source      = "0.0.0.0/0"
}

resource "oci_core_network_security_group" "ssh" {
  compartment_id = var.compartment_id
  vcn_id         = var.vcn_id
  display_name   = "${var.name}-ssh-security-group-${random_string.deployment_id.result}"
}

resource "oci_core_network_security_group_security_rule" "sshproxy" {
  network_security_group_id = oci_core_network_security_group.ssh.id

  description = "SSHPROXY"
  direction   = "INGRESS"
  protocol    = 6
  source_type = "CIDR_BLOCK"
  source      = "0.0.0.0/0"

  tcp_options {
    destination_port_range {
      min = 22
      max = 22
    }
  }
}

resource "oci_core_network_security_group_security_rule" "ssh" {
  network_security_group_id = oci_core_network_security_group.ssh.id

  description = "SSH"
  direction   = "INGRESS"
  protocol    = 6
  source_type = "CIDR_BLOCK"
  source      = "0.0.0.0/0"

  tcp_options {
    destination_port_range {
      min = 2222
      max = 2222
    }
  }
}

resource "oci_core_network_security_group" "this_http" {
  compartment_id = var.compartment_id
  vcn_id         = var.vcn_id
  display_name   = "${var.name}-http-security-group-${random_string.deployment_id.result}"
}

resource "oci_core_network_security_group_security_rule" "this_http" {
  network_security_group_id = oci_core_network_security_group.this_http.id

  description = "HTTP"
  direction   = "INGRESS"
  protocol    = 6
  source_type = "CIDR_BLOCK"
  source      = "0.0.0.0/0"

  tcp_options {
    destination_port_range {
      min = 80
      max = 80
    }
  }
}

resource "oci_core_network_security_group" "this_https" {
  compartment_id = var.compartment_id
  vcn_id         = var.vcn_id
  display_name   = "${var.name}-https-security-group-${random_string.deployment_id.result}"
}

resource "oci_core_network_security_group_security_rule" "this_https" {
  network_security_group_id = oci_core_network_security_group.this_https.id

  description = "HTTPS"
  direction   = "INGRESS"
  protocol    = 6
  source_type = "CIDR_BLOCK"
  source      = "0.0.0.0/0"

  tcp_options {
    destination_port_range {
      min = 443
      max = 443
    }
  }
}

resource "oci_core_network_security_group" "this_kube" {
  compartment_id = var.compartment_id
  vcn_id         = var.vcn_id
  display_name   = "${var.name}-kube-security-group-${random_string.deployment_id.result}"
}

resource "oci_core_network_security_group_security_rule" "this_kube" {
  network_security_group_id = oci_core_network_security_group.this_kube.id

  description = "KUBE"
  direction   = "INGRESS"
  protocol    = 6
  source_type = "CIDR_BLOCK"
  source      = "0.0.0.0/0"

  tcp_options {
    destination_port_range {
      min = 6443
      max = 6443
    }
  }
}
