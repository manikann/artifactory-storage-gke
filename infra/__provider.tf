provider "google" {
  region  = "${var.region}"
  version = "~> 1.20"
}

provider "google-beta" {
  region  = "${var.region}"
  version = "~> 1.20"
}

terraform {
  required_version = "~> 0.11.13"
}
