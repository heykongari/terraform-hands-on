output "instance_public_ip" { value = aws_instance.server.public_ip }
output "private_key_path" { value = local_file.private_key.filename }