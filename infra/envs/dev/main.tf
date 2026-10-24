module "network" {
  source = "../../modules/network"

  vpc_cidr            = var.vpc_cidr
  public_subnet_cidr  = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
}

module "ecs" {
  source = "../../modules/ecs"

  subnet_id         = module.network.private_subnet_id
  security_group_id = module.network.ecs_sg_id
}

module "rds" {
  source = "../../modules/rds"

  subnet_id         = module.network.private_subnet_id
  security_group_id = module.network.rds_sg_id

  db_instance_class       = var.db_instance_class
  backup_retention_period = var.backup_retention_period
  deletion_protection     = var.deletion_protection
}