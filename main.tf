#################### PRODUCER ##############################
resource "google_compute_instance" "vm_instance_producer" {
  name         = "${var.project_name}-prod-vm"
  machine_type = "e2-micro"
  zone         = var.project_zone
  tags         = ["ssh", "http"]

  boot_disk {
    initialize_params {
     image = "debian-cloud/debian-9"
    }
  }

  metadata = {
    ssh-keys = "debian:${tls_private_key.ssh.public_key_openssh}"
  }


  network_interface {
    network    = google_compute_network.vpc.name
    subnetwork = google_compute_subnetwork.network_subnet.name
    access_config {
      nat_ip = google_compute_address.static_ip_producer.address
    }
  }

  # Startup Script
  provisioner "file" {
    source      = "scripts/system_setup.sh"
    destination = "/tmp/system_setup.sh"

    connection {
      host        = google_compute_address.static_ip_producer.address
      type        = "ssh"
      user        = "debian"
      private_key = tls_private_key.ssh.private_key_pem
      agent       = "false"
    }
  }

  provisioner "file" {
    source      = "scripts/prod_config.sh"
    destination = "/tmp/prod_config.sh"

    connection {
      host        = google_compute_address.static_ip_producer.address
      type        = "ssh"
      user        = "debian"
      private_key = tls_private_key.ssh.private_key_pem
      agent       = "false"
    }
  }

  provisioner "remote-exec" {
    inline = [
      "sudo chmod +x /tmp/system_setup.sh",
      "/tmp/system_setup.sh",

      "sudo chmod +x /tmp/prod_config.sh",
      "/tmp/prod_config.sh"

    ]

    connection {
      host        = google_compute_address.static_ip_producer.address
      type        = "ssh"
      user        = "debian"
      private_key = tls_private_key.ssh.private_key_pem
      agent       = "false"
    }
  }

}



#################### CONSUMER ##############################
resource "google_compute_instance" "vm_instance_consumer" {
  name         = "${var.project_name}-cons-vm"
  machine_type = "e2-micro"
  zone         = var.project_zone
  tags         = ["ssh", "http"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
      #image = "ubuntu-os-cloud/ubuntu-1804-lts"
    }
  }

  metadata = {
    ssh-keys = "debian:${tls_private_key.ssh.public_key_openssh}"
  }

  network_interface {
    network    = google_compute_network.vpc.name
    subnetwork = google_compute_subnetwork.network_subnet.name
    access_config {
      nat_ip = google_compute_address.static_ip_consumer.address
    }
  }

  # set system time zone, update packages, install golang
  provisioner "file" {
    source      = "scripts/system_setup.sh"
    destination = "/tmp/system_setup.sh"

    connection {
      host        = google_compute_address.static_ip_consumer.address
      type        = "ssh"
      user        = "debian"
      private_key = tls_private_key.ssh.private_key_pem
      agent       = "false"
    }
  }

  provisioner "file" {
    source      = "scripts/cons_config.sh"
    destination = "/tmp/cons_config.sh"

    connection {
      host        = google_compute_address.static_ip_consumer.address
      type        = "ssh"
      user        = "debian"
      private_key = tls_private_key.ssh.private_key_pem
      agent       = "false"
    }
  }

  provisioner "remote-exec" {
    inline = [
      "sudo chmod +x /tmp/system_setup.sh",
      "/tmp/system_setup.sh",

      "sudo chmod +x /tmp/cons_config.sh",
      "/tmp/cons_config.sh"
    ]

    connection {
      host        = google_compute_address.static_ip_consumer.address
      type        = "ssh"
      user        = "debian"
      private_key = tls_private_key.ssh.private_key_pem
      agent       = "false"
    }
  }
}



#################### VM POLICIES ##############################
resource "google_compute_resource_policy" "vm_snapshots" {
  name   = "vm-snapshot-policy"
  region = var.project_region
  snapshot_schedule_policy {
    schedule {
      daily_schedule {
        days_in_cycle = 1
        start_time    = "023:00"
      }
    }
    retention_policy {
      max_retention_days    = 4
      on_source_disk_delete = "KEEP_AUTO_SNAPSHOTS"
    }
    snapshot_properties {
      labels = {
        my_label = "value"
      }
      storage_locations = ["us"]
      guest_flush       = true
    }
  }
}

resource "google_compute_resource_policy" "hourly" {
  name        = "policy"
  region      = "us-central1"
  description = "Start and stop instances"
  instance_schedule_policy {
    vm_start_schedule {
      schedule = "0 2 * * *"
    }
    vm_stop_schedule {
      schedule = "30 2 * * *"
    }
    time_zone = "US/Pacific"
  }

}