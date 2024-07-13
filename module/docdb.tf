resource "aws_docdb_cluster" "default" {
  cluster_identifier              = local.cluster_identifier
  engine                          = var.engine
  engine_version                  = var.engine_version
  port                            = var.db_port
  master_username                 = var.master_user_name
  master_password                 = local.random_password
  backup_retention_period         = var.backup_retention_period
  preferred_backup_window         = var.preferred_backup_window
  deletion_protection             = var.deletion_protection
  vpc_security_group_ids          = [aws_security_group.default.id]
  db_subnet_group_name            = aws_docdb_subnet_group.default.name
  final_snapshot_identifier       = "${local.cluster_identifier}-final"
  storage_encrypted               = true
  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports
  apply_immediately               = var.apply_immediately
  tags                            = merge(var.tags, local.tags)
}

resource "aws_docdb_cluster_instance" "default" {
  count                        = var.instance_count
  identifier                   = "${var.cluster_name}-${count.index}"
  cluster_identifier           = aws_docdb_cluster.default.id
  preferred_maintenance_window = var.preferred_maintenance_window
  instance_class               = var.instance_class
  auto_minor_version_upgrade   = var.auto_minor_version_upgrade
  apply_immediately            = var.apply_immediately
  tags                         = merge(var.tags, local.tags)
}


resource "aws_docdb_subnet_group" "default" {
  name        = local.subnet_name
  description = "Allowed subnets for DB cluster instances"
  subnet_ids  = var.subnet_ids
  tags        = local.tags
}
