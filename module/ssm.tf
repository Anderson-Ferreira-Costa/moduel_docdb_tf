resource "aws_ssm_parameter" "write_endpoint" {
  name  = "/${var.cluster_name}/${var.project_name}/${var.environment_name}/documentdb_endpoint"
  type  = "String"
  value = aws_docdb_cluster.default.endpoint
}

resource "aws_ssm_parameter" "read_endpoint" {
  name  = "/${var.cluster_name}/${var.project_name}/${var.environment_name}/documentdb_reader_endpoint"
  type  = "String"
  value = aws_docdb_cluster.default.reader_endpoint
}

resource "aws_ssm_parameter" "secret_name" {
  name  = "/${var.cluster_name}/${var.project_name}/${var.environment_name}/documentdb_secret_name"
  type  = "String"
  value = aws_secretsmanager_secret.default.arn
}