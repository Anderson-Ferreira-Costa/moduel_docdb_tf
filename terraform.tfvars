project_name            = "saude"
environment_name        = "dev"
cluster_name            = "documentdb"
instance_class          = "db.t3.medium"
engine_version          = "5.0.0"
instance_count          = "3"
backup_retention_period = "5"
region                  = "us-east-1"
vpc_id                  = "vpc-0c6a2040f6a986bd2"
subnet_ids = [
  "subnet-0892d92ce423af7b0",
  "subnet-0596f718037d7b1a2",
  "subnet-06db1b0c355505c89"
]
