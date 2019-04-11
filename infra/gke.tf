# Create GKE Private Cluster
data "google_container_engine_versions" "k8s_version" {
  project = "${var.project_id}"
  zone    = "${var.zone}"
}

resource "google_container_cluster" "cluster" {
  name               = "${var.name}"
  zone               = "${var.zone}"
  project            = "${var.project_id}"
  min_master_version = "${data.google_container_engine_versions.k8s_version.latest_master_version}"
  node_version       = "${data.google_container_engine_versions.k8s_version.latest_node_version}"

  # https://cloud.google.com/kubernetes-engine/docs/how-to/hardening-your-cluster#disable_abac
  enable_legacy_abac = false

  addons_config {
    # https://cloud.google.com/kubernetes-engine/docs/how-to/hardening-your-cluster#disable_kubernetes_dashboard
    kubernetes_dashboard {
      # Disable dashboard
      disabled = true
    }

    http_load_balancing {
      # enable http load balancing
      disabled = false
    }

    horizontal_pod_autoscaling {
      # enable horizontal pod autoscaler
      disabled = false
    }
  }

  node_pool {
    name               = "${var.name}-np"
    initial_node_count = "${var.initial_node_count}"

    autoscaling {
      min_node_count = "${var.min_node_count}"
      max_node_count = "${var.max_node_count}"
    }

    node_config {
      metadata {
        disable-legacy-endpoints = "true"
      }

      preemptible  = true
      image_type   = "COS"
      machine_type = "${var.node_instance_type}"
      disk_size_gb = "${var.node_disk_size_gb}"

      tags         = ["artifactory-nodes"]
      oauth_scopes = ["logging-write", "monitoring", "storage-ro"]
    }
  }
}

resource "google_project_iam_member" "cloudbuild-access-to-gke" {
  project = "${var.project_id}"
  role    = "roles/container.admin"
  member  = "serviceAccount:${data.google_project.this_projecct.number}@cloudbuild.gserviceaccount.com"
}

resource "google_project_iam_member" "cloudbuild-access-to-compute" {
  project = "${var.project_id}"
  role    = "roles/compute.networkViewer"
  member  = "serviceAccount:${data.google_project.this_projecct.number}@cloudbuild.gserviceaccount.com"
}

