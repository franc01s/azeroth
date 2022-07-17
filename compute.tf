# Ressources for haproxy and eaa

data "exoscale_compute_template" "debian" {
  zone = var.exoscale_zone_default
  name = "Linux Debian 11 (Bullseye) 64-bit"
}
resource "exoscale_compute_instance" "azeroth" {
  zone               = var.exoscale_zone_default
  name               = "azeroth"
  type               = "standard.medium"
  template_id        = data.exoscale_compute_template.debian.id
  disk_size          = 50
  security_group_ids = [
    exoscale_security_group.company-api-sg.id
  ]
  ssh_key            = "francois"
  user_data          = <<EOF
      #cloud-config
      bootcmd:
       - DEBIAN_FRONTEND=noninteractive apt-get -yq update
       - DEBIAN_FRONTEND=noninteractive apt-get -yq install gnupg
      apt:
        sources:
          docker.list:
            source: deb [arch=amd64] https://download.docker.com/linux/debian $RELEASE stable
            keyid: 8D81803C0EBFCD88
      packages:
        - apt-transport-https
        - ca-certificates
        - curl
        - gnupg-agent
        - software-properties-common
        - docker-ce
        - docker-ce-cli
        - containerd.io
        - unzip
        - tmux
      # Enable ipv4 forwarding, required on CIS hardened machines
      write_files:
        - path: /etc/sysctl.d/enabled_ipv4_forwarding.conf
          content: |
            net.ipv4.conf.all.forwarding=1
      runcmd:
          - [ wget, "https://github.com/docker/compose/releases/download/v2.6.1/docker-compose-linux-x86_64", -O, /usr/local/bin/docker-compose ]
          - chmod  +x  /usr/local/bin/docker-compose
          - git clone https://github.com/azerothcore/azerothcore-wotlk.git /home/debian/azerothcore-wotlk
      # create the docker group
      groups:
        - docker
      # Add default auto created user to docker group
      system_info:
        default_user:
          groups: [docker]
      EOF
}


