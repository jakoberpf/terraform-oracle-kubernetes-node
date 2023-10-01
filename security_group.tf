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

# SSH port

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

# HTTP port

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

# HTTPS port

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

# Kubernetes related ports

resource "oci_core_network_security_group" "kubernetes" {
  compartment_id = var.compartment_id
  vcn_id         = var.vcn_id
  display_name   = "${var.name}-kube-security-group-${random_string.deployment_id.result}"
}

resource "oci_core_network_security_group_security_rule" "kubernetes" {
  network_security_group_id = oci_core_network_security_group.kubernetes.id

  for_each = var.security_group_ports_kubernetes

  description = each.value["description"]
  direction   = "INGRESS"
  protocol    = each.value["protocol"]
  source_type = "CIDR_BLOCK"
  source      = "0.0.0.0/0"

  tcp_options {
    destination_port_range {
      min = each.value["port_min"]
      max = each.value["port_max"]
    }
  }
}

# Application related ports

resource "oci_core_network_security_group_security_rule" "applications" {
  network_security_group_id = oci_core_network_security_group.kubernetes.id

  for_each = var.security_group_ports_kubernetes

  description = each.value["description"]
  direction   = "INGRESS"
  protocol    = each.value["protocol"]
  source_type = "CIDR_BLOCK"
  source      = "0.0.0.0/0"

  tcp_options {
    destination_port_range {
      min = each.value["port_min"]
      max = each.value["port_max"]
    }
  }
}

/* "LOCAL_DNS_CACHE_UPD" = {
  port_max    = 53
  port_min    = 53
  protocol    = 17
  description = "LOCAL_DNS_CACHE_UPD"
} */

resource "oci_core_network_security_group_security_rule" "fix_local_dns_cache" {
  network_security_group_id = oci_core_network_security_group.kubernetes.id

  description = "LOCAL_DNS_CACHE_UPD"
  direction   = "INGRESS"
  protocol    = 17
  source_type = "CIDR_BLOCK"
  source      = "0.0.0.0/0"

  udp_options {
    destination_port_range {
      min = 53
      max = 53
    }
  }
}

/* "CILIUM_VXLAN_OVERLAY" = {
  port_max    = 8472
  port_min    = 8472
  protocol    = 17
  description = "CILIUM_VXLAN_OVERLAY"
} */

resource "oci_core_network_security_group_security_rule" "fix_cilium_vxlan_overlay" {
  network_security_group_id = oci_core_network_security_group.kubernetes.id

  description = "CILIUM_VXLAN_OVERLAY"
  direction   = "INGRESS"
  protocol    = 17
  source_type = "CIDR_BLOCK"
  source      = "0.0.0.0/0"

  udp_options {
    destination_port_range {
      min = 8472
      max = 8472
    }
  }
}
