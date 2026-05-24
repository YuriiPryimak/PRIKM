terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
}

provider "docker" {}

resource "docker_container" "app_node" {
  name  = "app-node"
  image = "nginx:latest"
  ports { internal = 80; external = 8083 }
}

resource "docker_container" "monitor_node" {
  name  = "monitor-node"
  image = "prom/prometheus:latest"
  ports { internal = 9090; external = 9091 }
  volumes {
    host_path      = "/home/admin1/lab8_final/prometheus.yml"
    container_path = "/etc/prometheus/prometheus.yml"
  }
}
