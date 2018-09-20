resource "google_container_cluster" "k8s_si_cluster" {
  provider           = "google"
  name               = "k8s-si-{{ BRANCH_SHORT }}"
  description        = "PHOSPHORE.si Information System (SI) k8s cluster"
  zone               = "{{ GKE_REGION_TEST }}"
  min_master_version = "1.10.7-gke.1"

  timeouts {
    create = "30m"
    update = "10m"
    delete = "40m"
  }
}

resource "google_container_node_pool" "primary-pool" {
  provider   = "google"
  name       = "primary-pool"
  cluster    = "${google_container_cluster.k8s_si_cluster.name}"
  zone       = "{{ GKE_REGION_TEST }}"
  node_count = "2"

  node_config {
    machine_type = "n1-standard-1"

    labels {
      provider = "google"
      pool     = "primary"
    }

    tags = ["k8s-si-{{ BRANCH_SHORT }}", "nodes", "primary-pool"]
  }

  management {
    auto_repair  = true
    auto_upgrade = true
  }

  autoscaling {
    min_node_count = 2
    max_node_count = 5
  }

  timeouts {
    create = "30m"
    update = "10m"
    delete = "40m"
  }
}
