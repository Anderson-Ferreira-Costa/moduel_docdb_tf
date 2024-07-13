locals {
  random_password    = random_password.password.result
  subnet_name        = "subnets-${var.cluster_name}-${var.environment_name}"
  cluster_identifier = "${var.cluster_name}-${var.environment_name}-${random_id.server.hex}"

  tags = {
    Environment = var.environment_name
    Cluster     = var.cluster_name
    Project     = var.project_name
  }
}

resource "random_password" "password" {
  length  = var.password_length
  special = false
}

resource "random_id" "server" {
  byte_length = 8
}

data "aws_caller_identity" "current" {}
