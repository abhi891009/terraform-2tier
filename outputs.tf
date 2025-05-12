output "vpc_id" {
  value = module.vpc.vpc_id
}

output "rds_endpoint" {
  value = module.rds.rds_endpoint
}

output "web_sg_id" {
  value = module.security_groups.web_sg_id
}

output "db_sg_id" {
  value = module.security_groups.db_sg_id
}
