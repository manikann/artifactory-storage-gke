resource "google_storage_bucket" "artifactory_filestore" {
  project       = "${var.project_id}"
  name          = "${var.project_id}-artifactory-filestore"
  location      = "${var.region}"
  storage_class = "REGIONAL"
  force_destroy = "true"
}

resource "google_storage_bucket_iam_member" "filestore_sa_iam" {
  bucket = "${google_storage_bucket.artifactory_filestore.id}"
  member = "serviceAccount:${google_service_account.artifactory_gcs.email}"
  role   = "roles/storage.objectAdmin"
}

resource "google_storage_bucket" "artifactory_config" {
  project       = "${var.project_id}"
  name          = "${var.project_id}-artifactory-config"
  location      = "${var.region}"
  storage_class = "REGIONAL"
  force_destroy = "true"
}

resource "google_storage_bucket_object" "copy-artifactory-license" {
  bucket = "${google_storage_bucket.artifactory_config.id}"
  name   = "artifactory.lic"
  source = "artifactory.lic"
}

resource "google_storage_bucket_object" "copy-master-key" {
  bucket = "${google_storage_bucket.artifactory_config.id}"
  name   = "master.key"
  source = "master.key"
}

resource "google_storage_bucket_object" "db-password" {
  bucket = "${google_storage_bucket.artifactory_config.id}"
  name   = "db.password"
  source = "db.password"
}

resource "google_storage_bucket_object" "access-password" {
  bucket = "${google_storage_bucket.artifactory_config.id}"
  name   = "access.password"
  source = "access.password"
}

resource "google_storage_bucket_object" "gcs-api-key" {
  bucket = "${google_storage_bucket.artifactory_config.id}"
  name   = "gcs-api.key"
  source = "gcs-api.key"
}

resource "google_storage_bucket_object" "gcs-api-password" {
  bucket = "${google_storage_bucket.artifactory_config.id}"
  name   = "gcs-api.password"
  source = "gcs-api.password"
}

resource "google_storage_bucket" "artifactory_gcsstore" {
  project       = "${var.project_id}"
  name          = "${var.project_id}-artifactory-gcsstore"
  location      = "${var.region}"
  storage_class = "REGIONAL"
  force_destroy = "true"
}
