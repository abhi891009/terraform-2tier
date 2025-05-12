output "web_1_public_ip" {
  value = aws_instance.web_1.public_ip
}

output "web_2_public_ip" {
  value = aws_instance.web_2.public_ip
}
