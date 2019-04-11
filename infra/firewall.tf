resource "google_compute_firewall" "cloudbuild-inbound" {
  provider = "google-beta"

  name    = "${var.project_id}-cloudbuild-inbound"
  project = "${var.project_id}"
  network = "default"

  direction = "INGRESS"

  allow {
    protocol = "tcp"
    ports    = ["8081", "30671", "30672", "30673", "30674"]
  }

  enable_logging = true

  source_ranges = [
    "35.0.0.0/8",
    "34.0.0.0/8",
    "156.13.71.0/24",
    "156.13.70.0/24"
  ]

  target_tags = ["artifactory-nodes"]
}
