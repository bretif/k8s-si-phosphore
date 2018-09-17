# Create k8s cluster
resource "google_container_cluster" "primary" {
  provider           = "google"
  name               = "k8s-si-{{ BRANCH_SHORT }}"
  description        = "PHOSPHORE.SI Information System (SI) k8s cluster"
  zone               = "{{ GKE_REGION_TEST }}"
  min_master_version = "1.10.7-gke.1"
  initial_node_count = "2"

  network = "default"

  # node pools will be replicated automatically to the additional zones
  # additional_zones = [
  #   "europe-west1-c"
  # ]

  # node configuration
  # NOTE: nodes created during the cluster creation become the default node pool
  node_config {
    machine_type = "n1-standard-1"

    labels {
      provider = "google"
      pool     = "default"
    }

    tags = ["k8s-si-{{ BRANCH_SHORT }}", "nodes"]
  }
}
