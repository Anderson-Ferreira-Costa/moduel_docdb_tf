provider "aws" {
  region = var.region
}

module "default" {
  source                  = "./module/"
  region                  = var.region
  cluster_name            = var.cluster_name
  project_name            = var.project_name
  environment_name        = var.environment_name
  engine_version          = var.engine_version
  backup_retention_period = var.backup_retention_period
  vpc_id                  = var.vpc_id
  subnet_ids              = var.subnet_ids
  instance_class          = var.instance_class
  instance_count          = var.instance_count
  tags                    = local.tags
}



