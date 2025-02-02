resource "google_compute_instance" "myins" {
  count        = 3
  name         = "cluster-${count.index}"
  machine_type = count.index == 0 ? "e2-standard-4" : "e2-medium"
  zone         = "us-central1-a"

  network_interface {
    network = "default" # Use the default network
    access_config {
      # No static IP configuration
    }
  }

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-lts"
      size  = 10
    }
  }

  metadata = {
    ssh-keys = "paraswork810:${file("./ansi/id_rsa.pub")}"
  }
}

resource "google_compute_firewall" "allow_ingress" {
  name    = "allow-ingress-all-traffic"
  network = "default" # Use the default network

  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }
  allow {
    protocol = "udp"
    ports    = ["0-65535"]
  }
  allow {
    protocol = "icmp"
  }
  allow {
    protocol = "tcp"
    ports    = ["80", "443"] # Allow HTTP and HTTPS
  }

  source_ranges = ["0.0.0.0/0"]
  direction     = "INGRESS"
}

resource "google_compute_firewall" "allow_egress" {
  name    = "allow-egress-all-traffic"
  network = "default" # Use the default network

  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }
  allow {
    protocol = "udp"
    ports    = ["0-65535"]
  }
  allow {
    protocol = "icmp"
  }

  destination_ranges = ["0.0.0.0/0"]
  direction          = "EGRESS"
}



