resource "docker_volume" "sql-data" {
  name   = "homelab-sql-volume-data"
  driver = "local"
}

resource "docker_volume" "sql-logs" {
  name   = "homelab-sql-volume-logs"
  driver = "local"
}

resource "docker_volume" "sql-init" {
  name   = "homelab-sql-volume-init"
  driver = "local"
}

resource "docker_volume" "prometheus-data" {
  name   = "homelab-prometheus-volume-data"
  driver = "local"
}
