variable "POSTGRES_USER" {
  type    = string
  default = ""
}

variable "POSTGRES_PASSWORD" {
  type    = string
  default = ""
}

variable "POSTGRES_DB" {
  type    = string
  default = ""
}

variable "user" {
  type    = string
  default = ""
}

variable "pass" {
  type    = string
  default = ""
}

variable "host" {
  type    = string
  default = "web-sql"
}

variable "db_port" {
  type    = number
  default = 5432
}

variable "database" {
  type    = string
  default = ""
}

variable "frontend_port" {
  type    = number
  default = 80
}
