terraform {
  required_version = "1.9.8"
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }
}

provider "docker" {
  host = "unix:///var/run/docker.sock"
}

resource "null_resource" "create-aliases" {
  depends_on = [
    docker_container.web-backend,
    docker_container.web-frontend,
  ]

  provisioner "local-exec" {
    command = "docker network connect --alias web-backend sql-network ${docker_container.web-backend.name}"
  }
}
