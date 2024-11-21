resource "docker_network" "sql-network" {
  name   = "sql-network"
  driver = "bridge"
}

resource "docker_network" "frontend-network" {
  name = "frontend-network"
}
