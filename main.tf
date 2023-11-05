terraform {
    required_providers {
        docker = {
            source  = "kreuzwerker/docker"
            version = "2.15.0"
        }
    }
}

provider "docker" {
    # host = "unix:///var/run/docker.sock"
    # host = “ssh://devops-user@192.168.95.135:22” ssh_opts = [“-o”, “StrictHostKeyChecking=no”, “-o”, “UserKnownHostsFile=/dev/null”] 
    host = "tcp://devops-user@192.168.95.135:2375"
}

resource "docker_image" "nginx" {
    name = "nginx:latest"
    keep_locally = false
}

resource "docker_container" "nginx" {
    image = docker_image.nginx.latest
    name = "nginx"
    ports {
        internal = 80
        external = 8000
    }
}