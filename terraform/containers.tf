resource "docker_image" "homelab-sql" {
  name         = "homelab-sql:latest"
  keep_locally = true

}

resource "docker_image" "homelab-backend" {
  name         = "homelab-backend:latest"
  keep_locally = true
}

resource "docker_image" "homelab-frontend" {
  name         = "homelab-frontend:latest"
  keep_locally = true
}

resource "docker_container" "homelab-sql" {
  image    = docker_image.homelab-sql.image_id
  name     = "homelab-sql"
  restart  = "on-failure"
  hostname = "homelab-sql"

  env = [
    "POSTGRES_USER=${var.POSTGRES_USER}",
    "POSTGRES_PASSWORD=${var.POSTGRES_PASSWORD}",
    "POSTGRES_DB=${var.POSTGRES_DB}"
  ]

  networks_advanced {
    name = docker_network.sql-network.name
  }

  volumes {
    volume_name    = "homelab-sql-volume-logs"
    container_path = "/var/log/postgresql"
    host_path      = "/sql/log"
  }

  volumes {
    volume_name    = "homelab-sql-volume-data"
    container_path = "/var/lib/postgresql/data"
    host_path      = "/sql/data"
  }
}

resource "docker_container" "homelab-backend" {
  image    = docker_image.homelab-backend.image_id
  name     = "homelab-backend"
  restart  = "on-failure"
  hostname = "homelab-backend"
  depends_on = [
    docker_container.homelab-sql
  ]

  env = [

    "user=${var.user}",
    "pass=${var.pass}",
    "host=${var.host}",
    "db_port=${var.db_port}",
    "database=${var.database}"
  ]

  networks_advanced {
    name = docker_network.frontend-network.name
  }

  volumes {
    volume_name    = "homelab-backend-volume"
    container_path = "/usr/src/app"
    host_path      = "/backend"
  }
}

resource "docker_container" "homelab-frontend" {
  image    = docker_image.homelab-frontend.image_id
  name     = "homelab-frontend"
  restart  = "on-failure"
  hostname = "homelab-frontend"
  depends_on = [
    docker_container.homelab-sql,
    docker_container.homelab-backend
  ]

  networks_advanced {
    name = docker_network.frontend-network.name
  }

  networks_advanced {
    name = docker_network.sql-network.name
  }


  ports {
    internal = var.frontend_port
    external = var.frontend_port
  }

  volumes {
    volume_name    = "homelab-frontend-volume"
    container_path = "/usr/src/app"
    host_path      = "/frontend"
  }
}
