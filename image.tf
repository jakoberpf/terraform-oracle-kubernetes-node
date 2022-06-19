data "oci_core_images" "this" {
  compartment_id           = var.compartment_id
  operating_system         = "Canonical Ubuntu"
  operating_system_version = "20.04"
  shape                    = var.instance_shape
}
