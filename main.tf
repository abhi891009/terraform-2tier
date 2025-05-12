provider "aws" {
  region = var.region
}

module "vpc" {
  source    = "./modules/vpc"
  vpc_cidr  = var.vpc_cidr
  vpc_name  = var.vpc_name
}

module "subnets" {
  source                = "./modules/subnets"
  vpc_id                = module.vpc.vpc_id
  public_subnet_1_cidr  = var.public_subnet_1_cidr
  public_subnet_1_az    = var.public_subnet_1_az
  public_subnet_1_name  = var.public_subnet_1_name
  public_subnet_2_cidr  = var.public_subnet_2_cidr
  public_subnet_2_az    = var.public_subnet_2_az
  public_subnet_2_name  = var.public_subnet_2_name
  private_subnet_1_cidr = var.private_subnet_1_cidr
  private_subnet_1_az   = var.private_subnet_1_az
  private_subnet_1_name = var.private_subnet_1_name
  private_subnet_2_cidr = var.private_subnet_2_cidr
  private_subnet_2_az   = var.private_subnet_2_az
  private_subnet_2_name = var.private_subnet_2_name
}

module "internet_gateway" {
  source   = "./modules/internet_gateway"
  vpc_id   = module.vpc.vpc_id
  igw_name = var.igw_name
}

module "nat_gateway" {
  source           = "./modules/nat_gateway"
  public_subnet_id = module.subnets.public_subnet_1_id
  nat_gw_name      = var.nat_gw_name
}

module "route_tables" {
  source               = "./modules/route_tables"
  vpc_id               = module.vpc.vpc_id
  igw_id               = module.internet_gateway.igw_id
  public_rt_name       = var.public_rt_name
  public_subnet_1_id   = module.subnets.public_subnet_1_id
  public_subnet_2_id   = module.subnets.public_subnet_2_id
  nat_gw_id            = module.nat_gateway.nat_gw_id
  private_rt_name      = var.private_rt_name
  private_subnet_1_id  = module.subnets.private_subnet_1_id
  private_subnet_2_id  = module.subnets.private_subnet_2_id
}

module "security_groups" {
  source  = "./modules/security_groups"
  vpc_id  = module.vpc.vpc_id
  project = var.project
}

module "rds" {
  source             = "./modules/rds"
  project            = var.project
  private_subnet_ids = [module.subnets.private_subnet_1_id, module.subnets.private_subnet_2_id]
  instance_class     = var.rds_instance_class
  db_name            = var.db_name
  db_username        = var.db_username
  db_password        = var.db_password
  db_sg_id           = module.security_groups.db_sg_id
}
