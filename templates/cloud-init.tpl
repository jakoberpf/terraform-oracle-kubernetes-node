#cloud-config

runcmd:
  - iptables -I INPUT 2 -p tcp --dport ${ssh_custom_port} -j ACCEPT
  - iptables-save > /etc/iptables/rules.v4
  - sed -i 's/\#\?Port .\+/Port ${ssh_custom_port}/' /etc/ssh/sshd_config
  - service sshd restart