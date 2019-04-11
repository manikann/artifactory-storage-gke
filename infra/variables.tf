variable "project_id" {
  description = "Service Project ID."
  default     = "clover-2103ca"
}

variable "region" {
  description = "GCP region."
  default     = "us-central1"
}

variable "zone" {
  description = "GCP region."
  default     = "us-central1-f"
}

variable "name" {
  description = "GKE name."
  default     = "artifactory-cluster"
}

variable "initial_node_count" {
  description = "Initial number of nodes to create in the node pool.  Changing this recreates the node pool"
  default     = 2
}

variable "min_node_count" {
  description = "Autoscaling min number of nodes"
  default     = 2
}

variable "max_node_count" {
  description = "Autoscaling max number of nodes"
  default     = 3
}

variable "node_instance_type" {
  description = "GCE instance type for the default node pool"
  type        = "string"
  default     = "n1-standard-4"
}

variable "node_disk_size_gb" {
  description = "Size of the disk attached to each node, specified in GB"
  default     = 100
}
