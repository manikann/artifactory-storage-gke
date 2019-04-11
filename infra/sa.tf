resource "google_service_account" "artifactory_gcs" {
  project      = "${var.project_id}"
  account_id   = "artifactory-gcs-sa"
  display_name = "artifactory-gcs-sa"
}

resource "google_service_account_key" "artifactory_gcs_key" {
  service_account_id = "${google_service_account.artifactory_gcs.name}"
}

resource "google_storage_bucket_object" "copy-artifactory-gcs-key" {
  bucket = "${google_storage_bucket.artifactory_config.id}"
  name = "artifactory-gcs-sa.json"
  content = "${base64decode(google_service_account_key.artifactory_gcs_key.private_key)}"
  content_type = "application/json"
}
