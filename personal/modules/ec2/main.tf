module "aws_vpc" {
  source                 = "../../modules/vpc"
  vpc_cidr               = var.vpc_cidr
  subnet_cidr            = var.subnet_cidr
}


data "aws_vpc" "vpc" {
  id = module.aws_vpc.vpc-id
}
data "aws_subnet" "subnet" {
  id = module.aws_vpc.subnet-id
}

resource "aws_security_group" "ledn" {
  description = "controls direct access to ledn hosts"
  vpc_id      = data.aws_vpc.vpc.id
  name        = "ledn_sg"
  tags = {
    Name = "ledn_sg"
  }

  ingress {
    protocol  = "tcp"
    from_port = "80"
    to_port   = "80"

    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol  = "tcp"
    from_port = 22
    to_port   = 22
    cidr_blocks = [
      "${var.myip}",
    ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}



resource "aws_instance" "ledn" {
  count                       = var.instance_count
  ami                         = var.ami
  instance_type               = var.instance_type
  associate_public_ip_address = var.public_ip
  user_data                   = data.template_file.user_data.rendered
  subnet_id                   = data.aws_subnet.subnet.id
  key_name                    = var.ssh_key_name
  tags = {
    Name = "ledn"
  }

  vpc_security_group_ids = [
    "${aws_security_group.ledn.id}",
  ]
  provisioner "file" {
    source      = "../files/"
    destination = "/home/ubuntu"
    connection {
      type     = "ssh"
      user     = "ubuntu"
      private_key = file("../ledn")
      host     = self.public_ip
  }
  }
  provisioner "remote-exec" {
    connection {
      type     = "ssh"
      user     = "ubuntu"
      private_key = file("../ledn")
      host     = self.public_ip
    }
    inline = [
      "sleep 120s",
      "sudo cp /home/ubuntu/rick-astley.jpg /var/www/images/;",
      "sudo cp /home/ubuntu/ledn.jpg /var/www/images/;",
      "cd /var/www && sudo chmod -R 755 images/",
      "sudo service nginx stop",
      "cd /etc/nginx/sites-available/ && sudo cp /home/ubuntu/default .",
      "sudo service nginx start;",
    ]
  }
}

