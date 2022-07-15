resource "oci_core_network_security_group" "ping" {
  compartment_id = var.compartment_id
  vcn_id         = var.vcn_id
  display_name   = "${var.name}-ping-security-group-${random_string.deployment_id.result}"
}

resource "oci_core_network_security_group_security_rule" "ping" {
  network_security_group_id = oci_core_network_security_group.ping.id

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

resource "oci_core_network_security_group" "http" {
  compartment_id = var.compartment_id
  vcn_id         = var.vcn_id
  display_name   = "${var.name}-http-security-group-${random_string.deployment_id.result}"
}

resource "oci_core_network_security_group_security_rule" "http" {
  network_security_group_id = oci_core_network_security_group.http.id

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

resource "oci_core_network_security_group" "https" {
  compartment_id = var.compartment_id
  vcn_id         = var.vcn_id
  display_name   = "${var.name}-https-security-group-${random_string.deployment_id.result}"
}

resource "oci_core_network_security_group_security_rule" "https" {
  network_security_group_id = oci_core_network_security_group.https.id

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

resource "oci_core_network_security_group" "kubernetes" {
  compartment_id = var.compartment_id
  vcn_id         = var.vcn_id
  display_name   = "${var.name}-kube-security-group-${random_string.deployment_id.result}"
}

resource "oci_core_network_security_group_security_rule" "kube_api" {
  network_security_group_id = oci_core_network_security_group.kubernetes.id

  description = "KUBE_API"
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

resource "oci_core_network_security_group_security_rule" "this_etcd" {
  network_security_group_id = oci_core_network_security_group.kubernetes.id

  description = "ETCD"
  direction   = "INGRESS"
  protocol    = 6
  source_type = "CIDR_BLOCK"
  source      = "0.0.0.0/0"

  tcp_options {
    destination_port_range {
      min = 2379
      max = 2380
    }
  }
}
