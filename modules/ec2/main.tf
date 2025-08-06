# Generate an encrypted key.
resource "tls_private_key" "key-pair" {
    algorithm = "RSA"
    rsa_bits = 4096
}

# Create an aws-key-pair.
resource "aws_key_pair" "demo-key" {
    key_name = var.key_name
    public_key = tls_private_key.key-pair.public_key_openssh
}

# Save key-pair locally and change permission to read-only.
resource "local_file" "private_key" {
    content = tls_private_key.key-pair.private_key_pem
    filename = "${path.root}/${var.key_name}.pem"
    file_permission = "0400"
    lifecycle {
      prevent_destroy = false
    }
}

# Create a security group and authorize ssh and http access.
resource "aws_security_group" "demo-sg" {
    name = "demo-sg"
    vpc_id = var.vpc_id

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
    }

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = [ "0.0.0.0/0" ]
    }
}

# Create an ec2 instance, connect via ssh and install nginx in server.
resource "aws_instance" "server" {
    ami = var.ami_id
    instance_type = var.instance_type
    subnet_id = var.subnet_id
    vpc_security_group_ids = [aws_security_group.demo-sg.id]
    key_name = aws_key_pair.demo-key.key_name
    tags = { Name = "demo-server" }

    provisioner "remote-exec" {
        inline = [
            "sudo apt update -y",
            "sudo apt install -y nginx",
            "echo '<h1>Hello Terraform!</h1>' | sudo tee /var/www/html/index.html",
            "sudo systemctl start nginx"
        ]

        connection {
            type = "ssh"
            user = "ubuntu"
            host = self.public_ip
            private_key = tls_private_key.key-pair.private_key_pem
        }
    }
}