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

resource "oci_core_network_security_group" "this_etcd" {
  compartment_id = var.compartment_id
  vcn_id         = var.vcn_id
  display_name   = "${var.name}-etcd-security-group-${random_string.deployment_id.result}"
}

resource "oci_core_network_security_group_security_rule" "this_etcd" {
  network_security_group_id = oci_core_network_security_group.this_etcd.id

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

resource "oci_core_network_security_group" "this_zerotier" {
  compartment_id = var.compartment_id
  vcn_id         = var.vcn_id
  display_name   = "${var.name}-kube-security-group-${random_string.deployment_id.result}"
}

resource "oci_core_network_security_group_security_rule" "this_zerotier" {
  network_security_group_id = oci_core_network_security_group.this_zerotier.id

  description = "ZEROTIER"
  direction   = "INGRESS"
  protocol    = 6
  source_type = "CIDR_BLOCK"
  source      = "0.0.0.0/0"

  tcp_options {
    destination_port_range {
      min = 9993
      max = 9993
    }
  }
}
