resource "docker_container" "web-sql" {
  image   = docker_image.web-sql.image_id
  name    = "web-sql"
  restart = "on-failure"

  env = [
    "POSTGRES_USER=${var.POSTGRES_USER}",
    "POSTGRES_PASSWORD=${var.POSTGRES_PASSWORD}",
    "POSTGRES_DB=${var.POSTGRES_DB}"
  ]

  networks_advanced {
    name = docker_network.sql-network.name
  }

  volumes {
    volume_name    = "web-sql-volume-logs"
    container_path = "/var/log/postgresql"
    host_path      = "/sql/log"
  }

  volumes {
    volume_name    = "web-sql-volume-data"
    container_path = "/var/lib/postgresql/data"
    host_path      = "/sql/data"
  }
}

resource "docker_container" "web-backend" {
  image   = docker_image.web-backend.image_id
  name    = "web-backend"
  restart = "on-failure"
  depends_on = [
    docker_container.web-sql
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
    volume_name    = "web-backend-volume"
    container_path = "/usr/src/app"
    host_path      = "/backend"
  }
}

resource "docker_container" "web-frontend" {
  image   = docker_image.web-frontend.image_id
  name    = "web-frontend"
  restart = "on-failure"
  depends_on = [
    docker_container.web-sql,
    docker_container.web-backend
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
    volume_name    = "web-frontend-volume"
    container_path = "/usr/src/app"
    host_path      = "/frontend"
  }
}
