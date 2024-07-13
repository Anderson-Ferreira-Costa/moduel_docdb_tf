variable "project_name" {
  type        = string
  description = "(Required) Name of the project."
}

variable "cluster_name" {
  type        = string
  description = "(Required) This will be the name of the cluster."
}

variable "region" {
  type        = string
  description = "(Required) The region This is the region where the resources will be applied."
}

variable "environment_name" {
  type        = string
  description = "(Required) The name of the environment. must be `dev`, `hml`, `prd`."

  validation {
    condition     = contains(["dev", "hml", "prd"], var.environment_name)
    error_message = "Valid values for var: environment_name are (dev, hml, prd)."
  }
}

variable "master_user_name" {
  type        = string
  description = "(Required) Main user's username, which is stored in the Amazon Elasticsearch Service domain's internal database. Default `master`"
  default     = "master"
}

variable "vpc_id" {
  type        = string
  description = "(Required) Vpc id"
}

variable "subnet_ids" {
  type        = list(string)
  description = "(Required) List of subnet ids"

  validation {
    condition     = length(var.subnet_ids) >= 3
    error_message = "Subnet ids require minimum of 3 subnets."
  }
}

variable "tags" {
  type        = map(any)
  description = " (Optional) Map of tags to assign to the resource. If configured with a provider."
  default     = {}
}

variable "password_rotate_after_days" {
  type        = number
  description = "(Required) Specifies the number of days between automatic scheduled rotations of the secret. Default 30 days"
  default     = 30
}

variable "password_length" {
  type        = number
  description = "(Required) Specifies the length of password. Default 32"
  default     = 32
}

variable "log_retention" {
  type        = number
  description = "(Optional) Specifies the number of days you want to retain log events in the specified log group. Possible values are: 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827, 3653. If you select 0, the events in the log group are always retained and never expire."
  default     = 14
}

variable "rotate_lambda" {

  type = object({
    zip     = string
    handler = string
  })
  description = "(Required) Lambda responsable to rotate the password. Default zip = lambda_rotate.zip handler = main"
  default = {
    handler = "main"
    zip     = "lambda_rotate.zip"
  }
}



variable "instance_count" {
  type        = number
  description = "(Optional) Number of the instance that will contains in the cluster. Default: 1"
  default     = 1
}

variable "instance_class" {
  type        = string
  description = "(Required) The database engine version. Updating this argument results in an outage."

  validation {
    condition     = contains(["db.r6g.large", "db.r6g.xlarge", "db.r6g.2xlarge", "db.r6g.4xlarge", "db.r6g.12xlarge", "db.r6g.16xlarge", "db.r5.large", "db.r5.xlarge", "db.r5.2xlarge", "db.r5.4xlarge", "db.r5.12xlarge", "db.r5.24xlarge", "db.t3.medium"], var.instance_class)
    error_message = "You can use just some one these instances: 'db.r6g.large','db.r6g.xlarge','db.r6g.2xlarge','db.r6g.4xlarge','db.r6g.12xlarge', 'db.r6g.16xlarge','db.r5.large','db.r5.xlarge','db.r5.2xlarge','db.r5.4xlarge','db.r5.12xlarge','db.r5.24xlarge'."
  }
}

variable "engine_version" {
  type        = string
  description = "(Optional) The database engine version. Updating this argument results in an outage. Default: 4.0.0"
  default     = "0.0.0"

  validation {
    condition     = contains(["5.0.0", "4.0.0", "3.6.0"], var.engine_version)
    error_message = "You can use just some one these engine version: '5.0.0','4.0.0','3.6.0'."
  }
}

variable "engine" {
  type        = string
  description = "(Optional) The name of the database engine to be used for this DB cluster. Defaults to `docdb`. Valid Values: `docdb`"
  default     = "docdb"
}

variable "db_port" {
  type        = number
  description = "(Optional) The port on which the DB accepts connections"
  default     = 27017
}

variable "backup_retention_period" {
  type        = number
  description = "(Optional) The days to retain backups for. Default `5`"
  default     = 5
}

variable "preferred_backup_window" {
  type        = string
  description = "(Optional) The daily time range during which automated backups are created if automated backups are enabled using the BackupRetentionPeriod parameter.Time in UTC Default: 04:00-09:00"
  default     = "04:00-09:00"
}

variable "deletion_protection" {
  type        = bool
  description = "(Optional) A value that indicates whether the DB cluster has deletion protection enabled. The database can't be deleted when deletion protection is enabled. By default, deletion protection is disabled."
  default     = true
}


variable "enabled_cloudwatch_logs_exports" {
  type        = list(string)
  description = "(Optional) List of log types to export to cloudwatch. If omitted, no logs will be exported. The following log types are supported: `audit`, `profiler`."
  default     = null
}

variable "apply_immediately" {
  type        = bool
  description = "(Optional) Specifies whether any cluster modifications are applied immediately, or during the next maintenance window. Default is `true`."
  default     = true
}

variable "auto_minor_version_upgrade" {
  type        = bool
  description = "(Optional) Indicates that minor engine upgrades will be applied automatically to the DB instance during the maintenance window. Default is `true`."
  default     = true
}

variable "preferred_maintenance_window" {
  type        = string
  description = "(Optional) The window to perform maintenance in. Syntax: 'ddd:hh24:mi-ddd:hh24:mi'. Eg: 'Mon:00:00-Mon:03:00'. Default is null"
  default     = "Mon:01:00-Mon:04:00"
}