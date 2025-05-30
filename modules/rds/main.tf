resource "aws_db_instance" "this" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class     = "db.t3.micro"
  db_name              = var.db_name
  username             = var.db_username
  password             = var.db_password
  skip_final_snapshot  = true
  db_subnet_group_name = aws_db_subnet_group.dummy.name

  tags = {
    Name = "MyDatabase"
  }
}

resource "aws_db_subnet_group" "dummy" {
  name       = "dummy"
  subnet_ids = [var.private_subnet_id_1,var.private_subnet_id_2]

}