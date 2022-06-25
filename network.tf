#################### NETWORK ##############################

# create VPC
resource "google_compute_network" "vpc" {
  name                    = "${var.project_name}-vpc-network"
  auto_create_subnetworks = "false"
  routing_mode            = "GLOBAL"
}


# create public subnet
resource "google_compute_subnetwork" "network_subnet" {
  name          = "${var.project_name}-subnet"
  ip_cidr_range = var.network-subnet-cidr
  network       = google_compute_network.vpc.name
  region        = var.project_region
}


# allow ssh traffic
resource "google_compute_firewall" "allow-ssh" {
  name    = "${var.project_name}-fw-allow-ssh"
  network = google_compute_network.vpc.name
  allow {
    protocol = "tcp"
    ports    = ["${var.ports}"]
  }
  target_tags = ["ssh"]
}


#################### SSH ##############################

# SSH Login
resource "tls_private_key" "ssh" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "private_key" {
  content              = tls_private_key.ssh.private_key_pem
  filename             = ".ssh/private_key.pem"
  file_permission      = "0600"
  directory_permission = "0755"

  #cleanup
  provisioner "local-exec" {
    when    = destroy
    command = "rm -f .ssh/private_key.pem"
  }
}

#################### VM Static IPs ##############################
resource "google_compute_address" "static_ip_producer" {
  name = "ipv4-address-producer"
}

resource "google_compute_address" "static_ip_consumer" {
  name = "ipv4-address-consumer"
}