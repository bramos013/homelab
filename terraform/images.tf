resource "docker_image" "web-sql" {
  name = "web-sql"

  build {
    context    = "../sql"
    dockerfile = "Dockerfile"
  }
}

resource "docker_image" "web-backend" {
  name = "web-backend"

  build {
    context    = "../backend"
    dockerfile = "Dockerfile"
  }
}

resource "docker_image" "web-frontend" {
  name = "web-frontend"

  build {
    context    = "../frontend"
    dockerfile = "Dockerfile"
  }
}
