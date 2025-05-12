resource "aws_instance" "web_1" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.public_subnet_1_id
  vpc_security_group_ids = [var.web_sg_id]
  key_name               = var.key_name

  user_data = file("${path.module}/user_data.sh")

  tags = {
    Name = "${var.project}-web-1"
  }
}

resource "aws_instance" "web_2" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.public_subnet_2_id
  vpc_security_group_ids = [var.web_sg_id]
  key_name               = var.key_name

  user_data = file("${path.module}/user_data.sh")

  tags = {
    Name = "${var.project}-web-2"
  }
}
