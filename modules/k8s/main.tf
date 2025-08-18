resource "google_service_account" "default" {
  account_id   = "${var.env}-k8s-sa"
  display_name = "${var.env}-k8s-sa"
  project = var.project
}

resource "google_container_cluster" "primary" {
  name     = "${var.env}-k8s-cluster"
  location = "${var.region}"
  project = var.project

  
  remove_default_node_pool = true
  initial_node_count       = 1
}

resource "google_container_node_pool" "primary_preemptible_nodes" {
  name       = "${var.env}-k8s-node-pool"
  location   = "${var.region}"
  cluster    = google_container_cluster.primary.name
  node_count = 1

  node_config {
    preemptible  = true
    machine_type = "e2-medium"

    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    service_account = google_service_account.default.email
    oauth_scopes    = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}