# Create k8s cluster
resource "google_container_cluster" "primary" {
  provider                 = "google"
  name                     = "k8s-si-{{ BRANCH_SHORT }}"
  zone                     = "{{ GKE_REGION_TEST }}"
  remove_default_node_pool = true

  node_pool {
    name = "default-pool"
  }
}

resource "google_container_node_pool" "primary_pool" {
  provider   = "google"
  name       = "primary-pool"
  cluster    = "${google_container_cluster.primary.name}"
  zone       = "{{ GKE_REGION_TEST }}"
  node_count = "2"

  node_config {
    machine_type = "n1-standard-1"

    labels {
      provider = "google"
      pool     = "primary"
    }

    tags = []

    management {
      auto_repair  = true
      auto_upgrade = true
    }

    autoscaling {
      min_node_count = 2
      max_node_count = 5
    }
  }
}
