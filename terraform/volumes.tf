resource "docker_volume" "sql-data" {
  name   = "web-sql-volume-data"
  driver = "local"
}

resource "docker_volume" "sql-logs" {
  name   = "web-sql-volume-logs"
  driver = "local"
}

resource "docker_volume" "sql-init" {
  name   = "web-sql-volume-init"
  driver = "local"
}

resource "docker_volume" "prometheus-data" {
  name   = "web-prometheus-volume-data"
  driver = "local"
}
