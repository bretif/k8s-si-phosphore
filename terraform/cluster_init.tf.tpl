# Create k8s init cluster
resource "google_container_cluster" "primary" {
  provider            = "google"
  name                = "k8s-si-{{ BRANCH_SHORT }}"
  description         = "PHOSPHORE.si Information System (SI) k8s cluster"
  zone                = "{{ GKE_REGION_TEST }}"
  min_master_version  = "1.10.7-gke.1"
  .initial_node_count = 2

  node_config {
    machine_type = "n1-standard-1"
  }
}
