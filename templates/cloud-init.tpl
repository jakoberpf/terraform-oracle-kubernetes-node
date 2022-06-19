#cloud-config

package_update: true
package_upgrade: true
package_reboot_if_required: true

packages:
  - curl
  - nano

# runcmd:
# %{ for port in iptables_input_accept ~}
#   - iptables -I INPUT 2 -p tcp --dport ${port} -j ACCEPT
# %{ endfor ~}
#   - iptables-save > /etc/iptables/rules.v4
