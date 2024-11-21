build-postgres:
	docker build -t homelab-sql:latest ./App/sql

build-frontend:
	docker build -t homelab-frontend:latest ./App/frontend

build-backend:
	docker build -t homelab-backend:latest ./App/backend

build-all: build-postgres build-frontend build-backend