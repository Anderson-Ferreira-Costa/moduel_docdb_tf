resource "aws_secretsmanager_secret" "default" {
  name = "secret-${var.cluster_name}-${var.project_name}-${var.environment_name}-${random_id.server.id}"
  tags = local.tags
}

resource "aws_secretsmanager_secret_version" "default" {
  secret_id     = aws_secretsmanager_secret.default.id
  secret_string = jsonencode({ "username" = var.master_user_name, "password" = local.random_password })
}